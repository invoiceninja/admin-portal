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

Reducer<int> selectedIdReducer = combineReducers([
  TypedReducer<int, ViewPayment>(
      (int selectedId, dynamic action) => action.paymentId),
  TypedReducer<int, AddPaymentSuccess>(
      (int selectedId, dynamic action) => action.payment.id),
]);

final editingReducer = combineReducers<PaymentEntity>([
  TypedReducer<PaymentEntity, SavePaymentSuccess>(_updateEditing),
  TypedReducer<PaymentEntity, AddPaymentSuccess>(_updateEditing),
  TypedReducer<PaymentEntity, RestorePaymentSuccess>(_updateEditing),
  TypedReducer<PaymentEntity, ArchivePaymentSuccess>(_updateEditing),
  TypedReducer<PaymentEntity, DeletePaymentSuccess>(_updateEditing),
  TypedReducer<PaymentEntity, EditPayment>(_updateEditing),
  TypedReducer<PaymentEntity, UpdatePayment>(_updateEditing),
  TypedReducer<PaymentEntity, SelectCompany>(_clearEditing),
]);

PaymentEntity _clearEditing(PaymentEntity payment, SelectCompany action) {
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
  TypedReducer<ListUIState, FilterPaymentsByEntity>(_filterPaymentsByEntity),
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
  return paymentListState.rebuild((b) => b..filter = action.filter);
}

ListUIState _sortPayments(ListUIState paymentListState, SortPayments action) {
  return paymentListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

final paymentsReducer = combineReducers<PaymentState>([
  TypedReducer<PaymentState, SavePaymentSuccess>(_updatePayment),
  TypedReducer<PaymentState, AddPaymentSuccess>(_addPayment),
  TypedReducer<PaymentState, LoadPaymentsSuccess>(_setLoadedPayments),
  TypedReducer<PaymentState, LoadPaymentSuccess>(_setLoadedPayment),
  TypedReducer<PaymentState, ArchivePaymentRequest>(_archivePaymentRequest),
  TypedReducer<PaymentState, ArchivePaymentSuccess>(_archivePaymentSuccess),
  TypedReducer<PaymentState, ArchivePaymentFailure>(_archivePaymentFailure),
  TypedReducer<PaymentState, DeletePaymentRequest>(_deletePaymentRequest),
  TypedReducer<PaymentState, DeletePaymentSuccess>(_deletePaymentSuccess),
  TypedReducer<PaymentState, DeletePaymentFailure>(_deletePaymentFailure),
  TypedReducer<PaymentState, RestorePaymentRequest>(_restorePaymentRequest),
  TypedReducer<PaymentState, RestorePaymentSuccess>(_restorePaymentSuccess),
  TypedReducer<PaymentState, RestorePaymentFailure>(_restorePaymentFailure),
]);

PaymentState _archivePaymentRequest(
    PaymentState paymentState, ArchivePaymentRequest action) {
  final payment = paymentState.map[action.paymentId]
      .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);

  return paymentState.rebuild((b) => b..map[action.paymentId] = payment);
}

PaymentState _archivePaymentSuccess(
    PaymentState paymentState, ArchivePaymentSuccess action) {
  return paymentState
      .rebuild((b) => b..map[action.payment.id] = action.payment);
}

PaymentState _archivePaymentFailure(
    PaymentState paymentState, ArchivePaymentFailure action) {
  return paymentState
      .rebuild((b) => b..map[action.payment.id] = action.payment);
}

PaymentState _deletePaymentRequest(
    PaymentState paymentState, DeletePaymentRequest action) {
  final payment = paymentState.map[action.paymentId].rebuild((b) => b
    ..archivedAt = DateTime.now().millisecondsSinceEpoch
    ..isDeleted = true);

  return paymentState.rebuild((b) => b..map[action.paymentId] = payment);
}

PaymentState _deletePaymentSuccess(
    PaymentState paymentState, DeletePaymentSuccess action) {
  return paymentState
      .rebuild((b) => b..map[action.payment.id] = action.payment);
}

PaymentState _deletePaymentFailure(
    PaymentState paymentState, DeletePaymentFailure action) {
  return paymentState
      .rebuild((b) => b..map[action.payment.id] = action.payment);
}

PaymentState _restorePaymentRequest(
    PaymentState paymentState, RestorePaymentRequest action) {
  final payment = paymentState.map[action.paymentId].rebuild((b) => b
    ..archivedAt = null
    ..isDeleted = false);
  return paymentState.rebuild((b) => b..map[action.paymentId] = payment);
}

PaymentState _restorePaymentSuccess(
    PaymentState paymentState, RestorePaymentSuccess action) {
  return paymentState
      .rebuild((b) => b..map[action.payment.id] = action.payment);
}

PaymentState _restorePaymentFailure(
    PaymentState paymentState, RestorePaymentFailure action) {
  return paymentState
      .rebuild((b) => b..map[action.payment.id] = action.payment);
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
    PaymentState paymentState, LoadPaymentsSuccess action) {
  final state = paymentState.rebuild((b) => b
    ..lastUpdated = DateTime.now().millisecondsSinceEpoch
    ..map.addAll(Map.fromIterable(
      action.payments,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}
