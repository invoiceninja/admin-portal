// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LanguageListResponse> _$languageListResponseSerializer =
    new _$LanguageListResponseSerializer();
Serializer<LanguageItemResponse> _$languageItemResponseSerializer =
    new _$LanguageItemResponseSerializer();
Serializer<LanguageEntity> _$languageEntitySerializer =
    new _$LanguageEntitySerializer();

class _$LanguageListResponseSerializer
    implements StructuredSerializer<LanguageListResponse> {
  @override
  final Iterable<Type> types = const [
    LanguageListResponse,
    _$LanguageListResponse
  ];
  @override
  final String wireName = 'LanguageListResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, LanguageListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(LanguageEntity)])),
    ];

    return result;
  }

  @override
  LanguageListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LanguageListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(LanguageEntity)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$LanguageItemResponseSerializer
    implements StructuredSerializer<LanguageItemResponse> {
  @override
  final Iterable<Type> types = const [
    LanguageItemResponse,
    _$LanguageItemResponse
  ];
  @override
  final String wireName = 'LanguageItemResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, LanguageItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(LanguageEntity)),
    ];

    return result;
  }

  @override
  LanguageItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LanguageItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(LanguageEntity))!
              as LanguageEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$LanguageEntitySerializer
    implements StructuredSerializer<LanguageEntity> {
  @override
  final Iterable<Type> types = const [LanguageEntity, _$LanguageEntity];
  @override
  final String wireName = 'LanguageEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, LanguageEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'locale',
      serializers.serialize(object.locale,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  LanguageEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LanguageEntityBuilder();

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
        case 'locale':
          result.locale = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$LanguageListResponse extends LanguageListResponse {
  @override
  final BuiltList<LanguageEntity> data;

  factory _$LanguageListResponse(
          [void Function(LanguageListResponseBuilder)? updates]) =>
      (new LanguageListResponseBuilder()..update(updates))._build();

  _$LanguageListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'LanguageListResponse', 'data');
  }

  @override
  LanguageListResponse rebuild(
          void Function(LanguageListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LanguageListResponseBuilder toBuilder() =>
      new LanguageListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LanguageListResponse && data == other.data;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LanguageListResponse')
          ..add('data', data))
        .toString();
  }
}

class LanguageListResponseBuilder
    implements Builder<LanguageListResponse, LanguageListResponseBuilder> {
  _$LanguageListResponse? _$v;

  ListBuilder<LanguageEntity>? _data;
  ListBuilder<LanguageEntity> get data =>
      _$this._data ??= new ListBuilder<LanguageEntity>();
  set data(ListBuilder<LanguageEntity>? data) => _$this._data = data;

  LanguageListResponseBuilder();

  LanguageListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LanguageListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LanguageListResponse;
  }

  @override
  void update(void Function(LanguageListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LanguageListResponse build() => _build();

  _$LanguageListResponse _build() {
    _$LanguageListResponse _$result;
    try {
      _$result = _$v ?? new _$LanguageListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'LanguageListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$LanguageItemResponse extends LanguageItemResponse {
  @override
  final LanguageEntity data;

  factory _$LanguageItemResponse(
          [void Function(LanguageItemResponseBuilder)? updates]) =>
      (new LanguageItemResponseBuilder()..update(updates))._build();

  _$LanguageItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'LanguageItemResponse', 'data');
  }

  @override
  LanguageItemResponse rebuild(
          void Function(LanguageItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LanguageItemResponseBuilder toBuilder() =>
      new LanguageItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LanguageItemResponse && data == other.data;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LanguageItemResponse')
          ..add('data', data))
        .toString();
  }
}

class LanguageItemResponseBuilder
    implements Builder<LanguageItemResponse, LanguageItemResponseBuilder> {
  _$LanguageItemResponse? _$v;

  LanguageEntityBuilder? _data;
  LanguageEntityBuilder get data =>
      _$this._data ??= new LanguageEntityBuilder();
  set data(LanguageEntityBuilder? data) => _$this._data = data;

  LanguageItemResponseBuilder();

  LanguageItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LanguageItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LanguageItemResponse;
  }

  @override
  void update(void Function(LanguageItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LanguageItemResponse build() => _build();

  _$LanguageItemResponse _build() {
    _$LanguageItemResponse _$result;
    try {
      _$result = _$v ?? new _$LanguageItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'LanguageItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$LanguageEntity extends LanguageEntity {
  @override
  final String name;
  @override
  final String locale;
  @override
  final String id;

  factory _$LanguageEntity([void Function(LanguageEntityBuilder)? updates]) =>
      (new LanguageEntityBuilder()..update(updates))._build();

  _$LanguageEntity._(
      {required this.name, required this.locale, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'LanguageEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(locale, r'LanguageEntity', 'locale');
    BuiltValueNullFieldError.checkNotNull(id, r'LanguageEntity', 'id');
  }

  @override
  LanguageEntity rebuild(void Function(LanguageEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LanguageEntityBuilder toBuilder() =>
      new LanguageEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LanguageEntity &&
        name == other.name &&
        locale == other.locale &&
        id == other.id;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, locale.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LanguageEntity')
          ..add('name', name)
          ..add('locale', locale)
          ..add('id', id))
        .toString();
  }
}

class LanguageEntityBuilder
    implements Builder<LanguageEntity, LanguageEntityBuilder> {
  _$LanguageEntity? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _locale;
  String? get locale => _$this._locale;
  set locale(String? locale) => _$this._locale = locale;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  LanguageEntityBuilder();

  LanguageEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _locale = $v.locale;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LanguageEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LanguageEntity;
  }

  @override
  void update(void Function(LanguageEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LanguageEntity build() => _build();

  _$LanguageEntity _build() {
    final _$result = _$v ??
        new _$LanguageEntity._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'LanguageEntity', 'name'),
            locale: BuiltValueNullFieldError.checkNotNull(
                locale, r'LanguageEntity', 'locale'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'LanguageEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
