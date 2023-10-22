import 'package:redux/redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_state.dart';

EntityUIState bankAccountUIReducer(BankAccountUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(bankAccountListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action)
    ..tabIndex = tabIndexReducer(state.tabIndex, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewBankAccount>((completer, action) => true),
  TypedReducer<bool?, ViewBankAccountList>((completer, action) => false),
  TypedReducer<bool?, FilterBankAccountsByState>((completer, action) => false),
  TypedReducer<bool?, FilterBankAccounts>((completer, action) => false),
  TypedReducer<bool?, FilterBankAccountsByCustom1>(
      (completer, action) => false),
  TypedReducer<bool?, FilterBankAccountsByCustom2>(
      (completer, action) => false),
  TypedReducer<bool?, FilterBankAccountsByCustom3>(
      (completer, action) => false),
  TypedReducer<bool?, FilterBankAccountsByCustom4>(
      (completer, action) => false),
]);

final int? Function(int, dynamic) tabIndexReducer = combineReducers<int?>([
  TypedReducer<int?, UpdateBankAccountTab>((completer, action) {
    return action.tabIndex;
  }),
  TypedReducer<int?, PreviewEntity>((completer, action) {
    return 0;
  }),
]);

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveBankAccountsSuccess>((completer, action) => ''),
  TypedReducer<String?, DeleteBankAccountsSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.bankAccount
          ? action.entityId
          : selectedId),
  TypedReducer<String?, ViewBankAccount>(
      (String? selectedId, dynamic action) => action.bankAccountId),
  TypedReducer<String?, AddBankAccountSuccess>(
      (String? selectedId, dynamic action) => action.bankAccount.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortBankAccounts>((selectedId, action) => ''),
  TypedReducer<String?, FilterBankAccounts>((selectedId, action) => ''),
  TypedReducer<String?, FilterBankAccountsByState>((selectedId, action) => ''),
  TypedReducer<String?, FilterBankAccountsByCustom1>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterBankAccountsByCustom2>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterBankAccountsByCustom3>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterBankAccountsByCustom4>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.bankAccount
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<BankAccountEntity?>([
  TypedReducer<BankAccountEntity?, SaveBankAccountSuccess>(_updateEditing),
  TypedReducer<BankAccountEntity?, AddBankAccountSuccess>(_updateEditing),
  TypedReducer<BankAccountEntity?, EditBankAccount>(_updateEditing),
  TypedReducer<BankAccountEntity?, UpdateBankAccount>((bankAccount, action) {
    return action.bankAccount.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<BankAccountEntity?, RestoreBankAccountsSuccess>(
      (bankAccounts, action) {
    return action.bankAccounts[0];
  }),
  TypedReducer<BankAccountEntity?, ArchiveBankAccountsSuccess>(
      (bankAccounts, action) {
    return action.bankAccounts[0];
  }),
  TypedReducer<BankAccountEntity?, DeleteBankAccountsSuccess>(
      (bankAccounts, action) {
    return action.bankAccounts[0];
  }),
  TypedReducer<BankAccountEntity?, DiscardChanges>(_clearEditing),
]);

BankAccountEntity _clearEditing(
    BankAccountEntity? bankAccount, dynamic action) {
  return BankAccountEntity();
}

BankAccountEntity? _updateEditing(
    BankAccountEntity? bankAccount, dynamic action) {
  return action.bankAccount;
}

final bankAccountListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortBankAccounts>(_sortBankAccounts),
  TypedReducer<ListUIState, FilterBankAccountsByState>(
      _filterBankAccountsByState),
  TypedReducer<ListUIState, FilterBankAccounts>(_filterBankAccounts),
  TypedReducer<ListUIState, FilterBankAccountsByCustom1>(
      _filterBankAccountsByCustom1),
  TypedReducer<ListUIState, FilterBankAccountsByCustom2>(
      _filterBankAccountsByCustom2),
  TypedReducer<ListUIState, StartBankAccountMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToBankAccountMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromBankAccountMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearBankAccountMultiselect>(_clearListMultiselect),
  TypedReducer<ListUIState, ViewBankAccountList>(_viewBankAccountList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewBankAccountList(
    ListUIState bankAccountListState, ViewBankAccountList action) {
  return bankAccountListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
}

ListUIState _filterBankAccountsByCustom1(
    ListUIState bankAccountListState, FilterBankAccountsByCustom1 action) {
  if (bankAccountListState.custom1Filters.contains(action.value)) {
    return bankAccountListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return bankAccountListState
        .rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterBankAccountsByCustom2(
    ListUIState bankAccountListState, FilterBankAccountsByCustom2 action) {
  if (bankAccountListState.custom2Filters.contains(action.value)) {
    return bankAccountListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return bankAccountListState
        .rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterBankAccountsByState(
    ListUIState bankAccountListState, FilterBankAccountsByState action) {
  if (bankAccountListState.stateFilters.contains(action.state)) {
    return bankAccountListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return bankAccountListState
        .rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterBankAccounts(
    ListUIState bankAccountListState, FilterBankAccounts action) {
  return bankAccountListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : bankAccountListState.filterClearedAt);
}

ListUIState _sortBankAccounts(
    ListUIState bankAccountListState, SortBankAccounts action) {
  return bankAccountListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartBankAccountMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToBankAccountMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState productListState, RemoveFromBankAccountMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearBankAccountMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
}

final bankAccountsReducer = combineReducers<BankAccountState>([
  TypedReducer<BankAccountState, SaveBankAccountSuccess>(_updateBankAccount),
  TypedReducer<BankAccountState, AddBankAccountSuccess>(_addBankAccount),
  TypedReducer<BankAccountState, LoadBankAccountsSuccess>(
      _setLoadedBankAccounts),
  TypedReducer<BankAccountState, LoadBankAccountSuccess>(_setLoadedBankAccount),
  TypedReducer<BankAccountState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<BankAccountState, ArchiveBankAccountsSuccess>(
      _archiveBankAccountSuccess),
  TypedReducer<BankAccountState, DeleteBankAccountsSuccess>(
      _deleteBankAccountSuccess),
  TypedReducer<BankAccountState, RestoreBankAccountsSuccess>(
      _restoreBankAccountSuccess),
]);

BankAccountState _archiveBankAccountSuccess(
    BankAccountState bankAccountState, ArchiveBankAccountsSuccess action) {
  return bankAccountState.rebuild((b) {
    for (final bankAccount in action.bankAccounts) {
      b.map[bankAccount.id] = bankAccount;
    }
  });
}

BankAccountState _deleteBankAccountSuccess(
    BankAccountState bankAccountState, DeleteBankAccountsSuccess action) {
  return bankAccountState.rebuild((b) {
    for (final bankAccount in action.bankAccounts) {
      b.map[bankAccount.id] = bankAccount;
    }
  });
}

BankAccountState _restoreBankAccountSuccess(
    BankAccountState bankAccountState, RestoreBankAccountsSuccess action) {
  return bankAccountState.rebuild((b) {
    for (final bankAccount in action.bankAccounts) {
      b.map[bankAccount.id] = bankAccount;
    }
  });
}

BankAccountState _addBankAccount(
    BankAccountState bankAccountState, AddBankAccountSuccess action) {
  return bankAccountState.rebuild((b) => b
    ..map[action.bankAccount.id] = action.bankAccount
    ..list.add(action.bankAccount.id));
}

BankAccountState _updateBankAccount(
    BankAccountState bankAccountState, SaveBankAccountSuccess action) {
  return bankAccountState
      .rebuild((b) => b..map[action.bankAccount.id] = action.bankAccount);
}

BankAccountState _setLoadedBankAccount(
    BankAccountState bankAccountState, LoadBankAccountSuccess action) {
  return bankAccountState
      .rebuild((b) => b..map[action.bankAccount.id] = action.bankAccount);
}

BankAccountState _setLoadedBankAccounts(
        BankAccountState bankAccountState, LoadBankAccountsSuccess action) =>
    bankAccountState.loadBankAccounts(action.bankAccounts);

BankAccountState _setLoadedCompany(
    BankAccountState bankAccountState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return bankAccountState.loadBankAccounts(company.bankAccounts);
}
