// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

EntityUIState paymentUIReducer(PaymentUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(paymentListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action)
    ..tabIndex = tabIndexReducer(state.tabIndex, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewPayment>((completer, action) => true),
  TypedReducer<bool?, ViewPaymentList>((completer, action) => false),
  TypedReducer<bool?, FilterPaymentsByState>((completer, action) => false),
  TypedReducer<bool?, FilterPaymentsByStatus>((completer, action) => false),
  TypedReducer<bool?, FilterPayments>((completer, action) => false),
  TypedReducer<bool?, FilterPaymentsByCustom1>((completer, action) => false),
  TypedReducer<bool?, FilterPaymentsByCustom2>((completer, action) => false),
  TypedReducer<bool?, FilterPaymentsByCustom3>((completer, action) => false),
  TypedReducer<bool?, FilterPaymentsByCustom4>((completer, action) => false),
]);

final int? Function(int, dynamic) tabIndexReducer = combineReducers<int?>([
  TypedReducer<int?, UpdatePaymentTab>((completer, action) {
    return action.tabIndex;
  }),
  TypedReducer<int?, PreviewEntity>((completer, action) {
    return 0;
  }),
]);

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchivePaymentsSuccess>((completer, action) => ''),
  TypedReducer<String?, DeletePaymentsSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.payment ? action.entityId : selectedId),
  TypedReducer<String?, ViewPayment>((selectedId, action) => action.paymentId),
  TypedReducer<String?, AddPaymentSuccess>(
      (selectedId, action) => action.payment.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortPayments>((selectedId, action) => ''),
  TypedReducer<String?, FilterPayments>((selectedId, action) => ''),
  TypedReducer<String?, FilterPaymentsByState>((selectedId, action) => ''),
  TypedReducer<String?, FilterPaymentsByStatus>((selectedId, action) => ''),
  TypedReducer<String?, FilterPaymentsByCustom1>((selectedId, action) => ''),
  TypedReducer<String?, FilterPaymentsByCustom2>((selectedId, action) => ''),
  TypedReducer<String?, FilterPaymentsByCustom3>((selectedId, action) => ''),
  TypedReducer<String?, FilterPaymentsByCustom4>((selectedId, action) => ''),
  TypedReducer<String?, ClearEntitySelection>((selectedId, action) =>
      action.entityType == EntityType.payment ? '' : selectedId),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.payment
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<PaymentEntity?>([
  TypedReducer<PaymentEntity?, SavePaymentSuccess>(_updateEditing),
  TypedReducer<PaymentEntity?, AddPaymentSuccess>(_updateEditing),
  TypedReducer<PaymentEntity?, RestorePaymentsSuccess>((payments, action) {
    return action.payments[0];
  }),
  TypedReducer<PaymentEntity?, ArchivePaymentsSuccess>((payments, action) {
    return action.payments[0];
  }),
  TypedReducer<PaymentEntity?, DeletePaymentsSuccess>((payments, action) {
    return action.payments[0];
  }),
  TypedReducer<PaymentEntity?, EditPayment>(_updateEditing),
  TypedReducer<PaymentEntity?, ViewRefundPayment>(_updateEditing),
  TypedReducer<PaymentEntity?, UpdatePayment>((payment, action) {
    return action.payment.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<PaymentEntity?, DiscardChanges>(_clearEditing),
]);

PaymentEntity _clearEditing(PaymentEntity? payment, dynamic action) {
  return PaymentEntity();
}

PaymentEntity? _updateEditing(PaymentEntity? payment, dynamic action) {
  return action.payment;
}

final paymentListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortPayments>(_sortPayments),
  TypedReducer<ListUIState, FilterPaymentsByState>(_filterPaymentsByState),
  TypedReducer<ListUIState, FilterPaymentsByStatus>(_filterPaymentsByStatus),
  TypedReducer<ListUIState, FilterPayments>(_filterPayments),
  TypedReducer<ListUIState, FilterPaymentsByCustom1>(_filterPaymentsByCustom1),
  TypedReducer<ListUIState, FilterPaymentsByCustom2>(_filterPaymentsByCustom2),
  TypedReducer<ListUIState, FilterPaymentsByCustom3>(_filterPaymentsByCustom3),
  TypedReducer<ListUIState, FilterPaymentsByCustom4>(_filterPaymentsByCustom4),
  TypedReducer<ListUIState, StartPaymentMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToPaymentMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromPaymentMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearPaymentMultiselect>(_clearListMultiselect),
  TypedReducer<ListUIState, ViewPaymentList>(_viewPaymentList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewPaymentList(
    ListUIState paymentListState, ViewPaymentList action) {
  return paymentListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
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

ListUIState _filterPaymentsByStatus(
    ListUIState paymentListState, FilterPaymentsByStatus action) {
  if (paymentListState.statusFilters.contains(action.status)) {
    return paymentListState
        .rebuild((b) => b..statusFilters.remove(action.status));
  } else {
    return paymentListState.rebuild((b) => b..statusFilters.add(action.status));
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
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState paymentListState, StartPaymentMultiselect action) {
  return paymentListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState paymentListState, AddToPaymentMultiselect action) {
  return paymentListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState paymentListState, RemoveFromPaymentMultiselect action) {
  return paymentListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
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
  TypedReducer<PaymentState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<PaymentState, ArchivePaymentsSuccess>(_archivePaymentSuccess),
  TypedReducer<PaymentState, DeletePaymentsSuccess>(_deletePaymentSuccess),
  TypedReducer<PaymentState, RestorePaymentsSuccess>(_restorePaymentSuccess),
  TypedReducer<PaymentState, PurgeClientSuccess>(_purgeClientSuccess),
]);

PaymentState _purgeClientSuccess(
    PaymentState paymentState, PurgeClientSuccess action) {
  final ids = paymentState.map.values
      .where((each) => each.clientId == action.clientId)
      .map((each) => each.id)
      .toList();

  return paymentState.rebuild((b) => b
    ..map.removeWhere((p0, p1) => ids.contains(p0))
    ..list.removeWhere((p0) => ids.contains(p0)));
}

PaymentState _archivePaymentSuccess(
    PaymentState paymentState, ArchivePaymentsSuccess action) {
  return paymentState.rebuild((b) {
    for (final payment in action.payments) {
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

PaymentState _restorePaymentSuccess(
    PaymentState paymentState, RestorePaymentsSuccess action) {
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

PaymentState _setLoadedCompany(
    PaymentState paymentState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return paymentState.loadPayments(company.payments);
}
