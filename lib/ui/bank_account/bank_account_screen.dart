import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/bank_account/bank_account_list_vm.dart';
import 'package:invoiceninja_flutter/ui/bank_account/bank_account_presenter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

import 'bank_account_screen_vm.dart';

class BankAccountScreen extends StatelessWidget {
  const BankAccountScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/bank_account';

  final BankAccountScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);

    return ListScaffold(
      entityType: EntityType.bankAccount,
      onHamburgerLongPress: () => store.dispatch(StartBankAccountMultiselect()),
      appBarTitle: ListFilter(
        key: ValueKey(
            '__filter_${state.bankAccountListState.filterClearedAt}__'),
        entityType: EntityType.bankAccount,
        entityIds: viewModel.bankAccountList,
        filter: state.bankAccountListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterBankAccounts(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterBankAccountsByState(state));
        },
      ),
      onCheckboxPressed: () {
        if (store.state.bankAccountListState.isInMultiselect()) {
          store.dispatch(ClearBankAccountMultiselect());
        } else {
          store.dispatch(StartBankAccountMultiselect());
        }
      },
      body: BankAccountListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.bankAccount,
        tableColumns: BankAccountPresenter.getAllTableFields(userCompany),
        defaultTableColumns:
            BankAccountPresenter.getDefaultTableFields(userCompany),
        onSelectedSortField: (value) {
          store.dispatch(SortBankAccounts(value));
        },
        sortFields: [
          BankAccountFields.name,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterBankAccountsByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.bankAccountListState.isInMultiselect()) {
            store.dispatch(ClearBankAccountMultiselect());
          } else {
            store.dispatch(StartBankAccountMultiselect());
          }
        },
        onSelectedCustom1: (value) =>
            store.dispatch(FilterBankAccountsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterBankAccountsByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterBankAccountsByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterBankAccountsByCustom4(value)),
      ),
      floatingActionButton: state.prefState.isMenuFloated
          ? FloatingActionButton(
              heroTag: 'bank_account_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                //createEntityByType(context: context, entityType: EntityType.bankAccount);
              },
              child: Icon(
                Icons.link,
                color: Colors.white,
              ),
              tooltip: localization.connect,
            )
          : null,
    );
  }
}
