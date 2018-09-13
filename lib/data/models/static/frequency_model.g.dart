// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frequency_model.dart';

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

Serializer<FrequencyListResponse> _$frequencyListResponseSerializer =
    new _$FrequencyListResponseSerializer();
Serializer<FrequencyItemResponse> _$frequencyItemResponseSerializer =
    new _$FrequencyItemResponseSerializer();
Serializer<FrequencyEntity> _$frequencyEntitySerializer =
    new _$FrequencyEntitySerializer();

class _$FrequencyListResponseSerializer
    implements StructuredSerializer<FrequencyListResponse> {
  @override
  final Iterable<Type> types = const [
    FrequencyListResponse,
    _$FrequencyListResponse
  ];
  @override
  final String wireName = 'FrequencyListResponse';

  @override
  Iterable serialize(Serializers serializers, FrequencyListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(FrequencyEntity)])),
    ];

    return result;
  }

  @override
  FrequencyListResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FrequencyListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(FrequencyEntity)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$FrequencyItemResponseSerializer
    implements StructuredSerializer<FrequencyItemResponse> {
  @override
  final Iterable<Type> types = const [
    FrequencyItemResponse,
    _$FrequencyItemResponse
  ];
  @override
  final String wireName = 'FrequencyItemResponse';

  @override
  Iterable serialize(Serializers serializers, FrequencyItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(FrequencyEntity)),
    ];

    return result;
  }

  @override
  FrequencyItemResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FrequencyItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(FrequencyEntity))
              as FrequencyEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$FrequencyEntitySerializer
    implements StructuredSerializer<FrequencyEntity> {
  @override
  final Iterable<Type> types = const [FrequencyEntity, _$FrequencyEntity];
  @override
  final String wireName = 'FrequencyEntity';

  @override
  Iterable serialize(Serializers serializers, FrequencyEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'date_interval',
      serializers.serialize(object.dateInterval,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  FrequencyEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FrequencyEntityBuilder();

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
        case 'date_interval':
          result.dateInterval = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$FrequencyListResponse extends FrequencyListResponse {
  @override
  final BuiltList<FrequencyEntity> data;

  factory _$FrequencyListResponse(
          [void updates(FrequencyListResponseBuilder b)]) =>
      (new FrequencyListResponseBuilder()..update(updates)).build();

  _$FrequencyListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('FrequencyListResponse', 'data');
    }
  }

  @override
  FrequencyListResponse rebuild(void updates(FrequencyListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  FrequencyListResponseBuilder toBuilder() =>
      new FrequencyListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FrequencyListResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FrequencyListResponse')
          ..add('data', data))
        .toString();
  }
}

class FrequencyListResponseBuilder
    implements Builder<FrequencyListResponse, FrequencyListResponseBuilder> {
  _$FrequencyListResponse _$v;

  ListBuilder<FrequencyEntity> _data;
  ListBuilder<FrequencyEntity> get data =>
      _$this._data ??= new ListBuilder<FrequencyEntity>();
  set data(ListBuilder<FrequencyEntity> data) => _$this._data = data;

  FrequencyListResponseBuilder();

  FrequencyListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FrequencyListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FrequencyListResponse;
  }

  @override
  void update(void updates(FrequencyListResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$FrequencyListResponse build() {
    _$FrequencyListResponse _$result;
    try {
      _$result = _$v ?? new _$FrequencyListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'FrequencyListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$FrequencyItemResponse extends FrequencyItemResponse {
  @override
  final FrequencyEntity data;

  factory _$FrequencyItemResponse(
          [void updates(FrequencyItemResponseBuilder b)]) =>
      (new FrequencyItemResponseBuilder()..update(updates)).build();

  _$FrequencyItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('FrequencyItemResponse', 'data');
    }
  }

  @override
  FrequencyItemResponse rebuild(void updates(FrequencyItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  FrequencyItemResponseBuilder toBuilder() =>
      new FrequencyItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FrequencyItemResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FrequencyItemResponse')
          ..add('data', data))
        .toString();
  }
}

class FrequencyItemResponseBuilder
    implements Builder<FrequencyItemResponse, FrequencyItemResponseBuilder> {
  _$FrequencyItemResponse _$v;

  FrequencyEntityBuilder _data;
  FrequencyEntityBuilder get data =>
      _$this._data ??= new FrequencyEntityBuilder();
  set data(FrequencyEntityBuilder data) => _$this._data = data;

  FrequencyItemResponseBuilder();

  FrequencyItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FrequencyItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FrequencyItemResponse;
  }

  @override
  void update(void updates(FrequencyItemResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$FrequencyItemResponse build() {
    _$FrequencyItemResponse _$result;
    try {
      _$result = _$v ?? new _$FrequencyItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'FrequencyItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$FrequencyEntity extends FrequencyEntity {
  @override
  final int id;
  @override
  final String name;
  @override
  final String dateInterval;

  factory _$FrequencyEntity([void updates(FrequencyEntityBuilder b)]) =>
      (new FrequencyEntityBuilder()..update(updates)).build();

  _$FrequencyEntity._({this.id, this.name, this.dateInterval}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('FrequencyEntity', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('FrequencyEntity', 'name');
    }
    if (dateInterval == null) {
      throw new BuiltValueNullFieldError('FrequencyEntity', 'dateInterval');
    }
  }

  @override
  FrequencyEntity rebuild(void updates(FrequencyEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  FrequencyEntityBuilder toBuilder() =>
      new FrequencyEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FrequencyEntity &&
        id == other.id &&
        name == other.name &&
        dateInterval == other.dateInterval;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, id.hashCode), name.hashCode), dateInterval.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FrequencyEntity')
          ..add('id', id)
          ..add('name', name)
          ..add('dateInterval', dateInterval))
        .toString();
  }
}

class FrequencyEntityBuilder
    implements Builder<FrequencyEntity, FrequencyEntityBuilder> {
  _$FrequencyEntity _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _dateInterval;
  String get dateInterval => _$this._dateInterval;
  set dateInterval(String dateInterval) => _$this._dateInterval = dateInterval;

  FrequencyEntityBuilder();

  FrequencyEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _dateInterval = _$v.dateInterval;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FrequencyEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FrequencyEntity;
  }

  @override
  void update(void updates(FrequencyEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$FrequencyEntity build() {
    final _$result = _$v ??
        new _$FrequencyEntity._(id: id, name: name, dateInterval: dateInterval);
    replace(_$result);
    return _$result;
  }
}
