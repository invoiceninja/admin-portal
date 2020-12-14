import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

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

  BuiltList<String> get fields1 =>
      headers.isEmpty ? BuiltList<String>() : headers[0];

  BuiltList<String> get fields2 =>
      headers.length < 2 ? BuiltList<String>() : headers[1];

  static Serializer<PreImportResponse> get serializer =>
      _$preImportResponseSerializer;
}
