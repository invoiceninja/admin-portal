// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_format_model.dart';

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
  Iterable serialize(Serializers serializers, DateFormatListResponse object,
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
      Serializers serializers, Iterable serialized,
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
              as BuiltList);
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
  Iterable serialize(Serializers serializers, DateFormatItemResponse object,
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
      Serializers serializers, Iterable serialized,
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
  Iterable serialize(Serializers serializers, DateFormatEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'format_dart',
      serializers.serialize(object.format,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  DateFormatEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DateFormatEntityBuilder();

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
        case 'format_dart':
          result.format = serializers.deserialize(value,
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
          [void updates(DateFormatListResponseBuilder b)]) =>
      (new DateFormatListResponseBuilder()..update(updates)).build();

  _$DateFormatListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('DateFormatListResponse', 'data');
    }
  }

  @override
  DateFormatListResponse rebuild(
          void updates(DateFormatListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  DateFormatListResponseBuilder toBuilder() =>
      new DateFormatListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DateFormatListResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
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
  void update(void updates(DateFormatListResponseBuilder b)) {
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
          [void updates(DateFormatItemResponseBuilder b)]) =>
      (new DateFormatItemResponseBuilder()..update(updates)).build();

  _$DateFormatItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('DateFormatItemResponse', 'data');
    }
  }

  @override
  DateFormatItemResponse rebuild(
          void updates(DateFormatItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  DateFormatItemResponseBuilder toBuilder() =>
      new DateFormatItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DateFormatItemResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
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
  void update(void updates(DateFormatItemResponseBuilder b)) {
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
  final int id;
  @override
  final String format;

  factory _$DateFormatEntity([void updates(DateFormatEntityBuilder b)]) =>
      (new DateFormatEntityBuilder()..update(updates)).build();

  _$DateFormatEntity._({this.id, this.format}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('DateFormatEntity', 'id');
    }
    if (format == null) {
      throw new BuiltValueNullFieldError('DateFormatEntity', 'format');
    }
  }

  @override
  DateFormatEntity rebuild(void updates(DateFormatEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  DateFormatEntityBuilder toBuilder() =>
      new DateFormatEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DateFormatEntity &&
        id == other.id &&
        format == other.format;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), format.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DateFormatEntity')
          ..add('id', id)
          ..add('format', format))
        .toString();
  }
}

class DateFormatEntityBuilder
    implements Builder<DateFormatEntity, DateFormatEntityBuilder> {
  _$DateFormatEntity _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _format;
  String get format => _$this._format;
  set format(String format) => _$this._format = format;

  DateFormatEntityBuilder();

  DateFormatEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _format = _$v.format;
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
  void update(void updates(DateFormatEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$DateFormatEntity build() {
    final _$result = _$v ?? new _$DateFormatEntity._(id: id, format: format);
    replace(_$result);
    return _$result;
  }
}
