import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/transaction_rule/transaction_rule_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/transaction_rule_list_vm.dart';
import 'package:invoiceninja_flutter/ui/transaction_rule/transaction_rule_presenter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

import 'transaction_rule_screen_vm.dart';

class TransactionRuleScreen extends StatelessWidget {
  const TransactionRuleScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsTransactionRules';

  final TransactionRuleScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);

    return ListScaffold(
      entityType: EntityType.transactionRule,
      onHamburgerLongPress: () =>
          store.dispatch(StartTransactionRuleMultiselect()),
      onCancelSettingsSection: kSettingsBankAccounts,
      appBarTitle: ListFilter(
        key: ValueKey(
            '__filter_${state.transactionRuleListState.filterClearedAt}__'),
        entityType: EntityType.transactionRule,
        entityIds: viewModel.transactionRuleList,
        filter: state.transactionRuleListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterTransactionRules(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterTransactionRulesByState(state));
        },
      ),
      onCheckboxPressed: () {
        if (store.state.transactionRuleListState.isInMultiselect()) {
          store.dispatch(ClearTransactionRuleMultiselect());
        } else {
          store.dispatch(StartTransactionRuleMultiselect());
        }
      },
      body: TransactionRuleListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.transactionRule,
        tableColumns: TransactionRulePresenter.getAllTableFields(userCompany),
        defaultTableColumns:
            TransactionRulePresenter.getDefaultTableFields(userCompany),
        onSelectedSortField: (value) {
          store.dispatch(SortTransactionRules(value));
        },
        sortFields: [
          TransactionRuleFields.name,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterTransactionRulesByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.transactionRuleListState.isInMultiselect()) {
            store.dispatch(ClearTransactionRuleMultiselect());
          } else {
            store.dispatch(StartTransactionRuleMultiselect());
          }
        },
        onSelectedCustom1: (value) =>
            store.dispatch(FilterTransactionRulesByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterTransactionRulesByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterTransactionRulesByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterTransactionRulesByCustom4(value)),
      ),
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.transactionRule)
          ? FloatingActionButton(
              heroTag: 'transaction_rule_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.transactionRule);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization!.newTransactionRule,
            )
          : null,
    );
  }
}
