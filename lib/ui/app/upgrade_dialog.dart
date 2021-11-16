/*
// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/alert_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
*/

import 'package:flutter/material.dart';

class UpgradeDialog extends StatelessWidget {
  const UpgradeDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}

/*

class UpgradeDialog extends StatefulWidget {
  @override
  _UpgradeDialogState createState() => _UpgradeDialogState();
}

class _UpgradeDialogState extends State<UpgradeDialog> {
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products;
  List<PurchaseDetails> _purchases;
  bool _showPastPurchases = false;

  Future<void> loadPurchases() async {
    InAppPurchaseConnection.instance
        .queryPastPurchases()
        .then((response) async {
      if (response.pastPurchases != null && response.pastPurchases.isNotEmpty) {
        setState(() {
          _purchases = response.pastPurchases;
        });
      }
    });
  }

  Future<void> redeemPurchase(PurchaseDetails purchase) async {
    if (purchase.error != null || purchase.purchaseID == null) {
      return null;
    }

    //Navigator.pop(context);

    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final webClient = WebClient();
    final data = {
      'order_id': purchase.purchaseID,
      'product_id': purchase.productID,
      'timestamp': (int.parse(purchase.transactionDate) / 1000).floor(),
    };

    try {
      final dynamic response = await webClient
          .post(
        '$kAppProductionUrl/api/v1/upgrade',
        state.credentials.token,
        data: json.encode(data),
      )
          .catchError((dynamic error) {
        showErrorDialog(context: context, message: error);
      });
      final String message = response['message'];

      if (message == 'success') {
        showDialog<MessageDialog>(
            context: context,
            builder: (BuildContext context) {
              return MessageDialog(localization.thankYouForYourPurchase,
                  onDismiss: () {
                store.dispatch(RefreshData());
              });
            });

        if (Platform.isIOS) {
          InAppPurchaseConnection.instance.completePurchase(purchase);
        }
      } else {
        showDialog<ErrorDialog>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(message);
            });
      }
    } catch (error) {
      showDialog<ErrorDialog>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(error);
          });
    }
  }

  @override
  void initState() {
    super.initState();

    final Stream purchaseUpdates =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;

    _subscription = purchaseUpdates.listen((dynamic purchases) {
      (purchases as List<PurchaseDetails>).forEach((purchase) async {
        await redeemPurchase(purchase);
      });
    }, onDone: () {
      _subscription.cancel();
      _subscription = null;
    }, onError: (dynamic error) {
      showDialog<ErrorDialog>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(error);
          });
    });

    initStore();
  }

  void initStore() async {
    final bool available = await InAppPurchaseConnection.instance.isAvailable();

    if (!available) {
      showDialog<ErrorDialog>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog('Store is not available');
          });
      return;
    }

    final productIds = Set<String>.from(kProductPlans);
    final ProductDetailsResponse response =
        await InAppPurchaseConnection.instance.queryProductDetails(productIds);

    await loadPurchases();

    setState(() {
      _products = response.productDetails;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void upgrade(BuildContext context, ProductDetails productDetails) {
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.company;

    InAppPurchaseConnection.instance.buyNonConsumable(
        purchaseParam: PurchaseParam(
      productDetails: productDetails,
      applicationUserName: company.companyKey,
      sandboxTesting: false,
    ));
  }

  String convertPlanToString(String plan) {
    switch (plan) {
      case kProductPlanPro:
        return 'Pro - 1 User';
      case kProductPlanEnterprise2:
        return 'Enterprise - 2 Users';
      case kProductPlanEnterprise5:
        return 'Enterprise - 5 Users';
      case kProductPlanEnterprise10:
        return 'Enterprise - 10 Users';
      case kProductPlanEnterprise20:
        return 'Enterprise - 20 Users';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    if (_products == null) {
      return LoadingIndicator(height: 50);
    }

    _products.sort((product1, product2) =>
        parseDouble(product1.price) > parseDouble(product2.price) ? 1 : -1);

    return SimpleDialog(
      title: Column(
        children: <Widget>[
          Text(localization.annualSubscription),
          if (Platform.isIOS)
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: Text(
                'Payment will be charged to iTunes Account at confirmation of purchase. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period. Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal. Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user\'s Account Settings after purchase.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton(
                child: Text('Terms', style: TextStyle(fontSize: 12)),
                onPressed: () => launch(kTermsOfServiceURL),
              ),
              TextButton(
                child: Text('Privacy', style: TextStyle(fontSize: 12)),
                onPressed: () => launch(kPrivacyPolicyURL),
              ),
            ],
          )
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      children: [
        if (_showPastPurchases)
          ..._purchases.map((purchase) => ListTile(
                title: Text(purchase.purchaseID),
                subtitle: Text(formatDate(
                    convertTimestampToDateString(
                        (int.parse(purchase.transactionDate) / 1000).floor()),
                    context)),
                onTap: () => redeemPurchase(purchase),
              )),
        if (_purchases != null)
          AppButton(
            label: _showPastPurchases
                ? localization.back
                : localization.pastPurchases,
            onPressed: () {
              setState(() {
                _showPastPurchases = !_showPastPurchases;

                if (_showPastPurchases) {
                  loadPurchases();
                }
              });
            },
          ),
        if (!_showPastPurchases)
          ..._products
              .map((productDetails) => ListTile(
                    title: Text(productDetails.title ??
                        convertPlanToString(productDetails.id)),
                    subtitle: Text(productDetails.description ?? ''),
                    trailing: Text(productDetails.price ?? '',
                        style: TextStyle(fontSize: 18)),
                    onTap: () => upgrade(context, productDetails),
                  ))
              .toList()
      ],
    );
  }
}
*/
