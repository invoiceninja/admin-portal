import 'package:invoiceninja/constants.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'client_state.g.dart';

abstract class ClientState implements Built<ClientState, ClientStateBuilder> {

  bool get isLoading;

  @nullable
  int get lastUpdated;

  BuiltMap<int, ClientEntity> get map;
  BuiltList<int> get list;

  @nullable
  ClientEntity get editing;

  @nullable
  String get editingFor;

  factory ClientState() {
    return _$ClientState._(
      isLoading: false,
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
  //factory ClientState([updates(ClientStateBuilder b)]) = _$ClientState;
  static Serializer<ClientState> get serializer => _$clientStateSerializer;
}