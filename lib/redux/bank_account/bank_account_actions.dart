import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';

class ViewBankAccountList implements PersistUI {
  ViewBankAccountList({this.force = false});

  final bool force;
}

class ViewBankAccount implements PersistUI, PersistPrefs {
  ViewBankAccount({
    required this.bankAccountId,
    this.force = false,
  });

  final String? bankAccountId;
  final bool force;
}

class EditBankAccount implements PersistUI, PersistPrefs {
  EditBankAccount({
    required this.bankAccount,
    this.completer,
    this.force = false,
  });

  final BankAccountEntity bankAccount;
  final Completer? completer;
  final bool force;
}

class UpdateBankAccount implements PersistUI {
  UpdateBankAccount(this.bankAccount);

  final BankAccountEntity bankAccount;
}

class LoadBankAccount {
  LoadBankAccount({this.completer, this.bankAccountId});

  final Completer? completer;
  final String? bankAccountId;
}

class LoadBankAccountActivity {
  LoadBankAccountActivity({this.completer, this.bankAccountId});

  final Completer? completer;
  final String? bankAccountId;
}

class LoadBankAccounts {
  LoadBankAccounts({this.completer});

  final Completer? completer;
}

class LoadBankAccountRequest implements StartLoading {}

class LoadBankAccountFailure implements StopLoading {
  LoadBankAccountFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadBankAccountFailure{error: $error}';
  }
}

class LoadBankAccountSuccess implements StopLoading, PersistData {
  LoadBankAccountSuccess(this.bankAccount);

  final BankAccountEntity bankAccount;

  @override
  String toString() {
    return 'LoadBankAccountSuccess{bankAccount: $bankAccount}';
  }
}

class LoadBankAccountsRequest implements StartLoading {}

class LoadBankAccountsFailure implements StopLoading {
  LoadBankAccountsFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadBankAccountsFailure{error: $error}';
  }
}

class LoadBankAccountsSuccess implements StopLoading {
  LoadBankAccountsSuccess(this.bankAccounts);

  final BuiltList<BankAccountEntity> bankAccounts;

  @override
  String toString() {
    return 'LoadBankAccountsSuccess{bankAccounts: $bankAccounts}';
  }
}

class SaveBankAccountRequest implements StartSaving {
  SaveBankAccountRequest({this.completer, this.bankAccount});

  final Completer? completer;
  final BankAccountEntity? bankAccount;
}

class SaveBankAccountSuccess implements StopSaving, PersistData, PersistUI {
  SaveBankAccountSuccess(this.bankAccount);

  final BankAccountEntity bankAccount;
}

class AddBankAccountSuccess implements StopSaving, PersistData, PersistUI {
  AddBankAccountSuccess(this.bankAccount);

  final BankAccountEntity bankAccount;
}

class SaveBankAccountFailure implements StopSaving {
  SaveBankAccountFailure(this.error);

  final Object error;
}

class ArchiveBankAccountsRequest implements StartSaving {
  ArchiveBankAccountsRequest(this.completer, this.bankAccountIds);

  final Completer completer;
  final List<String> bankAccountIds;
}

class ArchiveBankAccountsSuccess implements StopSaving, PersistData {
  ArchiveBankAccountsSuccess(this.bankAccounts);

  final List<BankAccountEntity> bankAccounts;
}

class ArchiveBankAccountsFailure implements StopSaving {
  ArchiveBankAccountsFailure(this.bankAccounts);

  final List<BankAccountEntity?> bankAccounts;
}

class DeleteBankAccountsRequest implements StartSaving {
  DeleteBankAccountsRequest(this.completer, this.bankAccountIds);

  final Completer completer;
  final List<String> bankAccountIds;
}

class DeleteBankAccountsSuccess implements StopSaving, PersistData {
  DeleteBankAccountsSuccess(this.bankAccounts);

  final List<BankAccountEntity> bankAccounts;
}

class DeleteBankAccountsFailure implements StopSaving {
  DeleteBankAccountsFailure(this.bankAccounts);

  final List<BankAccountEntity?> bankAccounts;
}

class RestoreBankAccountsRequest implements StartSaving {
  RestoreBankAccountsRequest(this.completer, this.bankAccountIds);

  final Completer completer;
  final List<String> bankAccountIds;
}

class RestoreBankAccountsSuccess implements StopSaving, PersistData {
  RestoreBankAccountsSuccess(this.bankAccounts);

  final List<BankAccountEntity> bankAccounts;
}

class RestoreBankAccountsFailure implements StopSaving {
  RestoreBankAccountsFailure(this.bankAccounts);

  final List<BankAccountEntity?> bankAccounts;
}

class FilterBankAccounts implements PersistUI {
  FilterBankAccounts(this.filter);

  final String? filter;
}

class SortBankAccounts implements PersistUI, PersistPrefs {
  SortBankAccounts(this.field);

  final String field;
}

class FilterBankAccountsByState implements PersistUI {
  FilterBankAccountsByState(this.state);

  final EntityState state;
}

class FilterBankAccountsByCustom1 implements PersistUI {
  FilterBankAccountsByCustom1(this.value);

  final String value;
}

class FilterBankAccountsByCustom2 implements PersistUI {
  FilterBankAccountsByCustom2(this.value);

  final String value;
}

class FilterBankAccountsByCustom3 implements PersistUI {
  FilterBankAccountsByCustom3(this.value);

  final String value;
}

class FilterBankAccountsByCustom4 implements PersistUI {
  FilterBankAccountsByCustom4(this.value);

  final String value;
}

class StartBankAccountMultiselect {
  StartBankAccountMultiselect();
}

class AddToBankAccountMultiselect {
  AddToBankAccountMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromBankAccountMultiselect {
  RemoveFromBankAccountMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearBankAccountMultiselect {
  ClearBankAccountMultiselect();
}

class UpdateBankAccountTab implements PersistUI {
  UpdateBankAccountTab({this.tabIndex});

  final int? tabIndex;
}

void handleBankAccountAction(BuildContext? context,
    List<BaseEntity> bankAccounts, EntityAction? action) {
  if (bankAccounts.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final bankAccount = bankAccounts.first as BankAccountEntity;
  final bankAccountIds =
      bankAccounts.map((bankAccount) => bankAccount.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: bankAccount);
      break;
    case EntityAction.restore:
      store.dispatch(RestoreBankAccountsRequest(
          snackBarCompleter<Null>(localization!.restoredBankAccount),
          bankAccountIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveBankAccountsRequest(
          snackBarCompleter<Null>(localization!.archivedBankAccount),
          bankAccountIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteBankAccountsRequest(
          snackBarCompleter<Null>(localization!.deletedBankAccount),
          bankAccountIds));
      break;
    case EntityAction.newTransaction:
      createEntity(
          entity: TransactionEntity(state: state)
              .rebuild((b) => b..bankAccountId = bankAccount.id));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.bankAccountListState.isInMultiselect()) {
        store.dispatch(StartBankAccountMultiselect());
      }

      if (bankAccounts.isEmpty) {
        break;
      }

      for (final bankAccount in bankAccounts) {
        if (!store.state.bankAccountListState.isSelected(bankAccount.id)) {
          store.dispatch(AddToBankAccountMultiselect(entity: bankAccount));
        } else {
          store.dispatch(RemoveFromBankAccountMultiselect(entity: bankAccount));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [bankAccount],
      );
      break;
    default:
      print('## ERROR: unhandled action $action in bank_account_actions');
      break;
  }
}
