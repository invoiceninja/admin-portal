import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/payment/refund/payment_refund_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_screen.dart';
import 'package:invoiceninja_flutter/ui/payment/edit/payment_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/payment/view/payment_view_vm.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/payment_repository.dart';

import 'package:invoiceninja_flutter/main_app.dart';

List<Middleware<AppState>> createStorePaymentsMiddleware([
  PaymentRepository repository = const PaymentRepository(),
]) {
  final viewPaymentList = _viewPaymentList();
  final viewPayment = _viewPayment();
  final editPayment = _editPayment();
  final viewRefundPayment = _viewRefundPayment();
  final loadPayments = _loadPayments(repository);
  final loadPayment = _loadPayment(repository);
  final savePayment = _savePayment(repository);
  final refundPayment = _refundPayment(repository);
  final archivePayment = _archivePayment(repository);
  final deletePayment = _deletePayment(repository);
  final restorePayment = _restorePayment(repository);
  final emailPayment = _emailPayment(repository);

  return [
    TypedMiddleware<AppState, ViewPaymentList>(viewPaymentList),
    TypedMiddleware<AppState, ViewPayment>(viewPayment),
    TypedMiddleware<AppState, EditPayment>(editPayment),
    TypedMiddleware<AppState, ViewRefundPayment>(viewRefundPayment),
    TypedMiddleware<AppState, LoadPayments>(loadPayments),
    TypedMiddleware<AppState, LoadPayment>(loadPayment),
    TypedMiddleware<AppState, SavePaymentRequest>(savePayment),
    TypedMiddleware<AppState, RefundPaymentRequest>(refundPayment),
    TypedMiddleware<AppState, ArchivePaymentsRequest>(archivePayment),
    TypedMiddleware<AppState, DeletePaymentsRequest>(deletePayment),
    TypedMiddleware<AppState, RestorePaymentsRequest>(restorePayment),
    TypedMiddleware<AppState, EmailPaymentRequest>(emailPayment),
  ];
}

Middleware<AppState> _editPayment() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditPayment;

    next(action);

    if (store.state.prefState.isMobile || action.payment.isApplying != true) {
      store.dispatch(UpdateCurrentRoute(PaymentEditScreen.route));

      if (store.state.prefState.isMobile) {
        navigatorKey.currentState.pushNamed(PaymentEditScreen.route);
      }
    } else {
      showDialog<PaymentEditScreen>(
          context: navigatorKey.currentContext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return PaymentEditScreen();
          });
    }
  };
}

Middleware<AppState> _viewRefundPayment() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewRefundPayment;

    next(action);

    if (store.state.prefState.isMobile) {
      store.dispatch(UpdateCurrentRoute(PaymentRefundScreen.route));
      navigatorKey.currentState.pushNamed(PaymentRefundScreen.route);
    } else {
      showDialog<PaymentRefundScreen>(
          context: navigatorKey.currentContext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return PaymentRefundScreen();
          });
    }
  };
}

Middleware<AppState> _viewPayment() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    store.dispatch(UpdateCurrentRoute(PaymentViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState.pushNamed(PaymentViewScreen.route);
    }
  };
}

Middleware<AppState> _viewPaymentList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewPaymentList;

    next(action);

    if (store.state.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(PaymentScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState.pushNamedAndRemoveUntil(
          PaymentScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archivePayment(PaymentRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchivePaymentsRequest;
    final prevPayments = action.paymentIds
        .map((id) => store.state.paymentState.map[id])
        .toList();
    repository
        .bulkAction(
            store.state.credentials, action.paymentIds, EntityAction.archive)
        .then((List<PaymentEntity> payments) {
      store.dispatch(ArchivePaymentsSuccess(payments));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchivePaymentsFailure(prevPayments));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _deletePayment(PaymentRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeletePaymentsRequest;
    final prevPayments = action.paymentIds
        .map((id) => store.state.paymentState.map[id])
        .toList();
    repository
        .bulkAction(
            store.state.credentials, action.paymentIds, EntityAction.delete)
        .then((List<PaymentEntity> payments) {
      store.dispatch(DeletePaymentsSuccess(payments));
      store.dispatch(RefreshData());
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeletePaymentsFailure(prevPayments));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _restorePayment(PaymentRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestorePaymentsRequest;
    final prevPayments = action.paymentIds
        .map((id) => store.state.paymentState.map[id])
        .toList();
    repository
        .bulkAction(
            store.state.credentials, action.paymentIds, EntityAction.restore)
        .then((List<PaymentEntity> payments) {
      store.dispatch(RestorePaymentsSuccess(payments));
      store.dispatch(RefreshData());
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestorePaymentsFailure(prevPayments));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _savePayment(PaymentRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SavePaymentRequest;
    final PaymentEntity payment = action.payment;
    final bool sendEmail = payment.isNew ? payment.sendEmail : false;
    repository
        .saveData(store.state.credentials, action.payment, sendEmail: sendEmail)
        .then((PaymentEntity payment) {
      if (action.payment.isNew) {
        store.dispatch(AddPaymentSuccess(payment));
      } else {
        store.dispatch(SavePaymentSuccess(payment));
      }
      store.dispatch(RefreshData());
      action.completer.complete(payment);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SavePaymentFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _refundPayment(PaymentRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RefundPaymentRequest;

    repository
        .refundPayment(store.state.credentials, action.payment)
        .then((PaymentEntity payment) {
      store.dispatch(SavePaymentSuccess(payment));
      store.dispatch(RefundPaymentSuccess(payment));
      store.dispatch(RefreshData());
      action.completer.complete(payment);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RefundPaymentFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _emailPayment(PaymentRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EmailPaymentRequest;
    repository
        .bulkAction(store.state.credentials, action.paymentIds,
            EntityAction.emailPayment)
        .then((List<PaymentEntity> payments) {
      store.dispatch(EmailPaymentSuccess());
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SavePaymentFailure(error));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadPayment(PaymentRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadPayment;

    store.dispatch(LoadPaymentRequest());
    repository
        .loadItem(store.state.credentials, action.paymentId)
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

Middleware<AppState> _loadPayments(PaymentRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadPayments;
    final state = store.state;

    store.dispatch(LoadPaymentsRequest());
    repository
        .loadList(
      state.credentials,
      state.createdAtLimit,
      state.filterDeletedClients,
    )
        .then((data) {
      store.dispatch(LoadPaymentsSuccess(data));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      store.dispatch(LoadRecurringInvoices());
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
