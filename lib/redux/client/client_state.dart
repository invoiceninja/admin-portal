import 'package:invoiceninja/constants.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja/redux/ui/list_ui_state.dart';

part 'client_state.g.dart';

abstract class ClientState implements Built<ClientState, ClientStateBuilder> {

  @nullable
  int get lastUpdated;

  BuiltMap<int, ClientEntity> get map;
  BuiltList<int> get list;

  @nullable
  ClientEntity get editing;

  factory ClientState() {
    return _$ClientState._(
      map: BuiltMap<int, ClientEntity>(),
      list: BuiltList<int>(),
    );
  }

  bool get isStale {
    if (! isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated > kMillisecondsToRefreshData;
  }

  bool get isLoaded {
    return lastUpdated != null;
  }

  ClientState._();
  static Serializer<ClientState> get serializer => _$clientStateSerializer;
}

abstract class ClientUIState extends Object with EntityUIState implements Built<ClientUIState, ClientUIStateBuilder> {

  @nullable
  ProductEntity get editing;

  factory ClientUIState() {
    return _$ClientUIState._(
      listUIState: ListUIState(ClientFields.name),
    );
  }

  ClientUIState._();
  static Serializer<ClientUIState> get serializer => _$clientUIStateSerializer;
}