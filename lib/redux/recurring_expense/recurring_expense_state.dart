// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/recurring_expense_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'recurring_expense_state.g.dart';

abstract class RecurringExpenseState
    implements Built<RecurringExpenseState, RecurringExpenseStateBuilder> {
  factory RecurringExpenseState() {
    return _$RecurringExpenseState._(
      map: BuiltMap<String, ExpenseEntity>(),
      list: BuiltList<String>(),
    );
  }
  RecurringExpenseState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, ExpenseEntity> get map;
  BuiltList<String> get list;

  ExpenseEntity get(String recurringExpenseId) {
    if (map.containsKey(recurringExpenseId)) {
      return map[recurringExpenseId]!;
    } else {
      return ExpenseEntity(id: recurringExpenseId);
    }
  }

  RecurringExpenseState loadRecurringExpenses(
      BuiltList<ExpenseEntity> clients) {
    final map = Map<String, ExpenseEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<RecurringExpenseState> get serializer =>
      _$recurringExpenseStateSerializer;
}

abstract class RecurringExpenseUIState extends Object
    with EntityUIState
    implements Built<RecurringExpenseUIState, RecurringExpenseUIStateBuilder> {
  factory RecurringExpenseUIState(PrefStateSortField? sortField) {
    return _$RecurringExpenseUIState._(
      listUIState: ListUIState(
          sortField?.field ?? RecurringExpenseFields.number,
          sortAscending: sortField?.ascending),
      editing: ExpenseEntity(entityType: EntityType.recurringExpense),
      selectedId: '',
      tabIndex: 0,
    );
  }
  RecurringExpenseUIState._();

  @override
  @memoized
  int get hashCode;

  ExpenseEntity? get editing;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<RecurringExpenseUIState> get serializer =>
      _$recurringExpenseUIStateSerializer;
}
