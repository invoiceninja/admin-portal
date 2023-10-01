// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'expense_category_state.g.dart';

abstract class ExpenseCategoryState
    implements Built<ExpenseCategoryState, ExpenseCategoryStateBuilder> {
  factory ExpenseCategoryState() {
    return _$ExpenseCategoryState._(
      map: BuiltMap<String, ExpenseCategoryEntity>(),
      list: BuiltList<String>(),
    );
  }

  ExpenseCategoryState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, ExpenseCategoryEntity> get map;

  ExpenseCategoryEntity get(String categoryId) {
    if (map.containsKey(categoryId)) {
      return map[categoryId]!;
    } else {
      return ExpenseCategoryEntity(id: categoryId);
    }
  }

  BuiltList<String> get list;

  ExpenseCategoryState loadExpenseCategories(
      BuiltList<ExpenseCategoryEntity> clients) {
    final map = Map<String, ExpenseCategoryEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<ExpenseCategoryState> get serializer =>
      _$expenseCategoryStateSerializer;
}

abstract class ExpenseCategoryUIState extends Object
    with EntityUIState
    implements Built<ExpenseCategoryUIState, ExpenseCategoryUIStateBuilder> {
  factory ExpenseCategoryUIState(PrefStateSortField? sortField) {
    return _$ExpenseCategoryUIState._(
      listUIState: ListUIState(sortField?.field ?? ExpenseCategoryFields.name,
          sortAscending: sortField?.ascending),
      editing: ExpenseCategoryEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  ExpenseCategoryUIState._();

  @override
  @memoized
  int get hashCode;

  ExpenseCategoryEntity? get editing;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<ExpenseCategoryUIState> get serializer =>
      _$expenseCategoryUIStateSerializer;
}
