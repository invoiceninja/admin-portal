// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datetime_format_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DatetimeFormatListResponse> _$datetimeFormatListResponseSerializer =
    new _$DatetimeFormatListResponseSerializer();
Serializer<DatetimeFormatItemResponse> _$datetimeFormatItemResponseSerializer =
    new _$DatetimeFormatItemResponseSerializer();
Serializer<DatetimeFormatEntity> _$datetimeFormatEntitySerializer =
    new _$DatetimeFormatEntitySerializer();

class _$DatetimeFormatListResponseSerializer
    implements StructuredSerializer<DatetimeFormatListResponse> {
  @override
  final Iterable<Type> types = const [
    DatetimeFormatListResponse,
    _$DatetimeFormatListResponse
  ];
  @override
  final String wireName = 'DatetimeFormatListResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, DatetimeFormatListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DatetimeFormatEntity)])),
    ];

    return result;
  }

  @override
  DatetimeFormatListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DatetimeFormatListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DatetimeFormatEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$DatetimeFormatItemResponseSerializer
    implements StructuredSerializer<DatetimeFormatItemResponse> {
  @override
  final Iterable<Type> types = const [
    DatetimeFormatItemResponse,
    _$DatetimeFormatItemResponse
  ];
  @override
  final String wireName = 'DatetimeFormatItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, DatetimeFormatItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(DatetimeFormatEntity)),
    ];

    return result;
  }

  @override
  DatetimeFormatItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DatetimeFormatItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(DatetimeFormatEntity))
              as DatetimeFormatEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$DatetimeFormatEntitySerializer
    implements StructuredSerializer<DatetimeFormatEntity> {
  @override
  final Iterable<Type> types = const [
    DatetimeFormatEntity,
    _$DatetimeFormatEntity
  ];
  @override
  final String wireName = 'DatetimeFormatEntity';

  @override
  Iterable<Object> serialize(
      Serializers serializers, DatetimeFormatEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'format_dart',
      serializers.serialize(object.format,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  DatetimeFormatEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DatetimeFormatEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'format_dart':
          result.format = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$DatetimeFormatListResponse extends DatetimeFormatListResponse {
  @override
  final BuiltList<DatetimeFormatEntity> data;

  factory _$DatetimeFormatListResponse(
          [void Function(DatetimeFormatListResponseBuilder) updates]) =>
      (new DatetimeFormatListResponseBuilder()..update(updates)).build();

  _$DatetimeFormatListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('DatetimeFormatListResponse', 'data');
    }
  }

  @override
  DatetimeFormatListResponse rebuild(
          void Function(DatetimeFormatListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DatetimeFormatListResponseBuilder toBuilder() =>
      new DatetimeFormatListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DatetimeFormatListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DatetimeFormatListResponse')
          ..add('data', data))
        .toString();
  }
}

class DatetimeFormatListResponseBuilder
    implements
        Builder<DatetimeFormatListResponse, DatetimeFormatListResponseBuilder> {
  _$DatetimeFormatListResponse _$v;

  ListBuilder<DatetimeFormatEntity> _data;
  ListBuilder<DatetimeFormatEntity> get data =>
      _$this._data ??= new ListBuilder<DatetimeFormatEntity>();
  set data(ListBuilder<DatetimeFormatEntity> data) => _$this._data = data;

  DatetimeFormatListResponseBuilder();

  DatetimeFormatListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DatetimeFormatListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DatetimeFormatListResponse;
  }

  @override
  void update(void Function(DatetimeFormatListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DatetimeFormatListResponse build() {
    _$DatetimeFormatListResponse _$result;
    try {
      _$result = _$v ?? new _$DatetimeFormatListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DatetimeFormatListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$DatetimeFormatItemResponse extends DatetimeFormatItemResponse {
  @override
  final DatetimeFormatEntity data;

  factory _$DatetimeFormatItemResponse(
          [void Function(DatetimeFormatItemResponseBuilder) updates]) =>
      (new DatetimeFormatItemResponseBuilder()..update(updates)).build();

  _$DatetimeFormatItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('DatetimeFormatItemResponse', 'data');
    }
  }

  @override
  DatetimeFormatItemResponse rebuild(
          void Function(DatetimeFormatItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DatetimeFormatItemResponseBuilder toBuilder() =>
      new DatetimeFormatItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DatetimeFormatItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DatetimeFormatItemResponse')
          ..add('data', data))
        .toString();
  }
}

class DatetimeFormatItemResponseBuilder
    implements
        Builder<DatetimeFormatItemResponse, DatetimeFormatItemResponseBuilder> {
  _$DatetimeFormatItemResponse _$v;

  DatetimeFormatEntityBuilder _data;
  DatetimeFormatEntityBuilder get data =>
      _$this._data ??= new DatetimeFormatEntityBuilder();
  set data(DatetimeFormatEntityBuilder data) => _$this._data = data;

  DatetimeFormatItemResponseBuilder();

  DatetimeFormatItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DatetimeFormatItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DatetimeFormatItemResponse;
  }

  @override
  void update(void Function(DatetimeFormatItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DatetimeFormatItemResponse build() {
    _$DatetimeFormatItemResponse _$result;
    try {
      _$result = _$v ?? new _$DatetimeFormatItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DatetimeFormatItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$DatetimeFormatEntity extends DatetimeFormatEntity {
  @override
  final String id;
  @override
  final String format;

  factory _$DatetimeFormatEntity(
          [void Function(DatetimeFormatEntityBuilder) updates]) =>
      (new DatetimeFormatEntityBuilder()..update(updates)).build();

  _$DatetimeFormatEntity._({this.id, this.format}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('DatetimeFormatEntity', 'id');
    }
    if (format == null) {
      throw new BuiltValueNullFieldError('DatetimeFormatEntity', 'format');
    }
  }

  @override
  DatetimeFormatEntity rebuild(
          void Function(DatetimeFormatEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DatetimeFormatEntityBuilder toBuilder() =>
      new DatetimeFormatEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DatetimeFormatEntity &&
        id == other.id &&
        format == other.format;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, id.hashCode), format.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DatetimeFormatEntity')
          ..add('id', id)
          ..add('format', format))
        .toString();
  }
}

class DatetimeFormatEntityBuilder
    implements Builder<DatetimeFormatEntity, DatetimeFormatEntityBuilder> {
  _$DatetimeFormatEntity _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _format;
  String get format => _$this._format;
  set format(String format) => _$this._format = format;

  DatetimeFormatEntityBuilder();

  DatetimeFormatEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _format = _$v.format;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DatetimeFormatEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DatetimeFormatEntity;
  }

  @override
  void update(void Function(DatetimeFormatEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DatetimeFormatEntity build() {
    final _$result =
        _$v ?? new _$DatetimeFormatEntity._(id: id, format: format);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
