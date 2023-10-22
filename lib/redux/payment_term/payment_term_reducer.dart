// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/payment_term_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_actions.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

EntityUIState paymentTermUIReducer(PaymentTermUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(paymentTermListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewPaymentTerm>((completer, action) => true),
  TypedReducer<bool?, ViewPaymentTermList>((completer, action) => false),
  TypedReducer<bool?, FilterPaymentTermsByState>((completer, action) => false),
  TypedReducer<bool?, FilterPaymentTerms>((completer, action) => false),
  TypedReducer<bool?, FilterPaymentTermsByCustom1>(
      (completer, action) => false),
  TypedReducer<bool?, FilterPaymentTermsByCustom2>(
      (completer, action) => false),
  TypedReducer<bool?, FilterPaymentTermsByCustom3>(
      (completer, action) => false),
  TypedReducer<bool?, FilterPaymentTermsByCustom4>(
      (completer, action) => false),
]);

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchivePaymentTermsSuccess>((completer, action) => ''),
  TypedReducer<String?, DeletePaymentTermsSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.paymentTerm
          ? action.entityId
          : selectedId),
  TypedReducer<String?, ViewPaymentTerm>(
      (String? selectedId, dynamic action) => action.paymentTermId),
  TypedReducer<String?, AddPaymentTermSuccess>(
      (String? selectedId, dynamic action) => action.paymentTerm.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortPaymentTerms>((selectedId, action) => ''),
  TypedReducer<String?, FilterPaymentTerms>((selectedId, action) => ''),
  TypedReducer<String?, FilterPaymentTermsByState>((selectedId, action) => ''),
  TypedReducer<String?, FilterPaymentTermsByCustom1>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterPaymentTermsByCustom2>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterPaymentTermsByCustom3>(
      (selectedId, action) => ''),
  TypedReducer<String?, FilterPaymentTermsByCustom4>(
      (selectedId, action) => ''),
]);

final editingReducer = combineReducers<PaymentTermEntity?>([
  TypedReducer<PaymentTermEntity?, SavePaymentTermSuccess>(_updateEditing),
  TypedReducer<PaymentTermEntity?, AddPaymentTermSuccess>(_updateEditing),
  TypedReducer<PaymentTermEntity?, RestorePaymentTermsSuccess>(
      (paymentTerms, action) {
    return action.paymentTerms[0];
  }),
  TypedReducer<PaymentTermEntity?, ArchivePaymentTermsSuccess>(
      (paymentTerms, action) {
    return action.paymentTerms[0];
  }),
  TypedReducer<PaymentTermEntity?, DeletePaymentTermsSuccess>(
      (paymentTerms, action) {
    return action.paymentTerms[0];
  }),
  TypedReducer<PaymentTermEntity?, EditPaymentTerm>(_updateEditing),
  TypedReducer<PaymentTermEntity?, UpdatePaymentTerm>((paymentTerm, action) {
    return action.paymentTerm.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<PaymentTermEntity?, DiscardChanges>(_clearEditing),
]);

PaymentTermEntity _clearEditing(
    PaymentTermEntity? paymentTerm, dynamic action) {
  return PaymentTermEntity();
}

PaymentTermEntity? _updateEditing(
    PaymentTermEntity? paymentTerm, dynamic action) {
  return action.paymentTerm;
}

final paymentTermListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortPaymentTerms>(_sortPaymentTerms),
  TypedReducer<ListUIState, FilterPaymentTermsByState>(
      _filterPaymentTermsByState),
  TypedReducer<ListUIState, FilterPaymentTerms>(_filterPaymentTerms),
  TypedReducer<ListUIState, FilterPaymentTermsByCustom1>(
      _filterPaymentTermsByCustom1),
  TypedReducer<ListUIState, FilterPaymentTermsByCustom2>(
      _filterPaymentTermsByCustom2),
  TypedReducer<ListUIState, StartPaymentTermMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToPaymentTermMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromPaymentTermMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearPaymentTermMultiselect>(_clearListMultiselect),
  TypedReducer<ListUIState, ViewPaymentTermList>(_viewPaymentTermList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewPaymentTermList(
    ListUIState paymentTermListState, ViewPaymentTermList action) {
  return paymentTermListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
}

ListUIState _filterPaymentTermsByCustom1(
    ListUIState paymentTermListState, FilterPaymentTermsByCustom1 action) {
  if (paymentTermListState.custom1Filters.contains(action.value)) {
    return paymentTermListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return paymentTermListState
        .rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterPaymentTermsByCustom2(
    ListUIState paymentTermListState, FilterPaymentTermsByCustom2 action) {
  if (paymentTermListState.custom2Filters.contains(action.value)) {
    return paymentTermListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return paymentTermListState
        .rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterPaymentTermsByState(
    ListUIState paymentTermListState, FilterPaymentTermsByState action) {
  if (paymentTermListState.stateFilters.contains(action.state)) {
    return paymentTermListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return paymentTermListState
        .rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterPaymentTerms(
    ListUIState paymentTermListState, FilterPaymentTerms action) {
  return paymentTermListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : paymentTermListState.filterClearedAt);
}

ListUIState _sortPaymentTerms(
    ListUIState paymentTermListState, SortPaymentTerms action) {
  return paymentTermListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartPaymentTermMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToPaymentTermMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState productListState, RemoveFromPaymentTermMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearPaymentTermMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
}

final paymentTermsReducer = combineReducers<PaymentTermState>([
  TypedReducer<PaymentTermState, SavePaymentTermSuccess>(_updatePaymentTerm),
  TypedReducer<PaymentTermState, AddPaymentTermSuccess>(_addPaymentTerm),
  TypedReducer<PaymentTermState, LoadPaymentTermsSuccess>(
      _setLoadedPaymentTerms),
  TypedReducer<PaymentTermState, LoadPaymentTermSuccess>(_setLoadedPaymentTerm),
  TypedReducer<PaymentTermState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<PaymentTermState, ArchivePaymentTermsSuccess>(
      _archivePaymentTermSuccess),
  TypedReducer<PaymentTermState, DeletePaymentTermsSuccess>(
      _deletePaymentTermSuccess),
  TypedReducer<PaymentTermState, RestorePaymentTermsSuccess>(
      _restorePaymentTermSuccess),
]);

PaymentTermState _archivePaymentTermSuccess(
    PaymentTermState paymentTermState, ArchivePaymentTermsSuccess action) {
  return paymentTermState.rebuild((b) {
    for (final paymentTerm in action.paymentTerms) {
      b.map[paymentTerm.id] = paymentTerm;
    }
  });
}

PaymentTermState _deletePaymentTermSuccess(
    PaymentTermState paymentTermState, DeletePaymentTermsSuccess action) {
  return paymentTermState.rebuild((b) {
    for (final paymentTerm in action.paymentTerms) {
      b.map[paymentTerm.id] = paymentTerm;
    }
  });
}

PaymentTermState _restorePaymentTermSuccess(
    PaymentTermState paymentTermState, RestorePaymentTermsSuccess action) {
  return paymentTermState.rebuild((b) {
    for (final paymentTerm in action.paymentTerms) {
      b.map[paymentTerm.id] = paymentTerm;
    }
  });
}

PaymentTermState _addPaymentTerm(
    PaymentTermState paymentTermState, AddPaymentTermSuccess action) {
  return paymentTermState.rebuild((b) => b
    ..map[action.paymentTerm.id] = action.paymentTerm
    ..list.add(action.paymentTerm.id));
}

PaymentTermState _updatePaymentTerm(
    PaymentTermState paymentTermState, SavePaymentTermSuccess action) {
  return paymentTermState
      .rebuild((b) => b..map[action.paymentTerm.id] = action.paymentTerm);
}

PaymentTermState _setLoadedPaymentTerm(
    PaymentTermState paymentTermState, LoadPaymentTermSuccess action) {
  return paymentTermState
      .rebuild((b) => b..map[action.paymentTerm.id] = action.paymentTerm);
}

PaymentTermState _setLoadedPaymentTerms(
        PaymentTermState paymentTermState, LoadPaymentTermsSuccess action) =>
    paymentTermState.loadPaymentTerms(action.paymentTerms);

PaymentTermState _setLoadedCompany(
    PaymentTermState paymentTermState, LoadCompanySuccess action) {
  final state = paymentTermState.rebuild((b) => b
    ..map.addAll(Map.fromIterable(
      action.userCompany.company.paymentTerms,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}
