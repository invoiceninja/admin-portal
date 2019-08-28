import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/alert_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class UpgradeDialog extends StatefulWidget {
  @override
  _UpgradeDialogState createState() => _UpgradeDialogState();
}

class _UpgradeDialogState extends State<UpgradeDialog> {
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> products;

  Future<void> redeemPurchase(PurchaseDetails purchase) async {
    print('redeemPurchase: ${purchase.purchaseID}');
    if (purchase.error != null) {
      return null;
    }

    final store = StoreProvider.of<AppState>(context);
    final company = store.state.selectedCompany;
    final webClient = WebClient();
    final data = {
      'order_id': purchase.purchaseID,
      'product_id': purchase.productID,
      'timestamp': purchase.transactionDate,
    };
    
    final String response =
        await webClient.post('/api/v1/upgrade', company.token, json.encode(data));

    print('response: $response');

    if (response == 'success') {
      showDialog<MessageDialog>(
          context: context,
          builder: (BuildContext context) {
            return MessageDialog(response, onDismiss: () {
              store.dispatch(RefreshData(
                platform: getPlatform(context),
              ));
            });
          });
    }
  }

  @override
  void initState() {
    final Stream purchaseUpdates =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;

    InAppPurchaseConnection.instance
        .queryPastPurchases()
        .then((response) async {
      for (PurchaseDetails purchase in response.pastPurchases) {
        await redeemPurchase(purchase);
        if (Platform.isIOS) {
          InAppPurchaseConnection.instance.completePurchase(purchase);
        }
      }
    });

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

    setState(() {
      products = response.productDetails;
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

    if (products == null) {
      return LoadingIndicator(height: 50);
    }

    return SimpleDialog(
      title: Text(localization.annualSubscription),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      children: products.reversed
          .map((productDetails) => ListTile(
                title: Text(productDetails.title),
                subtitle: Text(productDetails.description),
                trailing:
                    Text(productDetails.price, style: TextStyle(fontSize: 18)),
                onTap: () => upgrade(context, productDetails),
              ))
          .toList(),
    );
  }
}
