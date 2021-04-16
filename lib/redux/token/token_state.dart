import 'dart:async';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/token_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'token_state.g.dart';

abstract class TokenState implements Built<TokenState, TokenStateBuilder> {
  factory TokenState() {
    return _$TokenState._(
      map: BuiltMap<String, TokenEntity>(),
      list: BuiltList<String>(),
    );
  }

  TokenState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, TokenEntity> get map;

  BuiltList<String> get list;

  TokenState loadTokens(BuiltList<TokenEntity> clients) {
    final map = Map<String, TokenEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<TokenState> get serializer => _$tokenStateSerializer;
}

abstract class TokenUIState extends Object
    with EntityUIState
    implements Built<TokenUIState, TokenUIStateBuilder> {
  factory TokenUIState() {
    return _$TokenUIState._(
      listUIState: ListUIState(TokenFields.name),
      editing: TokenEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  TokenUIState._();

  @override
  @memoized
  int get hashCode;

  @nullable
  TokenEntity get editing;

  @override
  bool get isCreatingNew => editing.isNew;

  @override
  String get editingId => editing.id;

  static Serializer<TokenUIState> get serializer => _$tokenUIStateSerializer;
}
