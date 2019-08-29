import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/alert_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

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
    if (purchase.error != null) {
      return null;
    }

    Navigator.pop(context);

    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.selectedCompany;
    final webClient = WebClient();
    final data = {
      'order_id': purchase.purchaseID,
      'product_id': purchase.productID,
      'timestamp': purchase.transactionDate,
    };

    try {
      final dynamic response = await webClient.post(
          '/api/v1/upgrade', company.token, json.encode(data));
      final String message = response['message'];

      if (message == 'success') {
        showDialog<MessageDialog>(
            context: context,
            builder: (BuildContext context) {
              return MessageDialog(localization.thankYouForYourPurchase,
                  onDismiss: () {
                store.dispatch(RefreshData(
                  platform: getPlatform(context),
                ));
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

    super.initState();
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
    final company = store.state.selectedCompany;

    InAppPurchaseConnection.instance.buyNonConsumable(
        purchaseParam: PurchaseParam(
      productDetails: productDetails,
      applicationUserName: company.companyKey,
      sandboxTesting: false,
    ));
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
      title: Text(localization.annualSubscription),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
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
          ElevatedButton(
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
                    title: Text(productDetails.title),
                    subtitle: Text(productDetails.description),
                    trailing: Text(productDetails.price,
                        style: TextStyle(fontSize: 18)),
                    onTap: () => upgrade(context, productDetails),
                  ))
              .toList()
      ],
    );
  }
}
