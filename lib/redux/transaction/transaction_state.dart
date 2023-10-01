import 'dart:async';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'transaction_state.g.dart';

abstract class TransactionState
    implements Built<TransactionState, TransactionStateBuilder> {
  factory TransactionState() {
    return _$TransactionState._(
      map: BuiltMap<String, TransactionEntity>(),
      list: BuiltList<String>(),
    );
  }
  TransactionState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, TransactionEntity> get map;
  BuiltList<String> get list;

  TransactionEntity get(String transactionId) {
    if (map.containsKey(transactionId)) {
      return map[transactionId]!;
    } else {
      return TransactionEntity(id: transactionId);
    }
  }

  TransactionState loadTransactions(BuiltList<TransactionEntity> transactions) {
    final map = Map<String, TransactionEntity>.fromIterable(
      transactions,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<TransactionState> get serializer =>
      _$transactionStateSerializer;
}

abstract class TransactionUIState extends Object
    with EntityUIState
    implements Built<TransactionUIState, TransactionUIStateBuilder> {
  factory TransactionUIState(PrefStateSortField? sortField) {
    return _$TransactionUIState._(
      listUIState: ListUIState(
        sortField?.field ?? TransactionFields.date,
        sortAscending: sortField?.ascending,
      ),
      editing: TransactionEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }
  TransactionUIState._();

  @override
  @memoized
  int get hashCode;

  TransactionEntity? get editing;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<TransactionUIState> get serializer =>
      _$transactionUIStateSerializer;
}
