// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'industry_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<IndustryListResponse> _$industryListResponseSerializer =
    new _$IndustryListResponseSerializer();
Serializer<IndustryItemResponse> _$industryItemResponseSerializer =
    new _$IndustryItemResponseSerializer();
Serializer<IndustryEntity> _$industryEntitySerializer =
    new _$IndustryEntitySerializer();

class _$IndustryListResponseSerializer
    implements StructuredSerializer<IndustryListResponse> {
  @override
  final Iterable<Type> types = const [
    IndustryListResponse,
    _$IndustryListResponse
  ];
  @override
  final String wireName = 'IndustryListResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, IndustryListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(IndustryEntity)])),
    ];

    return result;
  }

  @override
  IndustryListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new IndustryListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(IndustryEntity)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$IndustryItemResponseSerializer
    implements StructuredSerializer<IndustryItemResponse> {
  @override
  final Iterable<Type> types = const [
    IndustryItemResponse,
    _$IndustryItemResponse
  ];
  @override
  final String wireName = 'IndustryItemResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, IndustryItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(IndustryEntity)),
    ];

    return result;
  }

  @override
  IndustryItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new IndustryItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(IndustryEntity))!
              as IndustryEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$IndustryEntitySerializer
    implements StructuredSerializer<IndustryEntity> {
  @override
  final Iterable<Type> types = const [IndustryEntity, _$IndustryEntity];
  @override
  final String wireName = 'IndustryEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, IndustryEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  IndustryEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new IndustryEntityBuilder();

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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$IndustryListResponse extends IndustryListResponse {
  @override
  final BuiltList<IndustryEntity> data;

  factory _$IndustryListResponse(
          [void Function(IndustryListResponseBuilder)? updates]) =>
      (new IndustryListResponseBuilder()..update(updates))._build();

  _$IndustryListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'IndustryListResponse', 'data');
  }

  @override
  IndustryListResponse rebuild(
          void Function(IndustryListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IndustryListResponseBuilder toBuilder() =>
      new IndustryListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IndustryListResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'IndustryListResponse')
          ..add('data', data))
        .toString();
  }
}

class IndustryListResponseBuilder
    implements Builder<IndustryListResponse, IndustryListResponseBuilder> {
  _$IndustryListResponse? _$v;

  ListBuilder<IndustryEntity>? _data;
  ListBuilder<IndustryEntity> get data =>
      _$this._data ??= new ListBuilder<IndustryEntity>();
  set data(ListBuilder<IndustryEntity>? data) => _$this._data = data;

  IndustryListResponseBuilder();

  IndustryListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IndustryListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$IndustryListResponse;
  }

  @override
  void update(void Function(IndustryListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IndustryListResponse build() => _build();

  _$IndustryListResponse _build() {
    _$IndustryListResponse _$result;
    try {
      _$result = _$v ?? new _$IndustryListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'IndustryListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$IndustryItemResponse extends IndustryItemResponse {
  @override
  final IndustryEntity data;

  factory _$IndustryItemResponse(
          [void Function(IndustryItemResponseBuilder)? updates]) =>
      (new IndustryItemResponseBuilder()..update(updates))._build();

  _$IndustryItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'IndustryItemResponse', 'data');
  }

  @override
  IndustryItemResponse rebuild(
          void Function(IndustryItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IndustryItemResponseBuilder toBuilder() =>
      new IndustryItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IndustryItemResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'IndustryItemResponse')
          ..add('data', data))
        .toString();
  }
}

class IndustryItemResponseBuilder
    implements Builder<IndustryItemResponse, IndustryItemResponseBuilder> {
  _$IndustryItemResponse? _$v;

  IndustryEntityBuilder? _data;
  IndustryEntityBuilder get data =>
      _$this._data ??= new IndustryEntityBuilder();
  set data(IndustryEntityBuilder? data) => _$this._data = data;

  IndustryItemResponseBuilder();

  IndustryItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IndustryItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$IndustryItemResponse;
  }

  @override
  void update(void Function(IndustryItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IndustryItemResponse build() => _build();

  _$IndustryItemResponse _build() {
    _$IndustryItemResponse _$result;
    try {
      _$result = _$v ?? new _$IndustryItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'IndustryItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$IndustryEntity extends IndustryEntity {
  @override
  final String name;
  @override
  final String id;

  factory _$IndustryEntity([void Function(IndustryEntityBuilder)? updates]) =>
      (new IndustryEntityBuilder()..update(updates))._build();

  _$IndustryEntity._({required this.name, required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'IndustryEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(id, r'IndustryEntity', 'id');
  }

  @override
  IndustryEntity rebuild(void Function(IndustryEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IndustryEntityBuilder toBuilder() =>
      new IndustryEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IndustryEntity && name == other.name && id == other.id;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'IndustryEntity')
          ..add('name', name)
          ..add('id', id))
        .toString();
  }
}

class IndustryEntityBuilder
    implements Builder<IndustryEntity, IndustryEntityBuilder> {
  _$IndustryEntity? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  IndustryEntityBuilder();

  IndustryEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IndustryEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$IndustryEntity;
  }

  @override
  void update(void Function(IndustryEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IndustryEntity build() => _build();

  _$IndustryEntity _build() {
    final _$result = _$v ??
        new _$IndustryEntity._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'IndustryEntity', 'name'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'IndustryEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
