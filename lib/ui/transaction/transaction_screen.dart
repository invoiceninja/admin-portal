import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/transaction/transaction_list_vm.dart';
import 'package:invoiceninja_flutter/ui/transaction/transaction_presenter.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

import 'transaction_screen_vm.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/transaction';

  final TransactionScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);

    final statuses = [
      TransactionStatusEntity().rebuild(
        (b) => b
          ..id = kTransactionStatusDeposit
          ..name = localization!.deposits,
      ),
      TransactionStatusEntity().rebuild(
        (b) => b
          ..id = kTransactionStatusWithdrawal
          ..name = localization!.withdrawals,
      ),
      TransactionStatusEntity().rebuild(
        (b) => b
          ..id = kTransactionStatusUnmatched
          ..name = localization!.unmatched,
      ),
      TransactionStatusEntity().rebuild(
        (b) => b
          ..id = kTransactionStatusMatched
          ..name = localization!.matched,
      ),
      TransactionStatusEntity().rebuild(
        (b) => b
          ..id = kTransactionStatusConverted
          ..name = localization!.converted,
      ),
    ];

    return ListScaffold(
      entityType: EntityType.transaction,
      onHamburgerLongPress: () => store.dispatch(StartTransactionMultiselect()),
      appBarTitle: ListFilter(
        key: ValueKey(
            '__filter_${state.transactionListState.filterClearedAt}__'),
        entityType: EntityType.transaction,
        entityIds: viewModel.transactionList,
        filter: state.transactionListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterTransactions(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterTransactionsByState(state));
        },
        onSelectedStatus: (EntityStatus status, value) {
          store.dispatch(
              FilterTransactionsByStatus(status as TransactionStatusEntity));
        },
        statuses: statuses,
      ),
      onCheckboxPressed: () {
        if (store.state.transactionListState.isInMultiselect()) {
          store.dispatch(ClearTransactionMultiselect());
        } else {
          store.dispatch(StartTransactionMultiselect());
        }
      },
      body: TransactionListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.transaction,
        iconButtons: [
          IconButton(
              icon: Icon(getEntityIcon(EntityType.settings)),
              onPressed: () {
                store.dispatch(ViewSettings(
                  section: kSettingsBankAccounts,
                  company: state.company,
                ));
              })
        ],
        tableColumns: TransactionPresenter.getAllTableFields(userCompany),
        defaultTableColumns:
            TransactionPresenter.getDefaultTableFields(userCompany),
        onSelectedSortField: (value) {
          store.dispatch(SortTransactions(value));
        },
        sortFields: [
          TransactionFields.date,
          TransactionFields.description,
          TransactionFields.amount,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterTransactionsByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.transactionListState.isInMultiselect()) {
            store.dispatch(ClearTransactionMultiselect());
          } else {
            store.dispatch(StartTransactionMultiselect());
          }
        },
        onSelectedCustom1: (value) =>
            store.dispatch(FilterTransactionsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterTransactionsByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterTransactionsByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterTransactionsByCustom4(value)),
        statuses: statuses,
      ),
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.transaction)
          ? FloatingActionButton(
              heroTag: 'transaction_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.transaction);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization!.newTransaction,
            )
          : null,
    );
  }
}
