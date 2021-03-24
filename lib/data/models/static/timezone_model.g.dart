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
  Iterable<Object> serialize(
      Serializers serializers, TimezoneListResponse object,
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
  TimezoneListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
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
              as BuiltList<Object>);
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
  Iterable<Object> serialize(
      Serializers serializers, TimezoneItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(TimezoneEntity)),
    ];

    return result;
  }

  @override
  TimezoneItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
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
  Iterable<Object> serialize(Serializers serializers, TimezoneEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
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
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TimezoneEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'location':
          result.location = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
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
          [void Function(TimezoneListResponseBuilder) updates]) =>
      (new TimezoneListResponseBuilder()..update(updates)).build();

  _$TimezoneListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('TimezoneListResponse', 'data');
    }
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
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
  void update(void Function(TimezoneListResponseBuilder) updates) {
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
          [void Function(TimezoneItemResponseBuilder) updates]) =>
      (new TimezoneItemResponseBuilder()..update(updates)).build();

  _$TimezoneItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('TimezoneItemResponse', 'data');
    }
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
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
  void update(void Function(TimezoneItemResponseBuilder) updates) {
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
  final String name;
  @override
  final String location;
  @override
  final String id;

  factory _$TimezoneEntity([void Function(TimezoneEntityBuilder) updates]) =>
      (new TimezoneEntityBuilder()..update(updates)).build();

  _$TimezoneEntity._({this.name, this.location, this.id}) : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('TimezoneEntity', 'name');
    }
    if (location == null) {
      throw new BuiltValueNullFieldError('TimezoneEntity', 'location');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('TimezoneEntity', 'id');
    }
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??=
        $jf($jc($jc($jc(0, name.hashCode), location.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TimezoneEntity')
          ..add('name', name)
          ..add('location', location)
          ..add('id', id))
        .toString();
  }
}

class TimezoneEntityBuilder
    implements Builder<TimezoneEntity, TimezoneEntityBuilder> {
  _$TimezoneEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _location;
  String get location => _$this._location;
  set location(String location) => _$this._location = location;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  TimezoneEntityBuilder();

  TimezoneEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _location = _$v.location;
      _id = _$v.id;
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
  void update(void Function(TimezoneEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TimezoneEntity build() {
    final _$result =
        _$v ?? new _$TimezoneEntity._(name: name, location: location, id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
