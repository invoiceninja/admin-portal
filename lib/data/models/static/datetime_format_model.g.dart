// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datetime_format_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

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
  Iterable serialize(Serializers serializers, DatetimeFormatListResponse object,
      {FullType specifiedType: FullType.unspecified}) {
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
      Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
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
              as BuiltList);
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
  Iterable serialize(Serializers serializers, DatetimeFormatItemResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(DatetimeFormatEntity)),
    ];

    return result;
  }

  @override
  DatetimeFormatItemResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
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
  Iterable serialize(Serializers serializers, DatetimeFormatEntity object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'format',
      serializers.serialize(object.format,
          specifiedType: const FullType(String)),
      'format_moment',
      serializers.serialize(object.formatMoment,
          specifiedType: const FullType(String)),
      'format_dart',
      serializers.serialize(object.formatDart,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  DatetimeFormatEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new DatetimeFormatEntityBuilder();

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
        case 'format':
          result.format = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'format_moment':
          result.formatMoment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'format_dart':
          result.formatDart = serializers.deserialize(value,
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
          [void updates(DatetimeFormatListResponseBuilder b)]) =>
      (new DatetimeFormatListResponseBuilder()..update(updates)).build();

  _$DatetimeFormatListResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('DatetimeFormatListResponse', 'data');
  }

  @override
  DatetimeFormatListResponse rebuild(
          void updates(DatetimeFormatListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  DatetimeFormatListResponseBuilder toBuilder() =>
      new DatetimeFormatListResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! DatetimeFormatListResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
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
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$DatetimeFormatListResponse;
  }

  @override
  void update(void updates(DatetimeFormatListResponseBuilder b)) {
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
          [void updates(DatetimeFormatItemResponseBuilder b)]) =>
      (new DatetimeFormatItemResponseBuilder()..update(updates)).build();

  _$DatetimeFormatItemResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('DatetimeFormatItemResponse', 'data');
  }

  @override
  DatetimeFormatItemResponse rebuild(
          void updates(DatetimeFormatItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  DatetimeFormatItemResponseBuilder toBuilder() =>
      new DatetimeFormatItemResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! DatetimeFormatItemResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
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
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$DatetimeFormatItemResponse;
  }

  @override
  void update(void updates(DatetimeFormatItemResponseBuilder b)) {
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
  final int id;
  @override
  final String format;
  @override
  final String formatMoment;
  @override
  final String formatDart;

  factory _$DatetimeFormatEntity(
          [void updates(DatetimeFormatEntityBuilder b)]) =>
      (new DatetimeFormatEntityBuilder()..update(updates)).build();

  _$DatetimeFormatEntity._(
      {this.id, this.format, this.formatMoment, this.formatDart})
      : super._() {
    if (id == null)
      throw new BuiltValueNullFieldError('DatetimeFormatEntity', 'id');
    if (format == null)
      throw new BuiltValueNullFieldError('DatetimeFormatEntity', 'format');
    if (formatMoment == null)
      throw new BuiltValueNullFieldError(
          'DatetimeFormatEntity', 'formatMoment');
    if (formatDart == null)
      throw new BuiltValueNullFieldError('DatetimeFormatEntity', 'formatDart');
  }

  @override
  DatetimeFormatEntity rebuild(void updates(DatetimeFormatEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  DatetimeFormatEntityBuilder toBuilder() =>
      new DatetimeFormatEntityBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! DatetimeFormatEntity) return false;
    return id == other.id &&
        format == other.format &&
        formatMoment == other.formatMoment &&
        formatDart == other.formatDart;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), format.hashCode), formatMoment.hashCode),
        formatDart.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DatetimeFormatEntity')
          ..add('id', id)
          ..add('format', format)
          ..add('formatMoment', formatMoment)
          ..add('formatDart', formatDart))
        .toString();
  }
}

class DatetimeFormatEntityBuilder
    implements Builder<DatetimeFormatEntity, DatetimeFormatEntityBuilder> {
  _$DatetimeFormatEntity _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _format;
  String get format => _$this._format;
  set format(String format) => _$this._format = format;

  String _formatMoment;
  String get formatMoment => _$this._formatMoment;
  set formatMoment(String formatMoment) => _$this._formatMoment = formatMoment;

  String _formatDart;
  String get formatDart => _$this._formatDart;
  set formatDart(String formatDart) => _$this._formatDart = formatDart;

  DatetimeFormatEntityBuilder();

  DatetimeFormatEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _format = _$v.format;
      _formatMoment = _$v.formatMoment;
      _formatDart = _$v.formatDart;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DatetimeFormatEntity other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$DatetimeFormatEntity;
  }

  @override
  void update(void updates(DatetimeFormatEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$DatetimeFormatEntity build() {
    final _$result = _$v ??
        new _$DatetimeFormatEntity._(
            id: id,
            format: format,
            formatMoment: formatMoment,
            formatDart: formatDart);
    replace(_$result);
    return _$result;
  }
}
