import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_state.dart';

EntityUIState paymentUIReducer(PaymentUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(paymentListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

Reducer<String> selectedIdReducer = combineReducers([
  TypedReducer<String, ViewPayment>((selectedId, action) => action.paymentId),
  TypedReducer<String, AddPaymentSuccess>(
      (selectedId, action) => action.payment.id),
  TypedReducer<String, SelectCompany>((selectedId, action) => ''),
]);

final editingReducer = combineReducers<PaymentEntity>([
  TypedReducer<PaymentEntity, SavePaymentSuccess>(_updateEditing),
  TypedReducer<PaymentEntity, AddPaymentSuccess>(_updateEditing),
  TypedReducer<PaymentEntity, RestorePaymentsSuccess>((payments, action) {
    return action.payments[0];
  }),
  TypedReducer<PaymentEntity, ArchivePaymentsSuccess>((payments, action) {
    return action.payments[0];
  }),
  TypedReducer<PaymentEntity, DeletePaymentsSuccess>((payments, action) {
    return action.payments[0];
  }),
  TypedReducer<PaymentEntity, EditPayment>(_updateEditing),
  TypedReducer<PaymentEntity, RefundPayment>(_updateEditing),
  TypedReducer<PaymentEntity, UpdatePayment>((payment, action) {
    return action.payment.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<PaymentEntity, SelectCompany>(_clearEditing),
  TypedReducer<PaymentEntity, DiscardChanges>(_clearEditing),
]);

PaymentEntity _clearEditing(PaymentEntity payment, dynamic action) {
  return PaymentEntity();
}

PaymentEntity _updateEditing(PaymentEntity payment, dynamic action) {
  return action.payment;
}

final paymentListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortPayments>(_sortPayments),
  TypedReducer<ListUIState, FilterPaymentsByState>(_filterPaymentsByState),
  TypedReducer<ListUIState, FilterPayments>(_filterPayments),
  TypedReducer<ListUIState, FilterPaymentsByCustom1>(_filterPaymentsByCustom1),
  TypedReducer<ListUIState, FilterPaymentsByCustom2>(_filterPaymentsByCustom2),
  TypedReducer<ListUIState, FilterPaymentsByCustom3>(_filterPaymentsByCustom3),
  TypedReducer<ListUIState, FilterPaymentsByCustom4>(_filterPaymentsByCustom4),
  TypedReducer<ListUIState, FilterPaymentsByEntity>(_filterPaymentsByEntity),
  TypedReducer<ListUIState, StartPaymentMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToPaymentMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromPaymentMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearPaymentMultiselect>(_clearListMultiselect),
]);

ListUIState _filterPaymentsByEntity(
    ListUIState paymentListState, FilterPaymentsByEntity action) {
  return paymentListState.rebuild((b) => b
    ..filterEntityId = action.entityId
    ..filterEntityType = action.entityType);
}

ListUIState _filterPaymentsByCustom1(
    ListUIState paymentListState, FilterPaymentsByCustom1 action) {
  if (paymentListState.custom1Filters.contains(action.value)) {
    return paymentListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return paymentListState.rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterPaymentsByCustom2(
    ListUIState paymentListState, FilterPaymentsByCustom2 action) {
  if (paymentListState.custom2Filters.contains(action.value)) {
    return paymentListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return paymentListState.rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterPaymentsByCustom3(
    ListUIState paymentListState, FilterPaymentsByCustom3 action) {
  if (paymentListState.custom3Filters.contains(action.value)) {
    return paymentListState
        .rebuild((b) => b..custom3Filters.remove(action.value));
  } else {
    return paymentListState.rebuild((b) => b..custom3Filters.add(action.value));
  }
}

ListUIState _filterPaymentsByCustom4(
    ListUIState paymentListState, FilterPaymentsByCustom4 action) {
  if (paymentListState.custom4Filters.contains(action.value)) {
    return paymentListState
        .rebuild((b) => b..custom4Filters.remove(action.value));
  } else {
    return paymentListState.rebuild((b) => b..custom4Filters.add(action.value));
  }
}

ListUIState _filterPaymentsByState(
    ListUIState paymentListState, FilterPaymentsByState action) {
  if (paymentListState.stateFilters.contains(action.state)) {
    return paymentListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return paymentListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterPayments(
    ListUIState paymentListState, FilterPayments action) {
  return paymentListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : paymentListState.filterClearedAt);
}

ListUIState _sortPayments(ListUIState paymentListState, SortPayments action) {
  return paymentListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState paymentListState, StartPaymentMultiselect action) {
  return paymentListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState paymentListState, AddToPaymentMultiselect action) {
  return paymentListState.rebuild((b) => b..selectedIds.add(action.entity.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState paymentListState, RemoveFromPaymentMultiselect action) {
  return paymentListState
      .rebuild((b) => b..selectedIds.remove(action.entity.id));
}

ListUIState _clearListMultiselect(
    ListUIState paymentListState, ClearPaymentMultiselect action) {
  return paymentListState.rebuild((b) => b..selectedIds = null);
}

final paymentsReducer = combineReducers<PaymentState>([
  TypedReducer<PaymentState, SavePaymentSuccess>(_updatePayment),
  TypedReducer<PaymentState, AddPaymentSuccess>(_addPayment),
  TypedReducer<PaymentState, LoadPaymentsSuccess>(_setLoadedPayments),
  TypedReducer<PaymentState, LoadPaymentSuccess>(_setLoadedPayment),
  TypedReducer<PaymentState, ArchivePaymentsRequest>(_archivePaymentRequest),
  TypedReducer<PaymentState, ArchivePaymentsSuccess>(_archivePaymentSuccess),
  TypedReducer<PaymentState, ArchivePaymentsFailure>(_archivePaymentFailure),
  TypedReducer<PaymentState, DeletePaymentsRequest>(_deletePaymentRequest),
  TypedReducer<PaymentState, DeletePaymentsSuccess>(_deletePaymentSuccess),
  TypedReducer<PaymentState, DeletePaymentsFailure>(_deletePaymentFailure),
  TypedReducer<PaymentState, RestorePaymentsRequest>(_restorePaymentRequest),
  TypedReducer<PaymentState, RestorePaymentsSuccess>(_restorePaymentSuccess),
  TypedReducer<PaymentState, RestorePaymentsFailure>(_restorePaymentFailure),
]);

PaymentState _archivePaymentRequest(
    PaymentState paymentState, ArchivePaymentsRequest action) {
  final payments = action.paymentIds.map((id) => paymentState.map[id]).toList();

  for (int i = 0; i < payments.length; i++) {
    payments[i] = payments[i]
        .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);
  }
  return paymentState.rebuild((b) {
    for (final payment in payments) {
      b.map[payment.id] = payment;
    }
  });
}

PaymentState _archivePaymentSuccess(
    PaymentState paymentState, ArchivePaymentsSuccess action) {
  return paymentState.rebuild((b) {
    for (final payment in action.payments) {
      b.map[payment.id] = payment;
    }
  });
}

PaymentState _archivePaymentFailure(
    PaymentState paymentState, ArchivePaymentsFailure action) {
  return paymentState.rebuild((b) {
    for (final payment in action.payments) {
      b.map[payment.id] = payment;
    }
  });
}

PaymentState _deletePaymentRequest(
    PaymentState paymentState, DeletePaymentsRequest action) {
  final payments = action.paymentIds.map((id) => paymentState.map[id]).toList();

  for (int i = 0; i < payments.length; i++) {
    payments[i] = payments[i].rebuild((b) => b
      ..archivedAt = DateTime.now().millisecondsSinceEpoch
      ..isDeleted = true);
  }
  return paymentState.rebuild((b) {
    for (final payment in payments) {
      b.map[payment.id] = payment;
    }
  });
}

PaymentState _deletePaymentSuccess(
    PaymentState paymentState, DeletePaymentsSuccess action) {
  return paymentState.rebuild((b) {
    for (final payment in action.payments) {
      b.map[payment.id] = payment;
    }
  });
}

PaymentState _deletePaymentFailure(
    PaymentState paymentState, DeletePaymentsFailure action) {
  return paymentState.rebuild((b) {
    for (final payment in action.payments) {
      b.map[payment.id] = payment;
    }
  });
}

PaymentState _restorePaymentRequest(
    PaymentState paymentState, RestorePaymentsRequest action) {
  final payments = action.paymentIds.map((id) => paymentState.map[id]).toList();

  for (int i = 0; i < payments.length; i++) {
    payments[i] = payments[i].rebuild((b) => b
      ..archivedAt = null
      ..isDeleted = false);
  }
  return paymentState.rebuild((b) {
    for (final payment in payments) {
      b.map[payment.id] = payment;
    }
  });
}

PaymentState _restorePaymentSuccess(
    PaymentState paymentState, RestorePaymentsSuccess action) {
  return paymentState.rebuild((b) {
    for (final payment in action.payments) {
      b.map[payment.id] = payment;
    }
  });
}

PaymentState _restorePaymentFailure(
    PaymentState paymentState, RestorePaymentsFailure action) {
  return paymentState.rebuild((b) {
    for (final payment in action.payments) {
      b.map[payment.id] = payment;
    }
  });
}

PaymentState _addPayment(PaymentState paymentState, AddPaymentSuccess action) {
  return paymentState.rebuild((b) => b
    ..map[action.payment.id] = action.payment
    ..list.add(action.payment.id));
}

PaymentState _updatePayment(
    PaymentState paymentState, SavePaymentSuccess action) {
  return paymentState
      .rebuild((b) => b..map[action.payment.id] = action.payment);
}

PaymentState _setLoadedPayment(
    PaymentState paymentState, LoadPaymentSuccess action) {
  return paymentState
      .rebuild((b) => b..map[action.payment.id] = action.payment);
}

PaymentState _setLoadedPayments(
        PaymentState paymentState, LoadPaymentsSuccess action) =>
    paymentState.loadPayments(action.payments);
