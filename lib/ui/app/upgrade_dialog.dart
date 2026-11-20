// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/beta_promo/beta_promo_strings.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:url_launcher/url_launcher.dart';

/// Restores a subscription bought in this app ([restoreOnly], from account
/// management), or sells one.
///
/// The selling mode is reachable only from the debug long-press on the about
/// dialog's app name, on purpose: plans aren't sold in this app any more, and
/// that keeps a way to test a purchase's delivery in a debug build.
class UpgradeDialog extends StatefulWidget {
  const UpgradeDialog({Key? key, this.restoreOnly = false}) : super(key: key);

  /// Only restores a subscription bought in this app, new plans are bought in
  /// the new app
  final bool restoreOnly;

  @override
  State<UpgradeDialog> createState() => _UpgradeDialogState();
}

/// What became of a purchase sent to the server, which decides whether the
/// store is told it's finished
enum PurchaseDelivery {
  /// The plan was applied, finish the purchase
  applied,

  /// The server won't ever apply it (409 / 422: a sandbox purchase, one
  /// linked to another account, one it can't verify). Apple's is finished so
  /// it stops being delivered again; Google's is left unacknowledged, which
  /// Play refunds.
  refused,

  /// A server or network error, left unfinished so the store delivers it
  /// again
  retry,
}

/// The HTTP status at the start of an error thrown by WebClient, which reads
/// "<status>: <reason> • <message>", null for a network error
int? purchaseErrorStatus(String error) {
  final match = RegExp(r'^(\d{3}): ').firstMatch(error);

  return match == null ? null : int.tryParse(match.group(1)!);
}

/// The server's own message from an error thrown by WebClient, without the
/// status and the reason phrase in front of it
String purchaseErrorMessage(String error) => error
    .replaceFirst(RegExp(r'^\d{3}: '), '')
    .replaceFirst(RegExp(r'^[^\n•]* • '), '')
    .trim();

PurchaseDelivery purchaseDeliveryFor(int? status) =>
    status == 409 || status == 422
    ? PurchaseDelivery.refused
    : PurchaseDelivery.retry;

class _UpgradeDialogState extends State<UpgradeDialog> {
  final _scrollController = ScrollController();
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  bool _isRestoring = false;
  String? _queryProductError;
  String? _statusMessage;
  Timer? _restoreTimer;

  static const _strings = BetaPromoStrings();

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (List<PurchaseDetails> purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        _subscription.cancel();
      },
      onError: (Object error) {
        // handle error here.
      },
    );
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    if (widget.restoreOnly) {
      setState(() {
        _isAvailable = isAvailable;
        _loading = false;
      });
      return;
    }

    final ProductDetailsResponse productDetailResponse = await _inAppPurchase
        .queryProductDetails(kProductPlans.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _purchasePending = false;
      _loading = false;
    });
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    _restoreTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _restore() async {
    setState(() {
      _isRestoring = true;
      _statusMessage = _strings.get(BetaStr.restoreChecking);
    });

    try {
      await _inAppPurchase.restorePurchases();
    } catch (error) {
      if (mounted) {
        setState(() {
          _isRestoring = false;
          _statusMessage = '$error';
        });
      }
      return;
    }

    // The store sends nothing at all when there's nothing to restore
    _restoreTimer?.cancel();
    _restoreTimer = Timer(const Duration(seconds: 15), () {
      if (mounted && _isRestoring) {
        setState(() {
          _isRestoring = false;
          _statusMessage = _strings.get(BetaStr.restoreNoneFound);
        });
      }
    });
  }

  // English and left to right like the rest of the move copy, so nothing
  // from AppLocalization, not even the buttons
  Widget _buildRestoreOnly(BuildContext context) {
    final statusMessage = _statusMessage;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: _buildRestoreOnlyDialog(context, statusMessage),
    );
  }

  Widget _buildRestoreOnlyDialog(BuildContext context, String? statusMessage) {
    return AlertDialog(
      title: Text(_strings.get(BetaStr.restorePurchases)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            !_loading && !_isAvailable
                ? _strings.get(BetaStr.storeUnavailable)
                : _strings.get(BetaStr.restoreBody),
          ),
          if (_loading || _isRestoring || statusMessage != null) ...[
            SizedBox(height: 20),
            Row(
              children: [
                if (_loading || _isRestoring) ...[
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 12),
                ],
                if (statusMessage != null) Expanded(child: Text(statusMessage)),
              ],
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(_strings.get(BetaStr.close).toUpperCase()),
        ),
        if (!_loading && _isAvailable)
          TextButton(
            onPressed: _isRestoring ? null : _restore,
            child: Text(_strings.get(BetaStr.restorePurchases).toUpperCase()),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.restoreOnly) {
      return _buildRestoreOnly(context);
    }

    final localization = AppLocalization.of(context)!;
    final List<Widget> stack = <Widget>[];
    if (_queryProductError == null) {
      stack.add(
        Container(
          width: isDesktopOS() ? 400 : double.maxFinite,
          child: Scrollbar(
            thumbVisibility: true,
            controller: _scrollController,
            child: ListView(
              controller: _scrollController,
              children: <Widget>[
                if (Platform.isIOS)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Payment will be charged to iTunes Account at confirmation of purchase. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period. Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal. Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user\'s Account Settings after purchase.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                if (_statusMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(_statusMessage!),
                  ),
                _buildProductList(),
              ],
            ),
          ),
        ),
      );
    } else {
      stack.add(Center(child: Text(_queryProductError!)));
    }
    if (_purchasePending) {
      stack.add(
        Stack(
          children: const <Widget>[
            Opacity(
              opacity: 0.3,
              child: ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(child: CircularProgressIndicator()),
          ],
        ),
      );
    }

    return AlertDialog(
      title: Text(localization.upgrade),
      content: Column(
        children: [Expanded(child: Stack(children: stack))],
      ),
      actions: [
        if (!_loading)
          TextButton(
            onPressed: _isRestoring ? null : _restore,
            child: Text(localization.restorePurchases),
          ),
        TextButton(
          child: Text(localization.termsOfService),
          onPressed: () => launchUrl(Uri.parse(kTermsOfServiceURL)),
        ),
        TextButton(
          child: Text(localization.privacyPolicy),
          onPressed: () => launchUrl(Uri.parse(kPrivacyPolicyURL)),
        ),
      ],
    );
  }

  Widget _buildProductList() {
    if (_loading) {
      return const Card(
        child: ListTile(
          leading: CircularProgressIndicator(),
          title: Text('Fetching products...'),
        ),
      );
    }
    if (!_isAvailable) {
      return const Card();
    }
    final List<ListTile> productList = <ListTile>[];
    final store = StoreProvider.of<AppState>(context);
    final account = store.state.account;

    final Map<String, PurchaseDetails> purchases =
        Map<String, PurchaseDetails>.fromEntries(
          // Only purchases the server applied, finishing them is left to
          // _listenToPurchaseUpdated
          _purchases.map((PurchaseDetails purchase) {
            return MapEntry<String, PurchaseDetails>(
              purchase.productID,
              purchase,
            );
          }),
        );
    _products.sort((p1, p2) => p1.rawPrice.compareTo(p2.rawPrice));
    productList.addAll(
      _products.map((ProductDetails productDetails) {
        final PurchaseDetails? previousPurchase = purchases[productDetails.id];

        return ListTile(
          title: Text(productDetails.description),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green[800],
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (previousPurchase != null) {
                    confirmPriceChange(context);
                  } else {
                    PurchaseParam purchaseParam;

                    if (Platform.isAndroid) {
                      purchaseParam = GooglePlayPurchaseParam(
                        productDetails: productDetails,
                        applicationUserName: account.id,
                      );
                    } else {
                      purchaseParam = PurchaseParam(
                        productDetails: productDetails,
                        applicationUserName: account.id,
                      );
                    }

                    _inAppPurchase.buyNonConsumable(
                      purchaseParam: purchaseParam,
                    );
                  }
                },
                child: Text(
                  previousPurchase != null
                      ? AppLocalization.of(context)!.activate
                      : productDetails.price,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      }),
    );

    return Column(children: productList);
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  Future<PurchaseDelivery> deliverProduct(
    PurchaseDetails purchaseDetails,
  ) async {
    // The server verifies the purchase with the store before applying it
    setState(() {
      _purchasePending = false;
    });

    //final navigator = Navigator.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final url =
        (state.isStaging ? kAppStagingUrl : kAppProductionUrl) +
        '/api/admin/subscription';

    final purchaseID = _inAppTransactionId(purchaseDetails);
    if (purchaseID == null || purchaseID.isEmpty) {
      // The server requires a non-empty string; posting null just 422s.
      // Finished, as it always has been, there's nothing to send again.
      return PurchaseDelivery.applied;
    }

    final data = {
      'inapp_transaction_id': purchaseID,
      'key': state.account.key,
      'plan': purchaseDetails.productID.replaceAll('-', '_'),
    };

    try {
      await WebClient().post(
        url,
        state.credentials.token,
        data: jsonEncode(data),
      );
    } catch (error) {
      final delivery = purchaseDeliveryFor(purchaseErrorStatus('$error'));
      final message = purchaseErrorMessage('$error');

      if (mounted) {
        setState(() {
          _isRestoring = false;
          _statusMessage = message.isNotEmpty
              ? message
              : _strings.get(BetaStr.purchaseNotApplied);
        });
      }

      return delivery;
    }

    if (mounted) {
      setState(() {
        _purchases.add(purchaseDetails);
        _isRestoring = false;
        _statusMessage = _strings.get(BetaStr.purchaseLinked);
      });
    }

    store.dispatch(RefreshData());

    /*
    if (navigator.canPop()) {
      navigator.pop();
    }
     */

    return PurchaseDelivery.applied;
  }

  /// The value the hosted endpoint stores as `accounts.inapp_transaction_id`.
  ///
  /// Apple keys its renewal / cancellation / refund notifications on the
  /// subscription's **original** transaction id and the server matches that
  /// exactly, so storing a per-transaction id silently orphans the account —
  /// later notifications find no match and the plan stops being extended. For
  /// an initial purchase the two are identical; they diverge on restore and on
  /// renewals, which both reach here.
  ///
  /// Google is the opposite: its notifications resolve to the `orderId` that
  /// already arrives as [PurchaseDetails.purchaseID], so Android falls through
  /// unchanged.
  String? _inAppTransactionId(PurchaseDetails purchaseDetails) {
    if (purchaseDetails is AppStorePurchaseDetails) {
      // StoreKit 1 — only reached if `enableStoreKit1()` is ever called.
      // `originalTransaction` is populated for restored transactions only.
      final originalTransaction =
          purchaseDetails.skPaymentTransaction.originalTransaction;
      if (originalTransaction != null) {
        return originalTransaction.transactionIdentifier;
      }
    } else {
      // StoreKit 2 (the plugin default) drops `originalId` when it builds
      // SK2PurchaseDetails, but Apple's own transaction JSON is passed through
      // as `localVerificationData` and still carries it. Google's equivalent
      // JSON has no such key, so Android returns null here and falls back to
      // `purchaseID`.
      final original = _appleOriginalTransactionId(
        purchaseDetails.verificationData.localVerificationData,
      );
      if (original != null) {
        return original;
      }
    }
    return purchaseDetails.purchaseID;
  }

  /// Pulls Apple's `originalTransactionId` out of a StoreKit 2 transaction's
  /// `localVerificationData` — Apple's `Transaction.jsonRepresentation`.
  ///
  /// Returns null when the payload is empty, isn't a JSON object, or carries no
  /// usable `originalTransactionId`. Never throws: this runs inside the
  /// purchase-stream callback, where an exception would take down delivery of a
  /// paid purchase. Apple documents the field as a string but encodes some
  /// numeric ids as JSON numbers, so both are accepted.
  String? _appleOriginalTransactionId(String localVerificationData) {
    if (localVerificationData.isEmpty) {
      return null;
    }
    try {
      final decoded = jsonDecode(localVerificationData);
      if (decoded is! Map<String, dynamic>) {
        return null;
      }
      final value = decoded['originalTransactionId'];
      if (value == null) {
        return null;
      }
      final id = value is String ? value : value.toString();
      return id.isEmpty ? null : id;
    } catch (_) {
      return null;
    }
  }

  void handleError(IAPError? error) {
    setState(() {
      _purchasePending = false;
      if (_isRestoring) {
        _isRestoring = false;
        _statusMessage = error?.message;
      }
    });
  }

  Future<void> _listenToPurchaseUpdated(
    List<PurchaseDetails> purchaseDetailsList,
  ) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final delivery = await deliverProduct(purchaseDetails);

          if (delivery == PurchaseDelivery.retry ||
              (delivery == PurchaseDelivery.refused && !isApple())) {
            continue;
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> confirmPriceChange(BuildContext context) async {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iapStoreKitPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
    }
  }
}

/// Example implementation of the
/// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
///
/// The payment queue delegate can be implementated to provide information
/// needed to complete transactions.
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
    SKPaymentTransactionWrapper transaction,
    SKStorefrontWrapper storefront,
  ) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
