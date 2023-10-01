import 'dart:async';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'transaction_rule_state.g.dart';

abstract class TransactionRuleState
    implements Built<TransactionRuleState, TransactionRuleStateBuilder> {
  factory TransactionRuleState() {
    return _$TransactionRuleState._(
      map: BuiltMap<String, TransactionRuleEntity>(),
      list: BuiltList<String>(),
    );
  }
  TransactionRuleState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, TransactionRuleEntity> get map;
  BuiltList<String> get list;

  TransactionRuleEntity get(String transactionRuleId) {
    if (map.containsKey(transactionRuleId)) {
      return map[transactionRuleId]!;
    } else {
      return TransactionRuleEntity(id: transactionRuleId);
    }
  }

  TransactionRuleState loadTransactionRules(
      BuiltList<TransactionRuleEntity> clients) {
    final map = Map<String, TransactionRuleEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<TransactionRuleState> get serializer =>
      _$transactionRuleStateSerializer;
}

abstract class TransactionRuleUIState extends Object
    with EntityUIState
    implements Built<TransactionRuleUIState, TransactionRuleUIStateBuilder> {
  factory TransactionRuleUIState(PrefStateSortField? sortField) {
    return _$TransactionRuleUIState._(
      listUIState: ListUIState(sortField?.field ?? TransactionRuleFields.name,
          sortAscending: sortField?.ascending),
      editing: TransactionRuleEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }
  TransactionRuleUIState._();

  @override
  @memoized
  int get hashCode;

  TransactionRuleEntity? get editing;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<TransactionRuleUIState> get serializer =>
      _$transactionRuleUIStateSerializer;
}
