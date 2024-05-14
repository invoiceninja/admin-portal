// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'e_invoice_model.g.dart';

abstract class EInvoiceFieldEntity
    implements Built<EInvoiceFieldEntity, EInvoiceFieldEntityBuilder> {
  factory EInvoiceFieldEntity() {
    return _$EInvoiceFieldEntity._(
      type: '',
      help: '',
      choices: BuiltList<String>(),
      elements: BuiltMap<String, EInvoiceElementEntity>(),
    );
  }
  EInvoiceFieldEntity._();

  @override
  @memoized
  int get hashCode;

  String get type;

  String get help;

  BuiltList<String> get choices;

  BuiltMap<String, EInvoiceElementEntity> get elements;

  static Serializer<EInvoiceFieldEntity> get serializer =>
      _$eInvoiceFieldEntitySerializer;
}

abstract class EInvoiceElementEntity
    implements Built<EInvoiceElementEntity, EInvoiceElementEntityBuilder> {
  factory EInvoiceElementEntity() {
    return _$EInvoiceElementEntity._(
      baseType: '',
      help: '',
      name: '',
      maxOccurs: 0,
      minOccurs: 0,
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

  @BuiltValueField(wireName: 'min_length')
  int? get minLength;

  @BuiltValueField(wireName: 'max_length')
  int? get maxLength;

  @BuiltValueField(wireName: 'min_occurs')
  int get minOccurs;

  @BuiltValueField(wireName: 'max_occurs')
  int get maxOccurs;

  String? get pattern;

  String? get help;

  static Serializer<EInvoiceElementEntity> get serializer =>
      _$eInvoiceElementEntitySerializer;
}
