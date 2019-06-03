import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/expense_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

part 'expense_state.g.dart';

abstract class ExpenseState
    implements Built<ExpenseState, ExpenseStateBuilder> {
  factory ExpenseState() {
    return _$ExpenseState._(
      lastUpdated: 0,
      map: BuiltMap<int, ExpenseEntity>(),
      list: BuiltList<int>(),
    );
  }
  ExpenseState._();

  @nullable
  int get lastUpdated;

  BuiltMap<int, ExpenseEntity> get map;
  BuiltList<int> get list;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  static Serializer<ExpenseState> get serializer => _$expenseStateSerializer;
}

abstract class ExpenseUIState extends Object
    with EntityUIState
    implements Built<ExpenseUIState, ExpenseUIStateBuilder> {
  factory ExpenseUIState() {
    return _$ExpenseUIState._(
      listUIState: ListUIState(ExpenseFields.expenseDate),
      editing: ExpenseEntity(),
      selectedId: 0,
    );
  }
  ExpenseUIState._();

  @nullable
  ExpenseEntity get editing;

  @override
  bool get isCreatingNew => editing.isNew;

  static Serializer<ExpenseUIState> get serializer =>
      _$expenseUIStateSerializer;
}
