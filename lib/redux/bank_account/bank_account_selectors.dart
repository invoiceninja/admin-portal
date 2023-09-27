import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownBankAccountList = memo5(
    (BuiltMap<String, BankAccountEntity> bankAccountMap,
            BuiltList<String> bankAccountList,
            StaticState staticState,
            BuiltMap<String, UserEntity> userMap,
            String? bankAccountId) =>
        dropdownBankAccountsSelector(bankAccountMap, bankAccountList,
            staticState, userMap, bankAccountId));

List<String> dropdownBankAccountsSelector(
    BuiltMap<String, BankAccountEntity> bankAccountMap,
    BuiltList<String> bankAccountList,
    StaticState staticState,
    BuiltMap<String, UserEntity> userMap,
    String? bankAccountId) {
  final list = bankAccountList.where((bankAccountId) {
    final bankAccount = bankAccountMap[bankAccountId]!;
    /*
    if (clientId != null && clientId > 0 && bankAccount.clientId != clientId) {
      return false;
    }
    */
    return bankAccount.isActive;
  }).toList();

  list.sort((bankAccountAId, bankAccountBId) {
    final bankAccountA = bankAccountMap[bankAccountAId]!;
    final bankAccountB = bankAccountMap[bankAccountBId];
    return bankAccountA.compareTo(bankAccountB, BankAccountFields.name, true);
  });

  return list;
}

var memoizedFilteredBankAccountList = memo4((SelectionState selectionState,
        BuiltMap<String, BankAccountEntity> bankAccountMap,
        BuiltList<String> bankAccountList,
        ListUIState bankAccountListState) =>
    filteredBankAccountsSelector(
        selectionState, bankAccountMap, bankAccountList, bankAccountListState));

List<String> filteredBankAccountsSelector(
    SelectionState selectionState,
    BuiltMap<String, BankAccountEntity> bankAccountMap,
    BuiltList<String> bankAccountList,
    ListUIState bankAccountListState) {
  final filterEntityId = selectionState.filterEntityId;
  //final filterEntityType = selectionState.filterEntityType;

  final list = bankAccountList.where((bankAccountId) {
    final bankAccount = bankAccountMap[bankAccountId];
    if (filterEntityId != null && bankAccount!.id != filterEntityId) {
      return false;
    } else {}

    if (!bankAccount!.matchesStates(bankAccountListState.stateFilters)) {
      return false;
    }

    return bankAccount.matchesFilter(bankAccountListState.filter);
  }).toList();

  list.sort((bankAccountAId, bankAccountBId) {
    final bankAccountA = bankAccountMap[bankAccountAId]!;
    final bankAccountB = bankAccountMap[bankAccountBId];
    return bankAccountA.compareTo(bankAccountB, bankAccountListState.sortField,
        bankAccountListState.sortAscending);
  });

  return list;
}

bool? hasBankAccountChanges(BankAccountEntity bankAccount,
        BuiltMap<String, BankAccountEntity> bankAccountMap) =>
    bankAccount.isNew
        ? bankAccount.isChanged
        : bankAccount != bankAccountMap[bankAccount.id];
