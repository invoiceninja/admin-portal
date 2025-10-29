// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e_invoice_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<EInvoiceFieldEntity> _$eInvoiceFieldEntitySerializer =
    _$EInvoiceFieldEntitySerializer();
Serializer<EInvoiceElementEntity> _$eInvoiceElementEntitySerializer =
    _$EInvoiceElementEntitySerializer();

class _$EInvoiceFieldEntitySerializer
    implements StructuredSerializer<EInvoiceFieldEntity> {
  @override
  final Iterable<Type> types = const [
    EInvoiceFieldEntity,
    _$EInvoiceFieldEntity
  ];
  @override
  final String wireName = 'EInvoiceFieldEntity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, EInvoiceFieldEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
      'help',
      serializers.serialize(object.help, specifiedType: const FullType(String)),
      'choices',
      serializers.serialize(object.choices,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'elements',
      serializers.serialize(object.elements,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(EInvoiceElementEntity)
          ])),
    ];

    return result;
  }

  @override
  EInvoiceFieldEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = EInvoiceFieldEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'help':
          result.help = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'choices':
          result.choices.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'elements':
          result.elements.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(EInvoiceElementEntity)
              ]))!);
          break;
      }
    }

    return result.build();
  }
}

class _$EInvoiceElementEntitySerializer
    implements StructuredSerializer<EInvoiceElementEntity> {
  @override
  final Iterable<Type> types = const [
    EInvoiceElementEntity,
    _$EInvoiceElementEntity
  ];
  @override
  final String wireName = 'EInvoiceElementEntity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, EInvoiceElementEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'base_type',
      serializers.serialize(object.baseType,
          specifiedType: const FullType(String)),
      'resource',
      serializers.serialize(object.resource,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'min_occurs',
      serializers.serialize(object.minOccurs,
          specifiedType: const FullType(int)),
      'max_occurs',
      serializers.serialize(object.maxOccurs,
          specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.minLength;
    if (value != null) {
      result
        ..add('min_length')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.maxLength;
    if (value != null) {
      result
        ..add('max_length')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.pattern;
    if (value != null) {
      result
        ..add('pattern')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.help;
    if (value != null) {
      result
        ..add('help')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  EInvoiceElementEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = EInvoiceElementEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'base_type':
          result.baseType = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'resource':
          result.resource.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'min_length':
          result.minLength = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'max_length':
          result.maxLength = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'min_occurs':
          result.minOccurs = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'max_occurs':
          result.maxOccurs = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'pattern':
          result.pattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'help':
          result.help = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$EInvoiceFieldEntity extends EInvoiceFieldEntity {
  @override
  final String type;
  @override
  final String help;
  @override
  final BuiltList<String> choices;
  @override
  final BuiltMap<String, EInvoiceElementEntity> elements;

  factory _$EInvoiceFieldEntity(
          [void Function(EInvoiceFieldEntityBuilder)? updates]) =>
      (EInvoiceFieldEntityBuilder()..update(updates))._build();

  _$EInvoiceFieldEntity._(
      {required this.type,
      required this.help,
      required this.choices,
      required this.elements})
      : super._();
  @override
  EInvoiceFieldEntity rebuild(
          void Function(EInvoiceFieldEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EInvoiceFieldEntityBuilder toBuilder() =>
      EInvoiceFieldEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoiceFieldEntity &&
        type == other.type &&
        help == other.help &&
        choices == other.choices &&
        elements == other.elements;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, help.hashCode);
    _$hash = $jc(_$hash, choices.hashCode);
    _$hash = $jc(_$hash, elements.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EInvoiceFieldEntity')
          ..add('type', type)
          ..add('help', help)
          ..add('choices', choices)
          ..add('elements', elements))
        .toString();
  }
}

class EInvoiceFieldEntityBuilder
    implements Builder<EInvoiceFieldEntity, EInvoiceFieldEntityBuilder> {
  _$EInvoiceFieldEntity? _$v;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _help;
  String? get help => _$this._help;
  set help(String? help) => _$this._help = help;

  ListBuilder<String>? _choices;
  ListBuilder<String> get choices => _$this._choices ??= ListBuilder<String>();
  set choices(ListBuilder<String>? choices) => _$this._choices = choices;

  MapBuilder<String, EInvoiceElementEntity>? _elements;
  MapBuilder<String, EInvoiceElementEntity> get elements =>
      _$this._elements ??= MapBuilder<String, EInvoiceElementEntity>();
  set elements(MapBuilder<String, EInvoiceElementEntity>? elements) =>
      _$this._elements = elements;

  EInvoiceFieldEntityBuilder();

  EInvoiceFieldEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _help = $v.help;
      _choices = $v.choices.toBuilder();
      _elements = $v.elements.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoiceFieldEntity other) {
    _$v = other as _$EInvoiceFieldEntity;
  }

  @override
  void update(void Function(EInvoiceFieldEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EInvoiceFieldEntity build() => _build();

  _$EInvoiceFieldEntity _build() {
    _$EInvoiceFieldEntity _$result;
    try {
      _$result = _$v ??
          _$EInvoiceFieldEntity._(
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'EInvoiceFieldEntity', 'type'),
            help: BuiltValueNullFieldError.checkNotNull(
                help, r'EInvoiceFieldEntity', 'help'),
            choices: choices.build(),
            elements: elements.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'choices';
        choices.build();
        _$failedField = 'elements';
        elements.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'EInvoiceFieldEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$EInvoiceElementEntity extends EInvoiceElementEntity {
  @override
  final String name;
  @override
  final String baseType;
  @override
  final BuiltList<String> resource;
  @override
  final int? minLength;
  @override
  final int? maxLength;
  @override
  final int minOccurs;
  @override
  final int maxOccurs;
  @override
  final String? pattern;
  @override
  final String? help;

  factory _$EInvoiceElementEntity(
          [void Function(EInvoiceElementEntityBuilder)? updates]) =>
      (EInvoiceElementEntityBuilder()..update(updates))._build();

  _$EInvoiceElementEntity._(
      {required this.name,
      required this.baseType,
      required this.resource,
      this.minLength,
      this.maxLength,
      required this.minOccurs,
      required this.maxOccurs,
      this.pattern,
      this.help})
      : super._();
  @override
  EInvoiceElementEntity rebuild(
          void Function(EInvoiceElementEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EInvoiceElementEntityBuilder toBuilder() =>
      EInvoiceElementEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoiceElementEntity &&
        name == other.name &&
        baseType == other.baseType &&
        resource == other.resource &&
        minLength == other.minLength &&
        maxLength == other.maxLength &&
        minOccurs == other.minOccurs &&
        maxOccurs == other.maxOccurs &&
        pattern == other.pattern &&
        help == other.help;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, baseType.hashCode);
    _$hash = $jc(_$hash, resource.hashCode);
    _$hash = $jc(_$hash, minLength.hashCode);
    _$hash = $jc(_$hash, maxLength.hashCode);
    _$hash = $jc(_$hash, minOccurs.hashCode);
    _$hash = $jc(_$hash, maxOccurs.hashCode);
    _$hash = $jc(_$hash, pattern.hashCode);
    _$hash = $jc(_$hash, help.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EInvoiceElementEntity')
          ..add('name', name)
          ..add('baseType', baseType)
          ..add('resource', resource)
          ..add('minLength', minLength)
          ..add('maxLength', maxLength)
          ..add('minOccurs', minOccurs)
          ..add('maxOccurs', maxOccurs)
          ..add('pattern', pattern)
          ..add('help', help))
        .toString();
  }
}

class EInvoiceElementEntityBuilder
    implements Builder<EInvoiceElementEntity, EInvoiceElementEntityBuilder> {
  _$EInvoiceElementEntity? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _baseType;
  String? get baseType => _$this._baseType;
  set baseType(String? baseType) => _$this._baseType = baseType;

  ListBuilder<String>? _resource;
  ListBuilder<String> get resource =>
      _$this._resource ??= ListBuilder<String>();
  set resource(ListBuilder<String>? resource) => _$this._resource = resource;

  int? _minLength;
  int? get minLength => _$this._minLength;
  set minLength(int? minLength) => _$this._minLength = minLength;

  int? _maxLength;
  int? get maxLength => _$this._maxLength;
  set maxLength(int? maxLength) => _$this._maxLength = maxLength;

  int? _minOccurs;
  int? get minOccurs => _$this._minOccurs;
  set minOccurs(int? minOccurs) => _$this._minOccurs = minOccurs;

  int? _maxOccurs;
  int? get maxOccurs => _$this._maxOccurs;
  set maxOccurs(int? maxOccurs) => _$this._maxOccurs = maxOccurs;

  String? _pattern;
  String? get pattern => _$this._pattern;
  set pattern(String? pattern) => _$this._pattern = pattern;

  String? _help;
  String? get help => _$this._help;
  set help(String? help) => _$this._help = help;

  EInvoiceElementEntityBuilder();

  EInvoiceElementEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _baseType = $v.baseType;
      _resource = $v.resource.toBuilder();
      _minLength = $v.minLength;
      _maxLength = $v.maxLength;
      _minOccurs = $v.minOccurs;
      _maxOccurs = $v.maxOccurs;
      _pattern = $v.pattern;
      _help = $v.help;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoiceElementEntity other) {
    _$v = other as _$EInvoiceElementEntity;
  }

  @override
  void update(void Function(EInvoiceElementEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EInvoiceElementEntity build() => _build();

  _$EInvoiceElementEntity _build() {
    _$EInvoiceElementEntity _$result;
    try {
      _$result = _$v ??
          _$EInvoiceElementEntity._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'EInvoiceElementEntity', 'name'),
            baseType: BuiltValueNullFieldError.checkNotNull(
                baseType, r'EInvoiceElementEntity', 'baseType'),
            resource: resource.build(),
            minLength: minLength,
            maxLength: maxLength,
            minOccurs: BuiltValueNullFieldError.checkNotNull(
                minOccurs, r'EInvoiceElementEntity', 'minOccurs'),
            maxOccurs: BuiltValueNullFieldError.checkNotNull(
                maxOccurs, r'EInvoiceElementEntity', 'maxOccurs'),
            pattern: pattern,
            help: help,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'resource';
        resource.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'EInvoiceElementEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
