import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_vm.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class InvoiceScreen extends StatelessWidget {
  static const String route = '/invoice';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.selectedCompany;
    final userCompany = store.state.userCompany;
    final localization = AppLocalization.of(context);

    return AppScaffold(
      appBarTitle: ListFilter(
        key: ValueKey(store.state.invoiceListState.filterClearedAt),
        entityType: EntityType.invoice,
        onFilterChanged: (value) {
          store.dispatch(FilterInvoices(value));
        },
      ),
      appBarActions: [
        ListFilterButton(
          entityType: EntityType.invoice,
          onFilterPressed: (String value) {
            store.dispatch(FilterInvoices(value));
          },
        ),
      ],
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
              ..id = kInvoiceStatusDraft
              ..name = localization.draft,
          ),
          InvoiceStatusEntity().rebuild(
            (b) => b
              ..id = kInvoiceStatusSent
              ..name = localization.sent,
          ),
          InvoiceStatusEntity().rebuild(
            (b) => b
              ..id = kInvoiceStatusViewed
              ..name = localization.viewed,
          ),
          InvoiceStatusEntity().rebuild(
            (b) => b
              ..id = kInvoiceStatusPartial
              ..name = localization.partial,
          ),
          InvoiceStatusEntity().rebuild(
            (b) => b
              ..id = kInvoiceStatusPaid
              ..name = localization.paid,
          ),
          InvoiceStatusEntity().rebuild(
            (b) => b
              ..id = kInvoiceStatusPastDue
              ..name = localization.pastDue,
          ),
        ],
      ),
      floatingActionButton: userCompany.canCreate(EntityType.invoice)
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
    );
  }
}
