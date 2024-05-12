// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e_invoice_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<EInvoiceFieldEntity> _$eInvoiceFieldEntitySerializer =
    new _$EInvoiceFieldEntitySerializer();
Serializer<EInvoiceElementEntity> _$eInvoiceElementEntitySerializer =
    new _$EInvoiceElementEntitySerializer();

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
    ];

    return result;
  }

  @override
  EInvoiceFieldEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EInvoiceFieldEntityBuilder();

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
      'max_length',
      serializers.serialize(object.maxLength,
          specifiedType: const FullType(int)),
      'help',
      serializers.serialize(object.help, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  EInvoiceElementEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EInvoiceElementEntityBuilder();

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
        case 'max_length':
          result.maxLength = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'help':
          result.help = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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

  factory _$EInvoiceFieldEntity(
          [void Function(EInvoiceFieldEntityBuilder)? updates]) =>
      (new EInvoiceFieldEntityBuilder()..update(updates))._build();

  _$EInvoiceFieldEntity._(
      {required this.type, required this.help, required this.choices})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(type, r'EInvoiceFieldEntity', 'type');
    BuiltValueNullFieldError.checkNotNull(help, r'EInvoiceFieldEntity', 'help');
    BuiltValueNullFieldError.checkNotNull(
        choices, r'EInvoiceFieldEntity', 'choices');
  }

  @override
  EInvoiceFieldEntity rebuild(
          void Function(EInvoiceFieldEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EInvoiceFieldEntityBuilder toBuilder() =>
      new EInvoiceFieldEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoiceFieldEntity &&
        type == other.type &&
        help == other.help &&
        choices == other.choices;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, help.hashCode);
    _$hash = $jc(_$hash, choices.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EInvoiceFieldEntity')
          ..add('type', type)
          ..add('help', help)
          ..add('choices', choices))
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
  ListBuilder<String> get choices =>
      _$this._choices ??= new ListBuilder<String>();
  set choices(ListBuilder<String>? choices) => _$this._choices = choices;

  EInvoiceFieldEntityBuilder();

  EInvoiceFieldEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _help = $v.help;
      _choices = $v.choices.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoiceFieldEntity other) {
    ArgumentError.checkNotNull(other, 'other');
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
          new _$EInvoiceFieldEntity._(
              type: BuiltValueNullFieldError.checkNotNull(
                  type, r'EInvoiceFieldEntity', 'type'),
              help: BuiltValueNullFieldError.checkNotNull(
                  help, r'EInvoiceFieldEntity', 'help'),
              choices: choices.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'choices';
        choices.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
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
  final int maxLength;
  @override
  final String help;

  factory _$EInvoiceElementEntity(
          [void Function(EInvoiceElementEntityBuilder)? updates]) =>
      (new EInvoiceElementEntityBuilder()..update(updates))._build();

  _$EInvoiceElementEntity._(
      {required this.name,
      required this.baseType,
      required this.resource,
      required this.maxLength,
      required this.help})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        name, r'EInvoiceElementEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(
        baseType, r'EInvoiceElementEntity', 'baseType');
    BuiltValueNullFieldError.checkNotNull(
        resource, r'EInvoiceElementEntity', 'resource');
    BuiltValueNullFieldError.checkNotNull(
        maxLength, r'EInvoiceElementEntity', 'maxLength');
    BuiltValueNullFieldError.checkNotNull(
        help, r'EInvoiceElementEntity', 'help');
  }

  @override
  EInvoiceElementEntity rebuild(
          void Function(EInvoiceElementEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EInvoiceElementEntityBuilder toBuilder() =>
      new EInvoiceElementEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoiceElementEntity &&
        name == other.name &&
        baseType == other.baseType &&
        resource == other.resource &&
        maxLength == other.maxLength &&
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
    _$hash = $jc(_$hash, maxLength.hashCode);
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
          ..add('maxLength', maxLength)
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
      _$this._resource ??= new ListBuilder<String>();
  set resource(ListBuilder<String>? resource) => _$this._resource = resource;

  int? _maxLength;
  int? get maxLength => _$this._maxLength;
  set maxLength(int? maxLength) => _$this._maxLength = maxLength;

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
      _maxLength = $v.maxLength;
      _help = $v.help;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoiceElementEntity other) {
    ArgumentError.checkNotNull(other, 'other');
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
          new _$EInvoiceElementEntity._(
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'EInvoiceElementEntity', 'name'),
              baseType: BuiltValueNullFieldError.checkNotNull(
                  baseType, r'EInvoiceElementEntity', 'baseType'),
              resource: resource.build(),
              maxLength: BuiltValueNullFieldError.checkNotNull(
                  maxLength, r'EInvoiceElementEntity', 'maxLength'),
              help: BuiltValueNullFieldError.checkNotNull(
                  help, r'EInvoiceElementEntity', 'help'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'resource';
        resource.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'EInvoiceElementEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
