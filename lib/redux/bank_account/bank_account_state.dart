import 'dart:async';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'bank_account_state.g.dart';

abstract class BankAccountState
    implements Built<BankAccountState, BankAccountStateBuilder> {
  factory BankAccountState() {
    return _$BankAccountState._(
      map: BuiltMap<String, BankAccountEntity>(),
      list: BuiltList<String>(),
    );
  }
  BankAccountState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, BankAccountEntity> get map;

  BuiltList<String> get list;

  BankAccountEntity get(String bankAccountId) {
    if (map.containsKey(bankAccountId)) {
      return map[bankAccountId]!;
    } else {
      return BankAccountEntity(id: bankAccountId);
    }
  }

  BankAccountState loadBankAccounts(BuiltList<BankAccountEntity> clients) {
    final map = Map<String, BankAccountEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<BankAccountState> get serializer =>
      _$bankAccountStateSerializer;
}

abstract class BankAccountUIState extends Object
    with EntityUIState
    implements Built<BankAccountUIState, BankAccountUIStateBuilder> {
  factory BankAccountUIState(PrefStateSortField? sortField) {
    return _$BankAccountUIState._(
      listUIState: ListUIState(sortField?.field ?? BankAccountFields.name,
          sortAscending: sortField?.ascending),
      editing: BankAccountEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }
  BankAccountUIState._();

  @override
  @memoized
  int get hashCode;

  BankAccountEntity? get editing;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<BankAccountUIState> get serializer =>
      _$bankAccountUIStateSerializer;
}
