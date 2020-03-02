import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/data/models/credit_model.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_list_vm.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';

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
    final company = state.selectedCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.creditUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return AppScaffold(
                      isChecked: isInMultiselect &&
                          listUIState.selectedIds.length == viewModel.creditList.length,
                      showCheckbox: isInMultiselect,
                      onCheckboxChanged: (value) {
                        final credits = viewModel.creditList
                            .map<InvoiceEntity>((creditId) => viewModel.creditMap[creditId])
                            .where((credit) => value != listUIState.isSelected(credit))
                            .toList();
                
                        viewModel.onEntityAction(
                            context, credits, EntityAction.toggleMultiselect);
                      },
                     appBarTitle: ListFilter(
                       title: localization.credits
                       key: ValueKey(state.creditListState.filterClearedAt),
                       entityType: EntityType.credit,
                       onFilterChanged: (value) {
                         store.dispatch(FilterCredits(value));
                       },
                     ),
                     appBarActions: [
                        if (!viewModel.isInMultiselect)
                          ListFilterButton(
                            entityType: EntityType.credit,
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
                                        entities: credits, context: context, multiselect: true,
                                        completer: Completer<Null>()
                                          ..future.then((_) =>
                                          store.dispatch(ClearCreditMultiselect())),
                                        );
                                  },
                            onCancelPressed: (context) =>
                                store.dispatch(ClearCreditMultiselect()),
                          ),
                   ],
                   body: CreditListBuilder(),
                   bottomNavigationBar: AppBottomBar(
                     entityType: EntityType.credit,
                     onSelectedSortField: (value) => store.dispatch(SortCredits(value)),
                     customValues1: company.getCustomFieldValues(CustomFieldType.credit1,
                         excludeBlank: true),
                     customValues2: company.getCustomFieldValues(CustomFieldType.credit2,
                         excludeBlank: true),
                     onSelectedCustom1: (value) =>
                         store.dispatch(FilterCreditsByCustom1(value)),
                     onSelectedCustom2: (value) =>
                         store.dispatch(FilterCreditsByCustom2(value)),
                     sortFields: [
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
                   ),
                   floatingActionButton: user.canCreate(EntityType.credit)
                       ? FloatingActionButton(
                           heroTag: 'credit_fab',
                           backgroundColor: Theme.of(context).primaryColorDark,
                           onPressed: () {
                             store.dispatch(
                                 EditCredit(credit: InvoiceEntity(), context: context));
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
