// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timezone_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

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
  Iterable serialize(Serializers serializers, TimezoneListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(TimezoneEntity)])),
    ];

    return result;
  }

  @override
  TimezoneListResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TimezoneListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TimezoneEntity)]))
              as BuiltList);
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
  Iterable serialize(Serializers serializers, TimezoneItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(TimezoneEntity)),
    ];

    return result;
  }

  @override
  TimezoneItemResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TimezoneItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(TimezoneEntity)) as TimezoneEntity);
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
  Iterable serialize(Serializers serializers, TimezoneEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'location',
      serializers.serialize(object.location,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  TimezoneEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TimezoneEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'location':
          result.location = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
          [void updates(TimezoneListResponseBuilder b)]) =>
      (new TimezoneListResponseBuilder()..update(updates)).build();

  _$TimezoneListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('TimezoneListResponse', 'data');
    }
  }

  @override
  TimezoneListResponse rebuild(void updates(TimezoneListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TimezoneListResponseBuilder toBuilder() =>
      new TimezoneListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TimezoneListResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TimezoneListResponse')
          ..add('data', data))
        .toString();
  }
}

class TimezoneListResponseBuilder
    implements Builder<TimezoneListResponse, TimezoneListResponseBuilder> {
  _$TimezoneListResponse _$v;

  ListBuilder<TimezoneEntity> _data;
  ListBuilder<TimezoneEntity> get data =>
      _$this._data ??= new ListBuilder<TimezoneEntity>();
  set data(ListBuilder<TimezoneEntity> data) => _$this._data = data;

  TimezoneListResponseBuilder();

  TimezoneListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TimezoneListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TimezoneListResponse;
  }

  @override
  void update(void updates(TimezoneListResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TimezoneListResponse build() {
    _$TimezoneListResponse _$result;
    try {
      _$result = _$v ?? new _$TimezoneListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TimezoneListResponse', _$failedField, e.toString());
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
          [void updates(TimezoneItemResponseBuilder b)]) =>
      (new TimezoneItemResponseBuilder()..update(updates)).build();

  _$TimezoneItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('TimezoneItemResponse', 'data');
    }
  }

  @override
  TimezoneItemResponse rebuild(void updates(TimezoneItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TimezoneItemResponseBuilder toBuilder() =>
      new TimezoneItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TimezoneItemResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TimezoneItemResponse')
          ..add('data', data))
        .toString();
  }
}

class TimezoneItemResponseBuilder
    implements Builder<TimezoneItemResponse, TimezoneItemResponseBuilder> {
  _$TimezoneItemResponse _$v;

  TimezoneEntityBuilder _data;
  TimezoneEntityBuilder get data =>
      _$this._data ??= new TimezoneEntityBuilder();
  set data(TimezoneEntityBuilder data) => _$this._data = data;

  TimezoneItemResponseBuilder();

  TimezoneItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TimezoneItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TimezoneItemResponse;
  }

  @override
  void update(void updates(TimezoneItemResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TimezoneItemResponse build() {
    _$TimezoneItemResponse _$result;
    try {
      _$result = _$v ?? new _$TimezoneItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TimezoneItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TimezoneEntity extends TimezoneEntity {
  @override
  final int id;
  @override
  final String name;
  @override
  final String location;

  factory _$TimezoneEntity([void updates(TimezoneEntityBuilder b)]) =>
      (new TimezoneEntityBuilder()..update(updates)).build();

  _$TimezoneEntity._({this.id, this.name, this.location}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('TimezoneEntity', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('TimezoneEntity', 'name');
    }
    if (location == null) {
      throw new BuiltValueNullFieldError('TimezoneEntity', 'location');
    }
  }

  @override
  TimezoneEntity rebuild(void updates(TimezoneEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TimezoneEntityBuilder toBuilder() =>
      new TimezoneEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TimezoneEntity &&
        id == other.id &&
        name == other.name &&
        location == other.location;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, id.hashCode), name.hashCode), location.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TimezoneEntity')
          ..add('id', id)
          ..add('name', name)
          ..add('location', location))
        .toString();
  }
}

class TimezoneEntityBuilder
    implements Builder<TimezoneEntity, TimezoneEntityBuilder> {
  _$TimezoneEntity _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _location;
  String get location => _$this._location;
  set location(String location) => _$this._location = location;

  TimezoneEntityBuilder();

  TimezoneEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _location = _$v.location;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TimezoneEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TimezoneEntity;
  }

  @override
  void update(void updates(TimezoneEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TimezoneEntity build() {
    final _$result =
        _$v ?? new _$TimezoneEntity._(id: id, name: name, location: location);
    replace(_$result);
    return _$result;
  }
}
