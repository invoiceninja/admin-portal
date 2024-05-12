// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';

part 'e_invoice_model.g.dart';

abstract class EInvoiceFieldEntity
    implements Built<EInvoiceFieldEntity, EInvoiceFieldEntityBuilder> {
  factory EInvoiceFieldEntity() {
    return _$EInvoiceFieldEntity._(
      type: '',
      help: '',
      choices: BuiltList<String>(),
    );
  }
  EInvoiceFieldEntity._();

  @override
  @memoized
  int get hashCode;

  String get type;

  String get help;

  BuiltList<String> get choices;

  static Serializer<EInvoiceFieldEntity> get serializer =>
      _$eInvoiceFieldEntitySerializer;
}

abstract class EInvoiceElementEntity
    implements Built<EInvoiceElementEntity, EInvoiceElementEntityBuilder> {
  factory EInvoiceElementEntity() {
    return _$EInvoiceElementEntity._(
      baseType: '',
      help: '',
      maxLength: 0,
      name: '',
      resource: BuiltList<String>(),
    );
  }

  EInvoiceElementEntity._();

  @override
  @memoized
  int get hashCode;

  String get name;

  @BuiltValueField(wireName: 'base_type')
  String get baseType;

  BuiltList<String> get resource;

  @BuiltValueField(wireName: 'max_length')
  int get maxLength;

  String get help;

  static Serializer<EInvoiceElementEntity> get serializer =>
      _$eInvoiceElementEntitySerializer;
}
