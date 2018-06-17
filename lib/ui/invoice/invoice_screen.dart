import 'package:invoiceninja/ui/app/app_search.dart';
import 'package:invoiceninja/ui/app/app_search_button.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/invoice/invoice_list_vm.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja/ui/app/app_bottom_bar.dart';

class InvoiceScreen extends StatelessWidget {
  static final String route = '/invoices';

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    var localization = AppLocalization.of(context);

    return Scaffold(
      appBar: AppBar(
        title: AppSearch(
          entityType: EntityType.invoice,
          onSearchChanged: (value) {
            store.dispatch(SearchInvoices(value));
          },
        ),
        actions: [
          AppSearchButton(
            entityType: EntityType.invoice,
            onSearchPressed: (value) {
              store.dispatch(SearchInvoices(value));
            },
          ),
        ],
      ),
      drawer: AppDrawerBuilder(),
      body: InvoiceListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.invoice,
        onSelectedSortField: (value) {
          store.dispatch(SortInvoices(value));
        },
        sortFields: [
          InvoiceFields.invoiceNumber,
          InvoiceFields.invoiceDate,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterInvoicesByState(state));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () {
          store.dispatch(SelectInvoice(InvoiceEntity()));
        },
        child: Icon(Icons.add,color: Colors.white,),
        tooltip: localization.newInvoice,
      ),
    );
  }
}
