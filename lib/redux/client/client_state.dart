import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

part 'client_state.g.dart';

abstract class ClientState implements Built<ClientState, ClientStateBuilder> {

  factory ClientState() {
    return _$ClientState._(
      map: BuiltMap<int, ClientEntity>(),
      list: BuiltList<int>(),
    );
  }
  ClientState._();

  @nullable
  int get lastUpdated;

  BuiltMap<int, ClientEntity> get map;
  BuiltList<int> get list;

  bool get isStale {
    if (! isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated > kMillisecondsToRefreshData;
  }

  bool get isLoaded {
    return lastUpdated != null;
  }

  static Serializer<ClientState> get serializer => _$clientStateSerializer;
}

abstract class ClientUIState extends Object with EntityUIState implements Built<ClientUIState, ClientUIStateBuilder> {

  factory ClientUIState() {
    return _$ClientUIState._(
      listUIState: ListUIState(ClientFields.name),
      editing: ClientEntity(),
      selectedId: 0,
    );
  }
  ClientUIState._();

  @nullable
  ClientEntity get editing;

  @override
  bool get isCreatingNew => editing.isNew;

  static Serializer<ClientUIState> get serializer => _$clientUIStateSerializer;
}