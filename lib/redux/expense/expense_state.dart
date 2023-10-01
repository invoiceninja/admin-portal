// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/expense_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'expense_state.g.dart';

abstract class ExpenseState
    implements Built<ExpenseState, ExpenseStateBuilder> {
  factory ExpenseState() {
    return _$ExpenseState._(
      map: BuiltMap<String, ExpenseEntity>(),
      list: BuiltList<String>(),
    );
  }

  ExpenseState._();

  @override
  @memoized
  int get hashCode;

  ExpenseEntity get(String expenseId) {
    if (map.containsKey(expenseId)) {
      return map[expenseId]!;
    } else {
      return ExpenseEntity(id: expenseId);
    }
  }

  BuiltMap<String, ExpenseEntity> get map;

  BuiltList<String> get list;

  ExpenseState loadExpenses(BuiltList<ExpenseEntity> clients) {
    final map = Map<String, ExpenseEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<ExpenseState> get serializer => _$expenseStateSerializer;
}

abstract class ExpenseUIState extends Object
    with EntityUIState
    implements Built<ExpenseUIState, ExpenseUIStateBuilder> {
  factory ExpenseUIState(PrefStateSortField? sortField) {
    return _$ExpenseUIState._(
      listUIState: ListUIState(sortField?.field ?? ExpenseFields.number,
          sortAscending: sortField?.ascending ?? false),
      editing: ExpenseEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  ExpenseUIState._();

  @override
  @memoized
  int get hashCode;

  ExpenseEntity? get editing;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<ExpenseUIState> get serializer =>
      _$expenseUIStateSerializer;
}
