import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_screen.dart';
import 'package:invoiceninja_flutter/ui/payment/edit/payment_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/payment/view/payment_view_vm.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/payment_repository.dart';

List<Middleware<AppState>> createStorePaymentsMiddleware([
  PaymentRepository repository = const PaymentRepository(),
]) {
  final viewPaymentList = _viewPaymentList();
  final viewPayment = _viewPayment();
  final editPayment = _editPayment();
  final loadPayments = _loadPayments(repository);
  //final loadPayment = _loadPayment(repository);
  final savePayment = _savePayment(repository);
  final archivePayment = _archivePayment(repository);
  final deletePayment = _deletePayment(repository);
  final restorePayment = _restorePayment(repository);

  return [
    TypedMiddleware<AppState, ViewPaymentList>(viewPaymentList),
    TypedMiddleware<AppState, ViewPayment>(viewPayment),
    TypedMiddleware<AppState, EditPayment>(editPayment),
    TypedMiddleware<AppState, LoadPayments>(loadPayments),
    //TypedMiddleware<AppState, LoadPayment>(loadPayment),
    TypedMiddleware<AppState, SavePaymentRequest>(savePayment),
    TypedMiddleware<AppState, ArchivePaymentRequest>(archivePayment),
    TypedMiddleware<AppState, DeletePaymentRequest>(deletePayment),
    TypedMiddleware<AppState, RestorePaymentRequest>(restorePayment),
  ];
}

Middleware<AppState> _editPayment() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    final payment =
        await Navigator.of(action.context).pushNamed(PaymentEditScreen.route);

    if (action.completer != null && payment != null) {
      action.completer.complete(null);
    }
  };
}

Middleware<AppState> _viewPayment() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    store.dispatch(UpdateCurrentRoute(PaymentViewScreen.route));
    Navigator.of(action.context).pushNamed(PaymentViewScreen.route);
  };
}

Middleware<AppState> _viewPaymentList() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    store.dispatch(UpdateCurrentRoute(PaymentScreen.route));

    Navigator.of(action.context).pushNamedAndRemoveUntil(
        PaymentScreen.route, (Route<dynamic> route) => false);
  };
}

Middleware<AppState> _archivePayment(PaymentRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origPayment = store.state.paymentState.map[action.paymentId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origPayment, EntityAction.archive)
        .then((dynamic payment) {
      store.dispatch(ArchivePaymentSuccess(payment));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchivePaymentFailure(origPayment));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _deletePayment(PaymentRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origPayment = store.state.paymentState.map[action.paymentId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origPayment, EntityAction.delete)
        .then((dynamic payment) {
      store.dispatch(DeletePaymentSuccess(payment));
      store.dispatch(LoadClient(
          clientId: paymentInvoiceSelector(payment, store.state).clientId));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeletePaymentFailure(origPayment));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _restorePayment(PaymentRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final origPayment = store.state.paymentState.map[action.paymentId];
    repository
        .saveData(store.state.selectedCompany, store.state.authState,
            origPayment, EntityAction.restore)
        .then((dynamic payment) {
      store.dispatch(RestorePaymentSuccess(payment));
      store.dispatch(LoadClient(
          clientId: paymentInvoiceSelector(payment, store.state).clientId));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestorePaymentFailure(origPayment));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _savePayment(PaymentRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    repository
        .saveData(
            store.state.selectedCompany, store.state.authState, action.payment)
        .then((dynamic payment) {
      if (action.payment.isNew) {
        store.dispatch(AddPaymentSuccess(payment));
      } else {
        store.dispatch(SavePaymentSuccess(payment));
      }
      store.dispatch(LoadClient(
          clientId: paymentInvoiceSelector(payment, store.state).clientId));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SavePaymentFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

/*
Middleware<AppState> _loadPayment(PaymentRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final AppState state = store.state;

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadPaymentRequest());
    repository
        .loadItem(state.selectedCompany, state.authState, action.paymentId)
        .then((payment) {
      store.dispatch(LoadPaymentSuccess(payment));

      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadPaymentFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}
*/

Middleware<AppState> _loadPayments(PaymentRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    final AppState state = store.state;

    if (!state.paymentState.isStale && !action.force) {
      next(action);
      return;
    }

    if (state.isLoading) {
      next(action);
      return;
    }

    final int updatedAt =
        action.force ? 0 : (state.paymentState.lastUpdated / 1000).round();

    store.dispatch(LoadPaymentsRequest());
    repository
        .loadList(state.selectedCompany, state.authState, updatedAt)
        .then((data) {
      store.dispatch(LoadPaymentsSuccess(data));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.quoteState.isStale) {
        store.dispatch(LoadQuotes());
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadPaymentsFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}
