import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';

part 'industry_model.g.dart';

abstract class IndustryListResponse implements Built<IndustryListResponse, IndustryListResponseBuilder> {

  factory IndustryListResponse([void updates(IndustryListResponseBuilder b)]) = _$IndustryListResponse;
  IndustryListResponse._();

  BuiltList<IndustryEntity> get data;

  static Serializer<IndustryListResponse> get serializer => _$industryListResponseSerializer;
}

abstract class IndustryItemResponse implements Built<IndustryItemResponse, IndustryItemResponseBuilder> {

  factory IndustryItemResponse([void updates(IndustryItemResponseBuilder b)]) = _$IndustryItemResponse;
  IndustryItemResponse._();

  IndustryEntity get data;

  static Serializer<IndustryItemResponse> get serializer => _$industryItemResponseSerializer;
}

class IndustryFields {
  static const String name = 'name';
}

abstract class IndustryEntity extends Object with SelectableEntity implements Built<IndustryEntity, IndustryEntityBuilder> {
  
  factory IndustryEntity() {
    return _$IndustryEntity._(
      id: 0,
      name: '',
    );
  }
  IndustryEntity._();

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

  static Serializer<IndustryEntity> get serializer => _$industryEntitySerializer;
}