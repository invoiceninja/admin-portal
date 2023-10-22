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
  Iterable<Object?> serialize(
      Serializers serializers, DatetimeFormatListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DatetimeFormatEntity)])),
    ];

    return result;
  }

  @override
  DatetimeFormatListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DatetimeFormatListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DatetimeFormatEntity)]))!
              as BuiltList<Object?>);
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
  Iterable<Object?> serialize(
      Serializers serializers, DatetimeFormatItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(DatetimeFormatEntity)),
    ];

    return result;
  }

  @override
  DatetimeFormatItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DatetimeFormatItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(DatetimeFormatEntity))!
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
  Iterable<Object?> serialize(
      Serializers serializers, DatetimeFormatEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DatetimeFormatEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'format_dart':
          result.format = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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
          [void Function(DatetimeFormatListResponseBuilder)? updates]) =>
      (new DatetimeFormatListResponseBuilder()..update(updates))._build();

  _$DatetimeFormatListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'DatetimeFormatListResponse', 'data');
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
    return (newBuiltValueToStringHelper(r'DatetimeFormatListResponse')
          ..add('data', data))
        .toString();
  }
}

class DatetimeFormatListResponseBuilder
    implements
        Builder<DatetimeFormatListResponse, DatetimeFormatListResponseBuilder> {
  _$DatetimeFormatListResponse? _$v;

  ListBuilder<DatetimeFormatEntity>? _data;
  ListBuilder<DatetimeFormatEntity> get data =>
      _$this._data ??= new ListBuilder<DatetimeFormatEntity>();
  set data(ListBuilder<DatetimeFormatEntity>? data) => _$this._data = data;

  DatetimeFormatListResponseBuilder();

  DatetimeFormatListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DatetimeFormatListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DatetimeFormatListResponse;
  }

  @override
  void update(void Function(DatetimeFormatListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DatetimeFormatListResponse build() => _build();

  _$DatetimeFormatListResponse _build() {
    _$DatetimeFormatListResponse _$result;
    try {
      _$result = _$v ?? new _$DatetimeFormatListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'DatetimeFormatListResponse', _$failedField, e.toString());
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
          [void Function(DatetimeFormatItemResponseBuilder)? updates]) =>
      (new DatetimeFormatItemResponseBuilder()..update(updates))._build();

  _$DatetimeFormatItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'DatetimeFormatItemResponse', 'data');
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
    return (newBuiltValueToStringHelper(r'DatetimeFormatItemResponse')
          ..add('data', data))
        .toString();
  }
}

class DatetimeFormatItemResponseBuilder
    implements
        Builder<DatetimeFormatItemResponse, DatetimeFormatItemResponseBuilder> {
  _$DatetimeFormatItemResponse? _$v;

  DatetimeFormatEntityBuilder? _data;
  DatetimeFormatEntityBuilder get data =>
      _$this._data ??= new DatetimeFormatEntityBuilder();
  set data(DatetimeFormatEntityBuilder? data) => _$this._data = data;

  DatetimeFormatItemResponseBuilder();

  DatetimeFormatItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DatetimeFormatItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DatetimeFormatItemResponse;
  }

  @override
  void update(void Function(DatetimeFormatItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DatetimeFormatItemResponse build() => _build();

  _$DatetimeFormatItemResponse _build() {
    _$DatetimeFormatItemResponse _$result;
    try {
      _$result = _$v ?? new _$DatetimeFormatItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'DatetimeFormatItemResponse', _$failedField, e.toString());
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
          [void Function(DatetimeFormatEntityBuilder)? updates]) =>
      (new DatetimeFormatEntityBuilder()..update(updates))._build();

  _$DatetimeFormatEntity._({required this.id, required this.format})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'DatetimeFormatEntity', 'id');
    BuiltValueNullFieldError.checkNotNull(
        format, r'DatetimeFormatEntity', 'format');
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

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, format.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DatetimeFormatEntity')
          ..add('id', id)
          ..add('format', format))
        .toString();
  }
}

class DatetimeFormatEntityBuilder
    implements Builder<DatetimeFormatEntity, DatetimeFormatEntityBuilder> {
  _$DatetimeFormatEntity? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _format;
  String? get format => _$this._format;
  set format(String? format) => _$this._format = format;

  DatetimeFormatEntityBuilder();

  DatetimeFormatEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _format = $v.format;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DatetimeFormatEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DatetimeFormatEntity;
  }

  @override
  void update(void Function(DatetimeFormatEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DatetimeFormatEntity build() => _build();

  _$DatetimeFormatEntity _build() {
    final _$result = _$v ??
        new _$DatetimeFormatEntity._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'DatetimeFormatEntity', 'id'),
            format: BuiltValueNullFieldError.checkNotNull(
                format, r'DatetimeFormatEntity', 'format'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
