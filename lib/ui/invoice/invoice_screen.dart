import 'package:invoiceninja/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja/ui/app/app_search.dart';
import 'package:invoiceninja/ui/app/app_search_button.dart';
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
  static const String route = '/invoice';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final localization = AppLocalization.of(context);

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
            onSearchPressed: (String value) {
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
          InvoiceFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterInvoicesByState(state));
        },
        onSelectedStatus: (EntityStatus status, value) {
          store.dispatch(FilterInvoicesByStatus(status));
        },
        statuses: [
          InvoiceStatusEntity().rebuild((b) => b
            ..id = 1
            ..name = localization.draft,
          ),
          InvoiceStatusEntity().rebuild((b) => b
            ..id = 2
            ..name = localization.sent,
          ),
          InvoiceStatusEntity().rebuild((b) => b
            ..id = 3
            ..name = localization.viewed,
          ),
          InvoiceStatusEntity().rebuild((b) => b
            ..id = 5
            ..name = localization.partial,
          ),
          InvoiceStatusEntity().rebuild((b) => b
            ..id = 6
            ..name = localization.paid,
          ),
          InvoiceStatusEntity().rebuild((b) => b
            ..id = -1
            ..name = localization.pastDue,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () {
          store.dispatch(EditInvoice(invoice: InvoiceEntity(), context: context));
        },
        child: Icon(Icons.add,color: Colors.white,),
        tooltip: localization.newInvoice,
      ),
    );
  }
}
