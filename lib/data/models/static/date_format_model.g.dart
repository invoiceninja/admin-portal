// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_format_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DateFormatListResponse> _$dateFormatListResponseSerializer =
    new _$DateFormatListResponseSerializer();
Serializer<DateFormatItemResponse> _$dateFormatItemResponseSerializer =
    new _$DateFormatItemResponseSerializer();
Serializer<DateFormatEntity> _$dateFormatEntitySerializer =
    new _$DateFormatEntitySerializer();

class _$DateFormatListResponseSerializer
    implements StructuredSerializer<DateFormatListResponse> {
  @override
  final Iterable<Type> types = const [
    DateFormatListResponse,
    _$DateFormatListResponse
  ];
  @override
  final String wireName = 'DateFormatListResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, DateFormatListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DateFormatEntity)])),
    ];

    return result;
  }

  @override
  DateFormatListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DateFormatListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DateFormatEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$DateFormatItemResponseSerializer
    implements StructuredSerializer<DateFormatItemResponse> {
  @override
  final Iterable<Type> types = const [
    DateFormatItemResponse,
    _$DateFormatItemResponse
  ];
  @override
  final String wireName = 'DateFormatItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, DateFormatItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(DateFormatEntity)),
    ];

    return result;
  }

  @override
  DateFormatItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DateFormatItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(DateFormatEntity))
              as DateFormatEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$DateFormatEntitySerializer
    implements StructuredSerializer<DateFormatEntity> {
  @override
  final Iterable<Type> types = const [DateFormatEntity, _$DateFormatEntity];
  @override
  final String wireName = 'DateFormatEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, DateFormatEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'format_dart',
      serializers.serialize(object.format,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  DateFormatEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DateFormatEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'format_dart':
          result.format = serializers.deserialize(value,
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

class _$DateFormatListResponse extends DateFormatListResponse {
  @override
  final BuiltList<DateFormatEntity> data;

  factory _$DateFormatListResponse(
          [void Function(DateFormatListResponseBuilder) updates]) =>
      (new DateFormatListResponseBuilder()..update(updates)).build();

  _$DateFormatListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('DateFormatListResponse', 'data');
    }
  }

  @override
  DateFormatListResponse rebuild(
          void Function(DateFormatListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DateFormatListResponseBuilder toBuilder() =>
      new DateFormatListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DateFormatListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DateFormatListResponse')
          ..add('data', data))
        .toString();
  }
}

class DateFormatListResponseBuilder
    implements Builder<DateFormatListResponse, DateFormatListResponseBuilder> {
  _$DateFormatListResponse _$v;

  ListBuilder<DateFormatEntity> _data;
  ListBuilder<DateFormatEntity> get data =>
      _$this._data ??= new ListBuilder<DateFormatEntity>();
  set data(ListBuilder<DateFormatEntity> data) => _$this._data = data;

  DateFormatListResponseBuilder();

  DateFormatListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DateFormatListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DateFormatListResponse;
  }

  @override
  void update(void Function(DateFormatListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DateFormatListResponse build() {
    _$DateFormatListResponse _$result;
    try {
      _$result = _$v ?? new _$DateFormatListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DateFormatListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$DateFormatItemResponse extends DateFormatItemResponse {
  @override
  final DateFormatEntity data;

  factory _$DateFormatItemResponse(
          [void Function(DateFormatItemResponseBuilder) updates]) =>
      (new DateFormatItemResponseBuilder()..update(updates)).build();

  _$DateFormatItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('DateFormatItemResponse', 'data');
    }
  }

  @override
  DateFormatItemResponse rebuild(
          void Function(DateFormatItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DateFormatItemResponseBuilder toBuilder() =>
      new DateFormatItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DateFormatItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DateFormatItemResponse')
          ..add('data', data))
        .toString();
  }
}

class DateFormatItemResponseBuilder
    implements Builder<DateFormatItemResponse, DateFormatItemResponseBuilder> {
  _$DateFormatItemResponse _$v;

  DateFormatEntityBuilder _data;
  DateFormatEntityBuilder get data =>
      _$this._data ??= new DateFormatEntityBuilder();
  set data(DateFormatEntityBuilder data) => _$this._data = data;

  DateFormatItemResponseBuilder();

  DateFormatItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DateFormatItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DateFormatItemResponse;
  }

  @override
  void update(void Function(DateFormatItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DateFormatItemResponse build() {
    _$DateFormatItemResponse _$result;
    try {
      _$result = _$v ?? new _$DateFormatItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DateFormatItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$DateFormatEntity extends DateFormatEntity {
  @override
  final String format;
  @override
  final String id;

  factory _$DateFormatEntity(
          [void Function(DateFormatEntityBuilder) updates]) =>
      (new DateFormatEntityBuilder()..update(updates)).build();

  _$DateFormatEntity._({this.format, this.id}) : super._() {
    if (format == null) {
      throw new BuiltValueNullFieldError('DateFormatEntity', 'format');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('DateFormatEntity', 'id');
    }
  }

  @override
  DateFormatEntity rebuild(void Function(DateFormatEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DateFormatEntityBuilder toBuilder() =>
      new DateFormatEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DateFormatEntity &&
        format == other.format &&
        id == other.id;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, format.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DateFormatEntity')
          ..add('format', format)
          ..add('id', id))
        .toString();
  }
}

class DateFormatEntityBuilder
    implements Builder<DateFormatEntity, DateFormatEntityBuilder> {
  _$DateFormatEntity _$v;

  String _format;
  String get format => _$this._format;
  set format(String format) => _$this._format = format;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  DateFormatEntityBuilder();

  DateFormatEntityBuilder get _$this {
    if (_$v != null) {
      _format = _$v.format;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DateFormatEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DateFormatEntity;
  }

  @override
  void update(void Function(DateFormatEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DateFormatEntity build() {
    final _$result = _$v ?? new _$DateFormatEntity._(format: format, id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
