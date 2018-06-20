import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:invoiceninja/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja/ui/dashboard/dashboard_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

class DashboardScreen extends StatelessWidget {

  static final String route = '/dashboard';

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var store = StoreProvider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).dashboard),
      ),
      drawer: AppDrawerBuilder(),
      body: DashboardBuilder(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => SimpleDialog(children: <Widget>[
              ListTile(
                dense: true,
                leading: Icon(Icons.add_circle_outline),
                title: Text(localization.client),
                onTap: () {
                  Navigator.of(context).pop();
                  store.dispatch(EditClient(
                      client: ClientEntity(),
                      context: context));
                },
              ),
              ListTile(
                dense: true,
                leading: Icon(Icons.add_circle_outline),
                title: Text(localization.product),
                onTap: () {
                  Navigator.of(context).pop();
                  store.dispatch(EditProduct(
                      product: ProductEntity(),
                      context: context));
                },
              ),
              ListTile(
                dense: true,
                leading: Icon(Icons.add_circle_outline),
                title: Text(localization.invoice),
                onTap: () {
                  Navigator.of(context).pop();
                  store.dispatch(EditInvoice(
                      invoice: InvoiceEntity(),
                      context: context));
                },
              ),
              /*
              ListTile(
                dense: true,
                leading: Icon(Icons.add_circle_outline),
                title: Text(localization.payment),
                onTap: () {
                  Navigator.of(context).pop();
                  store.dispatch(EditInvoice(
                      invoice: InvoiceEntity(),
                      context: context));
                },
              ),
              */
            ]),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        tooltip: localization.create,
      ),
    );
  }
}
