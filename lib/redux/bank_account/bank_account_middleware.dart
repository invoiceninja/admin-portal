import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/ui/bank_account/edit/bank_account_edit_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/bank_account/bank_account_screen.dart';
import 'package:invoiceninja_flutter/ui/bank_account/view/bank_account_view_vm.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/bank_account_repository.dart';

List<Middleware<AppState>> createStoreBankAccountsMiddleware([
  BankAccountRepository repository = const BankAccountRepository(),
]) {
  final viewBankAccountList = _viewBankAccountList();
  final viewBankAccount = _viewBankAccount();
  final editBankAccount = _editBankAccount();
  final loadBankAccounts = _loadBankAccounts(repository);
  final loadBankAccount = _loadBankAccount(repository);
  final saveBankAccount = _saveBankAccount(repository);
  final archiveBankAccount = _archiveBankAccount(repository);
  final deleteBankAccount = _deleteBankAccount(repository);
  final restoreBankAccount = _restoreBankAccount(repository);

  return [
    TypedMiddleware<AppState, ViewBankAccountList>(viewBankAccountList),
    TypedMiddleware<AppState, ViewBankAccount>(viewBankAccount),
    TypedMiddleware<AppState, EditBankAccount>(editBankAccount),
    TypedMiddleware<AppState, LoadBankAccounts>(loadBankAccounts),
    TypedMiddleware<AppState, LoadBankAccount>(loadBankAccount),
    TypedMiddleware<AppState, SaveBankAccountRequest>(saveBankAccount),
    TypedMiddleware<AppState, ArchiveBankAccountsRequest>(archiveBankAccount),
    TypedMiddleware<AppState, DeleteBankAccountsRequest>(deleteBankAccount),
    TypedMiddleware<AppState, RestoreBankAccountsRequest>(restoreBankAccount),
  ];
}

Middleware<AppState> _editBankAccount() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditBankAccount?;

    next(action);

    store.dispatch(UpdateCurrentRoute(BankAccountEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(BankAccountEditScreen.route);
    }
  };
}

Middleware<AppState> _viewBankAccount() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewBankAccount?;

    next(action);

    store.dispatch(UpdateCurrentRoute(BankAccountViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(BankAccountViewScreen.route);
    }
  };
}

Middleware<AppState> _viewBankAccountList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewBankAccountList?;

    next(action);

    if (store.state.staticState.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(BankAccountScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          BankAccountScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveBankAccount(BankAccountRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveBankAccountsRequest;
    final prevBankAccounts = action.bankAccountIds
        .map((id) => store.state.bankAccountState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.bankAccountIds,
            EntityAction.archive)
        .then((List<BankAccountEntity> bankAccounts) {
      store.dispatch(ArchiveBankAccountsSuccess(bankAccounts));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveBankAccountsFailure(prevBankAccounts));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteBankAccount(BankAccountRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteBankAccountsRequest;
    final prevBankAccounts = action.bankAccountIds
        .map((id) => store.state.bankAccountState.map[id])
        .toList();
    repository
        .bulkAction(
            store.state.credentials, action.bankAccountIds, EntityAction.delete)
        .then((List<BankAccountEntity> bankAccounts) {
      store.dispatch(DeleteBankAccountsSuccess(bankAccounts));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteBankAccountsFailure(prevBankAccounts));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreBankAccount(BankAccountRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreBankAccountsRequest;
    final prevBankAccounts = action.bankAccountIds
        .map((id) => store.state.bankAccountState.map[id])
        .toList();
    repository
        .bulkAction(store.state.credentials, action.bankAccountIds,
            EntityAction.restore)
        .then((List<BankAccountEntity> bankAccounts) {
      store.dispatch(RestoreBankAccountsSuccess(bankAccounts));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreBankAccountsFailure(prevBankAccounts));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveBankAccount(BankAccountRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveBankAccountRequest;
    repository
        .saveData(store.state.credentials, action.bankAccount!)
        .then((BankAccountEntity bankAccount) {
      if (action.bankAccount!.isNew) {
        store.dispatch(AddBankAccountSuccess(bankAccount));
      } else {
        store.dispatch(SaveBankAccountSuccess(bankAccount));
      }

      action.completer!.complete(bankAccount);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveBankAccountFailure(error));
      action.completer!.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadBankAccount(BankAccountRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadBankAccount;
    final AppState state = store.state;

    store.dispatch(LoadBankAccountRequest());
    repository
        .loadItem(state.credentials, action.bankAccountId)
        .then((bankAccount) {
      store.dispatch(LoadBankAccountSuccess(bankAccount));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadBankAccountFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadBankAccounts(BankAccountRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadBankAccounts?;
    final AppState state = store.state;

    store.dispatch(LoadBankAccountsRequest());
    repository.loadList(state.credentials).then((data) {
      store.dispatch(LoadBankAccountsSuccess(data));

      if (action!.completer != null) {
        action.completer!.complete(null);
      }
      /*
      if (state.productState.isStale) {
        store.dispatch(LoadProducts());
      }
      */
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadBankAccountsFailure(error));
      if (action!.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}
