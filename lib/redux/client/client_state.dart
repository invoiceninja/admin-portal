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

part 'client_state.g.dart';

abstract class ClientState implements Built<ClientState, ClientStateBuilder> {
  factory ClientState() {
    return _$ClientState._(
      map: BuiltMap<String, ClientEntity>(),
      list: BuiltList<String>(),
    );
  }

  ClientState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, ClientEntity> get map;

  BuiltList<String> get list;

  ClientEntity get(String clientId) {
    if (map.containsKey(clientId)) {
      return map[clientId]!;
    } else {
      return ClientEntity(id: clientId);
    }
  }

  ClientState loadClients(BuiltList<ClientEntity> clients) {
    final map = Map<String, ClientEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<ClientState> get serializer => _$clientStateSerializer;
}

abstract class ClientUIState extends Object
    with EntityUIState
    implements Built<ClientUIState, ClientUIStateBuilder> {
  factory ClientUIState(PrefStateSortField? sortField) {
    return _$ClientUIState._(
      listUIState: ListUIState(sortField?.field ?? ClientFields.name,
          sortAscending: sortField?.ascending),
      editing: ClientEntity(),
      editingContact: ClientContactEntity(),
      saveCompleter: null,
      tabIndex: 0,
    );
  }

  ClientUIState._();

  @override
  @memoized
  int get hashCode;

  ClientEntity? get editing;

  ClientContactEntity? get editingContact;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<ClientUIState> get serializer => _$clientUIStateSerializer;
}
