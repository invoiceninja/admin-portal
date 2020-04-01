import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

import 'credit_screen_vm.dart';

class CreditScreen extends StatelessWidget {
  const CreditScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/credit';

  final CreditScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.company;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.creditUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return ListScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.creditList.length,
      showCheckbox: isInMultiselect,
      onHamburgerLongPress: () => store.dispatch(StartCreditMultiselect()),
      onCheckboxChanged: (value) {
        final credits = viewModel.creditList
            .map<InvoiceEntity>((creditId) => viewModel.creditMap[creditId])
            .where((credit) => value != listUIState.isSelected(credit.id))
            .toList();

        handleCreditAction(context, credits, EntityAction.toggleMultiselect);
      },
      appBarTitle: ListFilter(
        title: localization.credits,
        key: ValueKey(state.creditListState.filterClearedAt),
        filter: state.creditListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterCredits(value));
        },
      ),
      appBarActions: [
        if (!viewModel.isInMultiselect)
          ListFilterButton(
            filter: state.creditListState.filter,
            onFilterPressed: (String value) {
              store.dispatch(FilterCredits(value));
            },
          ),
        if (viewModel.isInMultiselect)
          SaveCancelButtons(
            saveLabel: localization.done,
            onSavePressed: listUIState.selectedIds.isEmpty
                ? null
                : (context) async {
                    final credits = listUIState.selectedIds
                        .map<InvoiceEntity>(
                            (creditId) => viewModel.creditMap[creditId])
                        .toList();

                    await showEntityActionsDialog(
                      entities: credits,
                      context: context,
                      multiselect: true,
                      completer: Completer<Null>()
                        ..future.then<dynamic>(
                            (_) => store.dispatch(ClearCreditMultiselect())),
                    );
                  },
            onCancelPressed: (context) =>
                store.dispatch(ClearCreditMultiselect()),
          ),
      ],
      body: CreditListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.credit,
        onSelectedSortField: (value) {
          store.dispatch(SortCredits(value));
        },
        sortFields: [
          CreditFields.creditNumber,
          CreditFields.amount,
          CreditFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterCreditsByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.creditListState.isInMultiselect()) {
            store.dispatch(ClearCreditMultiselect());
          } else {
            store.dispatch(StartCreditMultiselect());
          }
        },
        customValues1: company.getCustomFieldValues(CustomFieldType.invoice1,
            excludeBlank: true),
        customValues2: company.getCustomFieldValues(CustomFieldType.invoice2,
            excludeBlank: true),
        customValues3: company.getCustomFieldValues(CustomFieldType.invoice3,
            excludeBlank: true),
        customValues4: company.getCustomFieldValues(CustomFieldType.invoice4,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterCreditsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterCreditsByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterCreditsByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterCreditsByCustom4(value)),
      ),
      floatingActionButton: userCompany.canCreate(EntityType.credit)
          ? FloatingActionButton(
              heroTag: 'credit_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.credit);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization.newCredit,
            )
          : null,
    );
  }
}
