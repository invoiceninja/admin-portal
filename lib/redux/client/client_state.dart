import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

part 'client_state.g.dart';

abstract class ClientState implements Built<ClientState, ClientStateBuilder> {
  factory ClientState() {
    return _$ClientState._(
      lastUpdated: 0,
      map: BuiltMap<String, ClientEntity>(),
      list: BuiltList<String>(),
    );
  }
  ClientState._();

  @nullable
  int get lastUpdated;

  BuiltMap<String, ClientEntity> get map;
  BuiltList<String> get list;

  ClientEntity get(String clientId) {
    if (map.containsKey(clientId)) {
      return map[clientId];
    } else {
      return ClientEntity(id: clientId);
    }
  }

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  static Serializer<ClientState> get serializer => _$clientStateSerializer;
}

abstract class ClientUIState extends Object
    with EntityUIState
    implements Built<ClientUIState, ClientUIStateBuilder> {
  factory ClientUIState() {
    return _$ClientUIState._(
      listUIState: ListUIState(ClientFields.name),
      editing: ClientEntity(),
      editingContact: ContactEntity(),
      saveCompleter: null,
    );
  }
  ClientUIState._();

  @nullable
  ClientEntity get editing;

  @nullable
  ContactEntity get editingContact;

  @override
  bool get isCreatingNew => editing.isNew;

  static Serializer<ClientUIState> get serializer => _$clientUIStateSerializer;
}
