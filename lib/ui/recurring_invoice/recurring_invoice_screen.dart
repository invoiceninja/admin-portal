// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/recurring_invoice_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/recurring_invoice_list_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/recurring_invoice_presenter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'recurring_invoice_screen_vm.dart';

class RecurringInvoiceScreen extends StatelessWidget {
  const RecurringInvoiceScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/recurring_invoice';

  final RecurringInvoiceScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.company;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);

    final statuses = [
      InvoiceStatusEntity().rebuild(
        (b) => b
          ..id = kRecurringInvoiceStatusDraft
          ..name = localization!.draft,
      ),
      InvoiceStatusEntity().rebuild(
        (b) => b
          ..id = kRecurringInvoiceStatusPending
          ..name = localization!.pending,
      ),
      InvoiceStatusEntity().rebuild(
        (b) => b
          ..id = kRecurringInvoiceStatusActive
          ..name = localization!.active,
      ),
      InvoiceStatusEntity().rebuild(
        (b) => b
          ..id = kRecurringInvoiceStatusPaused
          ..name = localization!.paused,
      ),
      InvoiceStatusEntity().rebuild(
        (b) => b
          ..id = kRecurringInvoiceStatusCompleted
          ..name = localization!.completed,
      ),
    ];

    return ListScaffold(
      entityType: EntityType.recurringInvoice,
      onHamburgerLongPress: () =>
          store.dispatch(StartRecurringInvoiceMultiselect()),
      appBarTitle: ListFilter(
        key: ValueKey(
            '__filter_${state.recurringInvoiceListState.filterClearedAt}__'),
        entityType: EntityType.recurringInvoice,
        entityIds: viewModel.recurringInvoiceList,
        filter: state.recurringInvoiceListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterRecurringInvoices(value));
        },
        onSelectedStatus: (EntityStatus status, value) {
          store.dispatch(FilterRecurringInvoicesByStatus(status));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterRecurringInvoicesByState(state));
        },
        statuses: statuses,
      ),
      onCheckboxPressed: () {
        if (store.state.recurringInvoiceListState.isInMultiselect()) {
          store.dispatch(ClearRecurringInvoiceMultiselect());
        } else {
          store.dispatch(StartRecurringInvoiceMultiselect());
        }
      },
      body: RecurringInvoiceListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.recurringInvoice,
        tableColumns: RecurringInvoicePresenter.getAllTableFields(userCompany),
        defaultTableColumns:
            RecurringInvoicePresenter.getDefaultTableFields(userCompany),
        onSelectedSortField: (value) {
          store.dispatch(SortRecurringInvoices(value));
        },
        onSelectedStatus: (EntityStatus status, value) {
          store.dispatch(FilterRecurringInvoicesByStatus(status));
        },
        sortFields: [
          RecurringInvoiceFields.number,
          RecurringInvoiceFields.nextSendDate,
          EntityFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterRecurringInvoicesByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.recurringInvoiceListState.isInMultiselect()) {
            store.dispatch(ClearRecurringInvoiceMultiselect());
          } else {
            store.dispatch(StartRecurringInvoiceMultiselect());
          }
        },
        statuses: statuses,
        customValues1: company.getCustomFieldValues(CustomFieldType.invoice1,
            excludeBlank: true),
        customValues2: company.getCustomFieldValues(CustomFieldType.invoice2,
            excludeBlank: true),
        customValues3: company.getCustomFieldValues(CustomFieldType.invoice3,
            excludeBlank: true),
        customValues4: company.getCustomFieldValues(CustomFieldType.invoice4,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterRecurringInvoicesByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterRecurringInvoicesByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterRecurringInvoicesByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterRecurringInvoicesByCustom4(value)),
      ),
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.recurringInvoice)
          ? FloatingActionButton(
              heroTag: 'recurring_invoice_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.recurringInvoice);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization!.newRecurringInvoice,
            )
          : null,
    );
  }
}
