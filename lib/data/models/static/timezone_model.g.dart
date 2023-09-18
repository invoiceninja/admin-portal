// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timezone_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TimezoneListResponse> _$timezoneListResponseSerializer =
    new _$TimezoneListResponseSerializer();
Serializer<TimezoneItemResponse> _$timezoneItemResponseSerializer =
    new _$TimezoneItemResponseSerializer();
Serializer<TimezoneEntity> _$timezoneEntitySerializer =
    new _$TimezoneEntitySerializer();

class _$TimezoneListResponseSerializer
    implements StructuredSerializer<TimezoneListResponse> {
  @override
  final Iterable<Type> types = const [
    TimezoneListResponse,
    _$TimezoneListResponse
  ];
  @override
  final String wireName = 'TimezoneListResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, TimezoneListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(TimezoneEntity)])),
    ];

    return result;
  }

  @override
  TimezoneListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TimezoneListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TimezoneEntity)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$TimezoneItemResponseSerializer
    implements StructuredSerializer<TimezoneItemResponse> {
  @override
  final Iterable<Type> types = const [
    TimezoneItemResponse,
    _$TimezoneItemResponse
  ];
  @override
  final String wireName = 'TimezoneItemResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, TimezoneItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(TimezoneEntity)),
    ];

    return result;
  }

  @override
  TimezoneItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TimezoneItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(TimezoneEntity))!
              as TimezoneEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$TimezoneEntitySerializer
    implements StructuredSerializer<TimezoneEntity> {
  @override
  final Iterable<Type> types = const [TimezoneEntity, _$TimezoneEntity];
  @override
  final String wireName = 'TimezoneEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, TimezoneEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'location',
      serializers.serialize(object.location,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  TimezoneEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TimezoneEntityBuilder();

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
        case 'location':
          result.location = serializers.deserialize(value,
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

class _$TimezoneListResponse extends TimezoneListResponse {
  @override
  final BuiltList<TimezoneEntity> data;

  factory _$TimezoneListResponse(
          [void Function(TimezoneListResponseBuilder)? updates]) =>
      (new TimezoneListResponseBuilder()..update(updates))._build();

  _$TimezoneListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'TimezoneListResponse', 'data');
  }

  @override
  TimezoneListResponse rebuild(
          void Function(TimezoneListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TimezoneListResponseBuilder toBuilder() =>
      new TimezoneListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TimezoneListResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'TimezoneListResponse')
          ..add('data', data))
        .toString();
  }
}

class TimezoneListResponseBuilder
    implements Builder<TimezoneListResponse, TimezoneListResponseBuilder> {
  _$TimezoneListResponse? _$v;

  ListBuilder<TimezoneEntity>? _data;
  ListBuilder<TimezoneEntity> get data =>
      _$this._data ??= new ListBuilder<TimezoneEntity>();
  set data(ListBuilder<TimezoneEntity>? data) => _$this._data = data;

  TimezoneListResponseBuilder();

  TimezoneListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TimezoneListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TimezoneListResponse;
  }

  @override
  void update(void Function(TimezoneListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TimezoneListResponse build() => _build();

  _$TimezoneListResponse _build() {
    _$TimezoneListResponse _$result;
    try {
      _$result = _$v ?? new _$TimezoneListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TimezoneListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TimezoneItemResponse extends TimezoneItemResponse {
  @override
  final TimezoneEntity data;

  factory _$TimezoneItemResponse(
          [void Function(TimezoneItemResponseBuilder)? updates]) =>
      (new TimezoneItemResponseBuilder()..update(updates))._build();

  _$TimezoneItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'TimezoneItemResponse', 'data');
  }

  @override
  TimezoneItemResponse rebuild(
          void Function(TimezoneItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TimezoneItemResponseBuilder toBuilder() =>
      new TimezoneItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TimezoneItemResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'TimezoneItemResponse')
          ..add('data', data))
        .toString();
  }
}

class TimezoneItemResponseBuilder
    implements Builder<TimezoneItemResponse, TimezoneItemResponseBuilder> {
  _$TimezoneItemResponse? _$v;

  TimezoneEntityBuilder? _data;
  TimezoneEntityBuilder get data =>
      _$this._data ??= new TimezoneEntityBuilder();
  set data(TimezoneEntityBuilder? data) => _$this._data = data;

  TimezoneItemResponseBuilder();

  TimezoneItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TimezoneItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TimezoneItemResponse;
  }

  @override
  void update(void Function(TimezoneItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TimezoneItemResponse build() => _build();

  _$TimezoneItemResponse _build() {
    _$TimezoneItemResponse _$result;
    try {
      _$result = _$v ?? new _$TimezoneItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TimezoneItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TimezoneEntity extends TimezoneEntity {
  @override
  final String name;
  @override
  final String location;
  @override
  final String id;

  factory _$TimezoneEntity([void Function(TimezoneEntityBuilder)? updates]) =>
      (new TimezoneEntityBuilder()..update(updates))._build();

  _$TimezoneEntity._(
      {required this.name, required this.location, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'TimezoneEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(
        location, r'TimezoneEntity', 'location');
    BuiltValueNullFieldError.checkNotNull(id, r'TimezoneEntity', 'id');
  }

  @override
  TimezoneEntity rebuild(void Function(TimezoneEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TimezoneEntityBuilder toBuilder() =>
      new TimezoneEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TimezoneEntity &&
        name == other.name &&
        location == other.location &&
        id == other.id;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TimezoneEntity')
          ..add('name', name)
          ..add('location', location)
          ..add('id', id))
        .toString();
  }
}

class TimezoneEntityBuilder
    implements Builder<TimezoneEntity, TimezoneEntityBuilder> {
  _$TimezoneEntity? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  TimezoneEntityBuilder();

  TimezoneEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _location = $v.location;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TimezoneEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TimezoneEntity;
  }

  @override
  void update(void Function(TimezoneEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TimezoneEntity build() => _build();

  _$TimezoneEntity _build() {
    final _$result = _$v ??
        new _$TimezoneEntity._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'TimezoneEntity', 'name'),
            location: BuiltValueNullFieldError.checkNotNull(
                location, r'TimezoneEntity', 'location'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'TimezoneEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
