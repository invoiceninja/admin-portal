import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_vm.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class InvoiceScreen extends StatelessWidget {
  static const String route = '/invoice';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.selectedCompany;
    final user = company.user;
    final localization = AppLocalization.of(context);

    return WillPopScope(
      onWillPop: () async {
        store.dispatch(ViewDashboard(context));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: ListFilter(
            entityType: EntityType.invoice,
            onFilterChanged: (value) {
              store.dispatch(FilterInvoices(value));
            },
          ),
          actions: [
            ListFilterButton(
              entityType: EntityType.invoice,
              onFilterPressed: (String value) {
                store.dispatch(FilterInvoices(value));
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
            InvoiceFields.dueDate,
            InvoiceFields.updatedAt,
          ],
          onSelectedState: (EntityState state, value) {
            store.dispatch(FilterInvoicesByState(state));
          },
          onSelectedStatus: (EntityStatus status, value) {
            store.dispatch(FilterInvoicesByStatus(status));
          },
          customValues1: company.getCustomFieldValues(CustomFieldType.invoice1,
              excludeBlank: true),
          customValues2: company.getCustomFieldValues(CustomFieldType.invoice2,
              excludeBlank: true),
          onSelectedCustom1: (value) =>
              store.dispatch(FilterInvoicesByCustom1(value)),
          onSelectedCustom2: (value) =>
              store.dispatch(FilterInvoicesByCustom2(value)),
          statuses: [
            InvoiceStatusEntity().rebuild(
              (b) => b
                ..id = 1
                ..name = localization.draft,
            ),
            InvoiceStatusEntity().rebuild(
              (b) => b
                ..id = 2
                ..name = localization.sent,
            ),
            InvoiceStatusEntity().rebuild(
              (b) => b
                ..id = 3
                ..name = localization.viewed,
            ),
            InvoiceStatusEntity().rebuild(
              (b) => b
                ..id = 5
                ..name = localization.partial,
            ),
            InvoiceStatusEntity().rebuild(
              (b) => b
                ..id = 6
                ..name = localization.paid,
            ),
            InvoiceStatusEntity().rebuild(
              (b) => b
                ..id = -1
                ..name = localization.pastDue,
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: user.canCreate(EntityType.invoice)
            ? FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColorDark,
                onPressed: () {
                  store.dispatch(EditInvoice(
                      invoice: InvoiceEntity(company: company).rebuild((b) => b
                        ..clientId =
                            store.state.invoiceListState.filterEntityId ?? 0),
                      context: context));
                },
                child: Icon(Icons.add, color: Colors.white),
                tooltip: localization.newInvoice,
              )
            : null,
      ),
    );
  }
}
