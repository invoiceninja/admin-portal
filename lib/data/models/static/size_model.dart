import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';

part 'size_model.g.dart';

abstract class SizeListResponse implements Built<SizeListResponse, SizeListResponseBuilder> {

  factory SizeListResponse([void updates(SizeListResponseBuilder b)]) = _$SizeListResponse;
  SizeListResponse._();

  BuiltList<SizeEntity> get data;

  static Serializer<SizeListResponse> get serializer => _$sizeListResponseSerializer;
}

abstract class SizeItemResponse implements Built<SizeItemResponse, SizeItemResponseBuilder> {

  factory SizeItemResponse([void updates(SizeItemResponseBuilder b)]) = _$SizeItemResponse;
  SizeItemResponse._();

  SizeEntity get data;

  static Serializer<SizeItemResponse> get serializer => _$sizeItemResponseSerializer;
}

class SizeFields {
  static const String name = 'name';
}

abstract class SizeEntity extends Object with SelectableEntity implements Built<SizeEntity, SizeEntityBuilder> {

  factory SizeEntity() {
    return _$SizeEntity._(
      id: 0,
      name: '',
    );
  }
  SizeEntity._();

  String get name;

  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();

    if (name.toLowerCase().contains(filter)) {
      return true;
    }

    return false;
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    filter = filter.toLowerCase();

    return null;
  }

  @override
  String get listDisplayName {
    return name;
  }

  @override
  double get listDisplayAmount => null;

  static Serializer<SizeEntity> get serializer => _$sizeEntitySerializer;
}