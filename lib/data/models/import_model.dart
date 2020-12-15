import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';

part 'import_model.g.dart';

abstract class PreImportResponse
    implements Built<PreImportResponse, PreImportResponseBuilder> {
  factory PreImportResponse() {
    return _$PreImportResponse._();
  }

  PreImportResponse._();

  @override
  @memoized
  int get hashCode;

  String get hash;

  BuiltList<BuiltList<String>> get headers;

  BuiltList<String> get available;

  BuiltList<String> get fields1 =>
      headers.isEmpty ? BuiltList<String>() : headers[0];

  BuiltList<String> get fields2 =>
      headers.length < 2 ? BuiltList<String>() : headers[1];

  static Serializer<PreImportResponse> get serializer =>
      _$preImportResponseSerializer;
}

abstract class ImportRequest
    implements Built<ImportRequest, ImportRequestBuilder> {
  factory ImportRequest({
    @required String hash,
    @required String entityType,
    @required bool skipHeader,
    @required BuiltMap<int, String> columnMap,
  }) {
    return _$ImportRequest._(
      hash: hash,
      entityType: entityType,
      skipHeader: skipHeader,
      columnMap: columnMap,
    );
  }

  ImportRequest._();

  @override
  @memoized
  int get hashCode;

  String get hash;

  @BuiltValueField(wireName: 'entity_type')
  String get entityType;

  @BuiltValueField(wireName: 'skip_header')
  bool get skipHeader;

  @BuiltValueField(wireName: 'column_map')
  BuiltMap<int, String> get columnMap;

  static Serializer<ImportRequest> get serializer => _$importRequestSerializer;
}
