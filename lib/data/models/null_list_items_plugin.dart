// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

/// Drops null items from a JSON list that's deserialized into a `BuiltList`
/// of non-nullable values, such as the `BuiltList<String>` values of
/// `notifications`, `table_columns` and `pdf_variables`. Without it a single
/// null from the API (or written by another client) fails the whole
/// deserialization with "type 'Null' is not a subtype of type 'String'",
/// which breaks the login.
class NullListItemsPlugin implements SerializerPlugin {
  @override
  Object? beforeDeserialize(Object? object, FullType specifiedType) {
    if (object is! List ||
        specifiedType.root != BuiltList ||
        specifiedType.parameters.length != 1 ||
        specifiedType.parameters.first.nullable ||
        !object.contains(null)) {
      return object;
    }

    return object.where((dynamic item) => item != null).toList();
  }

  @override
  Object? afterDeserialize(Object? object, FullType specifiedType) => object;

  @override
  Object? beforeSerialize(Object? object, FullType specifiedType) => object;

  @override
  Object? afterSerialize(Object? object, FullType specifiedType) => object;
}
