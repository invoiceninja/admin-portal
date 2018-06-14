// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timezone_model.dart';

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

Serializer<TimezoneListResponse> _$timezoneListResponseSerializer =
    new _$TimezoneListResponseSerializer();
Serializer<TimezoneItemResponse> _$timezoneItemResponseSerializer =
    new _$TimezoneItemResponseSerializer();
Serializer<Timezone> _$timezoneSerializer = new _$TimezoneSerializer();

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
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Timezone)])),
    ];

    return result;
  }

  @override
  TimezoneListResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
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
                  BuiltList, const [const FullType(Timezone)])) as BuiltList);
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
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(Timezone)),
    ];

    return result;
  }

  @override
  TimezoneItemResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new TimezoneItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(Timezone)) as Timezone);
          break;
      }
    }

    return result.build();
  }
}

class _$TimezoneSerializer implements StructuredSerializer<Timezone> {
  @override
  final Iterable<Type> types = const [Timezone, _$Timezone];
  @override
  final String wireName = 'Timezone';

  @override
  Iterable serialize(Serializers serializers, Timezone object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.location != null) {
      result
        ..add('location')
        ..add(serializers.serialize(object.location,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Timezone deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new TimezoneBuilder();

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
      }
    }

    return result.build();
  }
}

class _$TimezoneListResponse extends TimezoneListResponse {
  @override
  final BuiltList<Timezone> data;

  factory _$TimezoneListResponse(
          [void updates(TimezoneListResponseBuilder b)]) =>
      (new TimezoneListResponseBuilder()..update(updates)).build();

  _$TimezoneListResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('TimezoneListResponse', 'data');
  }

  @override
  TimezoneListResponse rebuild(void updates(TimezoneListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TimezoneListResponseBuilder toBuilder() =>
      new TimezoneListResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! TimezoneListResponse) return false;
    return data == other.data;
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

  ListBuilder<Timezone> _data;
  ListBuilder<Timezone> get data =>
      _$this._data ??= new ListBuilder<Timezone>();
  set data(ListBuilder<Timezone> data) => _$this._data = data;

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
    if (other == null) throw new ArgumentError.notNull('other');
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
  final Timezone data;

  factory _$TimezoneItemResponse(
          [void updates(TimezoneItemResponseBuilder b)]) =>
      (new TimezoneItemResponseBuilder()..update(updates)).build();

  _$TimezoneItemResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('TimezoneItemResponse', 'data');
  }

  @override
  TimezoneItemResponse rebuild(void updates(TimezoneItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TimezoneItemResponseBuilder toBuilder() =>
      new TimezoneItemResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! TimezoneItemResponse) return false;
    return data == other.data;
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

  TimezoneBuilder _data;
  TimezoneBuilder get data => _$this._data ??= new TimezoneBuilder();
  set data(TimezoneBuilder data) => _$this._data = data;

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
    if (other == null) throw new ArgumentError.notNull('other');
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

class _$Timezone extends Timezone {
  @override
  final String name;
  @override
  final String location;

  factory _$Timezone([void updates(TimezoneBuilder b)]) =>
      (new TimezoneBuilder()..update(updates)).build();

  _$Timezone._({this.name, this.location}) : super._();

  @override
  Timezone rebuild(void updates(TimezoneBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TimezoneBuilder toBuilder() => new TimezoneBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Timezone) return false;
    return name == other.name && location == other.location;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, name.hashCode), location.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Timezone')
          ..add('name', name)
          ..add('location', location))
        .toString();
  }
}

class TimezoneBuilder implements Builder<Timezone, TimezoneBuilder> {
  _$Timezone _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _location;
  String get location => _$this._location;
  set location(String location) => _$this._location = location;

  TimezoneBuilder();

  TimezoneBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _location = _$v.location;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Timezone other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Timezone;
  }

  @override
  void update(void updates(TimezoneBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Timezone build() {
    final _$result = _$v ?? new _$Timezone._(name: name, location: location);
    replace(_$result);
    return _$result;
  }
}
