// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SizeListResponse> _$sizeListResponseSerializer =
    new _$SizeListResponseSerializer();
Serializer<SizeItemResponse> _$sizeItemResponseSerializer =
    new _$SizeItemResponseSerializer();
Serializer<SizeEntity> _$sizeEntitySerializer = new _$SizeEntitySerializer();

class _$SizeListResponseSerializer
    implements StructuredSerializer<SizeListResponse> {
  @override
  final Iterable<Type> types = const [SizeListResponse, _$SizeListResponse];
  @override
  final String wireName = 'SizeListResponse';

  @override
  Iterable<Object?> serialize(Serializers serializers, SizeListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(SizeEntity)])),
    ];

    return result;
  }

  @override
  SizeListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SizeListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SizeEntity)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$SizeItemResponseSerializer
    implements StructuredSerializer<SizeItemResponse> {
  @override
  final Iterable<Type> types = const [SizeItemResponse, _$SizeItemResponse];
  @override
  final String wireName = 'SizeItemResponse';

  @override
  Iterable<Object?> serialize(Serializers serializers, SizeItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(SizeEntity)),
    ];

    return result;
  }

  @override
  SizeItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SizeItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(SizeEntity))! as SizeEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$SizeEntitySerializer implements StructuredSerializer<SizeEntity> {
  @override
  final Iterable<Type> types = const [SizeEntity, _$SizeEntity];
  @override
  final String wireName = 'SizeEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, SizeEntity object,
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
  SizeEntity deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SizeEntityBuilder();

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

class _$SizeListResponse extends SizeListResponse {
  @override
  final BuiltList<SizeEntity> data;

  factory _$SizeListResponse(
          [void Function(SizeListResponseBuilder)? updates]) =>
      (new SizeListResponseBuilder()..update(updates))._build();

  _$SizeListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'SizeListResponse', 'data');
  }

  @override
  SizeListResponse rebuild(void Function(SizeListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SizeListResponseBuilder toBuilder() =>
      new SizeListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SizeListResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'SizeListResponse')..add('data', data))
        .toString();
  }
}

class SizeListResponseBuilder
    implements Builder<SizeListResponse, SizeListResponseBuilder> {
  _$SizeListResponse? _$v;

  ListBuilder<SizeEntity>? _data;
  ListBuilder<SizeEntity> get data =>
      _$this._data ??= new ListBuilder<SizeEntity>();
  set data(ListBuilder<SizeEntity>? data) => _$this._data = data;

  SizeListResponseBuilder();

  SizeListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SizeListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SizeListResponse;
  }

  @override
  void update(void Function(SizeListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SizeListResponse build() => _build();

  _$SizeListResponse _build() {
    _$SizeListResponse _$result;
    try {
      _$result = _$v ?? new _$SizeListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'SizeListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SizeItemResponse extends SizeItemResponse {
  @override
  final SizeEntity data;

  factory _$SizeItemResponse(
          [void Function(SizeItemResponseBuilder)? updates]) =>
      (new SizeItemResponseBuilder()..update(updates))._build();

  _$SizeItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'SizeItemResponse', 'data');
  }

  @override
  SizeItemResponse rebuild(void Function(SizeItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SizeItemResponseBuilder toBuilder() =>
      new SizeItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SizeItemResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'SizeItemResponse')..add('data', data))
        .toString();
  }
}

class SizeItemResponseBuilder
    implements Builder<SizeItemResponse, SizeItemResponseBuilder> {
  _$SizeItemResponse? _$v;

  SizeEntityBuilder? _data;
  SizeEntityBuilder get data => _$this._data ??= new SizeEntityBuilder();
  set data(SizeEntityBuilder? data) => _$this._data = data;

  SizeItemResponseBuilder();

  SizeItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SizeItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SizeItemResponse;
  }

  @override
  void update(void Function(SizeItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SizeItemResponse build() => _build();

  _$SizeItemResponse _build() {
    _$SizeItemResponse _$result;
    try {
      _$result = _$v ?? new _$SizeItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'SizeItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SizeEntity extends SizeEntity {
  @override
  final String name;
  @override
  final String id;

  factory _$SizeEntity([void Function(SizeEntityBuilder)? updates]) =>
      (new SizeEntityBuilder()..update(updates))._build();

  _$SizeEntity._({required this.name, required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'SizeEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(id, r'SizeEntity', 'id');
  }

  @override
  SizeEntity rebuild(void Function(SizeEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SizeEntityBuilder toBuilder() => new SizeEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SizeEntity && name == other.name && id == other.id;
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
    return (newBuiltValueToStringHelper(r'SizeEntity')
          ..add('name', name)
          ..add('id', id))
        .toString();
  }
}

class SizeEntityBuilder implements Builder<SizeEntity, SizeEntityBuilder> {
  _$SizeEntity? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  SizeEntityBuilder();

  SizeEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SizeEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SizeEntity;
  }

  @override
  void update(void Function(SizeEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SizeEntity build() => _build();

  _$SizeEntity _build() {
    final _$result = _$v ??
        new _$SizeEntity._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'SizeEntity', 'name'),
            id: BuiltValueNullFieldError.checkNotNull(id, r'SizeEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
