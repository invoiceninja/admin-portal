import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
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

import 'invoice_screen_vm.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/invoice';

  final InvoiceScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.selectedCompany;
    final userCompany = store.state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = store.state.uiState.invoiceUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return AppScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedEntities.length == viewModel.invoiceList.length,
      showCheckbox: isInMultiselect,
      onCheckboxChanged: (value) {
        final invoices = viewModel.invoiceList
            .map<InvoiceEntity>((invoiceId) => viewModel.invoiceMap[invoiceId])
            .where((invoice) => value != listUIState.isSelected(invoice))
            .toList();

        viewModel.onEntityAction(
            context, invoices, EntityAction.toggleMultiselect);
      },
      appBarTitle: ListFilter(
        key: ValueKey(store.state.invoiceListState.filterClearedAt),
        entityType: EntityType.invoice,
        onFilterChanged: (value) {
          store.dispatch(FilterInvoices(value));
        },
      ),
      appBarActions: [
        if (!viewModel.isInMultiselect)
          ListFilterButton(
            entityType: EntityType.invoice,
            onFilterPressed: (String value) {
              store.dispatch(FilterInvoices(value));
            },
          ),
        if (viewModel.isInMultiselect)
          FlatButton(
            key: key,
            child: Text(
              localization.cancel,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              store.dispatch(ClearInvoiceMultiselect(context: context));
            },
          ),
        if (viewModel.isInMultiselect)
          FlatButton(
            key: key,
            textColor: Colors.white,
            disabledTextColor: Colors.white54,
            child: Text(
              localization.done,
            ),
            onPressed: state.invoiceListState.selectedEntities.isEmpty
                ? null
                : () async {
                    await showEntityActionsDialog(
                        entities: state.invoiceListState.selectedEntities,
                        userCompany: userCompany,
                        context: context,
                        onEntityAction: viewModel.onEntityAction,
                        multiselect: true);
                    store.dispatch(ClearInvoiceMultiselect(context: context));
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
              heroTag: 'invoice_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                store.dispatch(EditInvoice(
                    invoice: InvoiceEntity(company: company).rebuild((b) => b
                      ..clientId = store.state.invoiceListState.filterEntityId),
                    context: context));
              },
              child: Icon(Icons.add, color: Colors.white),
              tooltip: localization.newInvoice,
            )
          : null,
    );
  }
}
