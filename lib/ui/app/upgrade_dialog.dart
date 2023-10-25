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
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:url_launcher/url_launcher.dart';

class UpgradeDialog extends StatefulWidget {
  @override
  State<UpgradeDialog> createState() => _UpgradeDialogState();
}

class _UpgradeDialogState extends State<UpgradeDialog> {
  final _scrollController = ScrollController();
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // handle error here.
    });
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

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(kProductPlans.toSet());
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                _buildProductList(),
              ],
            ),
          ),
        ),
      );
    } else {
      stack.add(Center(
        child: Text(_queryProductError!),
      ));
    }
    if (_purchasePending) {
      stack.add(
        Stack(
          children: const <Widget>[
            Opacity(
              opacity: 0.3,
              child: ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }

    return AlertDialog(
      title: Text(localization.upgrade),
      content: Column(
        children: [
          Expanded(child: Stack(children: stack)),
        ],
      ),
      actions: [
        if (!_loading)
          TextButton(
              onPressed: () {
                _inAppPurchase.restorePurchases();
              },
              child: Text(localization.restorePurchases)),
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
              title: Text('Fetching products...')));
    }
    if (!_isAvailable) {
      return const Card();
    }
    final List<ListTile> productList = <ListTile>[];
    final store = StoreProvider.of<AppState>(context);
    final account = store.state.account;

    final Map<String, PurchaseDetails> purchases =
        Map<String, PurchaseDetails>.fromEntries(
            _purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));
    _products.sort((p1, p2) => p1.rawPrice.compareTo(p2.rawPrice));
    productList.addAll(_products.map(
      (ProductDetails productDetails) {
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
                  // ignore: deprecated_member_use
                  primary: Colors.white,
                ),
                onPressed: () {
                  if (previousPurchase != null) {
                    confirmPriceChange(context);
                  } else {
                    PurchaseParam purchaseParam;

                    if (Platform.isAndroid) {
                      purchaseParam = GooglePlayPurchaseParam(
                          productDetails: productDetails,
                          applicationUserName: account.id);
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
                child: Text(previousPurchase != null
                    ? AppLocalization.of(context)!.activate
                    : productDetails.price),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    ));

    return Column(children: productList);
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    setState(() {
      _purchases.add(purchaseDetails);
      _purchasePending = false;
    });

    //final navigator = Navigator.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final url = (state.isStaging ? kAppStagingUrl : kAppProductionUrl) +
        '/api/admin/subscription';

    var purchaseID = purchaseDetails.purchaseID;
    if (purchaseDetails is AppStorePurchaseDetails) {
      final originalTransaction =
          purchaseDetails.skPaymentTransaction.originalTransaction;
      if (originalTransaction != null) {
        purchaseID = originalTransaction.transactionIdentifier;
      }
    }

    final data = {
      'inapp_transaction_id': purchaseID,
      'key': state.account.key,
      'plan': purchaseDetails.productID.replaceAll('-', '_'),
      'plan_paid': (int.parse(purchaseDetails.transactionDate!) / 1000).floor(),
    };

    await WebClient()
        .post(url, state.credentials.token, data: jsonEncode(data));

    store.dispatch(RefreshData());

    /*
    if (navigator.canPop()) {
      navigator.pop();
    }
     */
  }

  void handleError(IAPError? error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          deliverProduct(purchaseDetails);
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
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
