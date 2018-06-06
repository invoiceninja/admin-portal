import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/entities.dart';

part 'client_model.g.dart';

abstract class ClientListResponse implements Built<ClientListResponse, ClientListResponseBuilder> {

  BuiltList<ClientEntity> get data;

  ClientListResponse._();
  factory ClientListResponse([updates(ClientListResponseBuilder b)]) = _$ClientListResponse;
  static Serializer<ClientListResponse> get serializer => _$clientListResponseSerializer;
}

abstract class ClientItemResponse implements Built<ClientItemResponse, ClientItemResponseBuilder> {

  ClientEntity get data;

  ClientItemResponse._();
  factory ClientItemResponse([updates(ClientItemResponseBuilder b)]) = _$ClientItemResponse;
  static Serializer<ClientItemResponse> get serializer => _$clientItemResponseSerializer;
}

class ClientFields {
  static const String name = 'name';

  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
}


abstract class ClientEntity extends Object with BaseEntity implements Built<ClientEntity, ClientEntityBuilder> {


  @nullable
  @BuiltValueField(wireName: 'name')
  String get name;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;


  @nullable
  @BuiltValueField(wireName: 'updated_at')
  int get updatedAt;

  @nullable
  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @nullable
  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  int compareTo(ClientEntity client, String sortField, bool sortAscending) {
    int response = 0;
    ClientEntity clientA = sortAscending ? this : client;
    ClientEntity clientB = sortAscending ? client: this;

    /*
    switch (sortField) {
      case ClientFields.cost:
        response = clientA.cost.compareTo(clientB.cost);
    }
    */

    if (response == 0) {
      return clientA.name.compareTo(clientB.name);
    } else {
      return response;
    }
  }

  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }

    return name.contains(search);
  }

  ClientEntity._();
  factory ClientEntity([updates(ClientEntityBuilder b)]) = _$ClientEntity;
  static Serializer<ClientEntity> get serializer => _$clientEntitySerializer;
}
