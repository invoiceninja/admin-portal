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
  Iterable<Object?> serialize(
      Serializers serializers, DateFormatListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DateFormatEntity)])),
    ];

    return result;
  }

  @override
  DateFormatListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DateFormatListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DateFormatEntity)]))!
              as BuiltList<Object?>);
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
  Iterable<Object?> serialize(
      Serializers serializers, DateFormatItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(DateFormatEntity)),
    ];

    return result;
  }

  @override
  DateFormatItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DateFormatItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(DateFormatEntity))!
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
  Iterable<Object?> serialize(Serializers serializers, DateFormatEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DateFormatEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'format_dart':
          result.format = serializers.deserialize(value,
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

class _$DateFormatListResponse extends DateFormatListResponse {
  @override
  final BuiltList<DateFormatEntity> data;

  factory _$DateFormatListResponse(
          [void Function(DateFormatListResponseBuilder)? updates]) =>
      (new DateFormatListResponseBuilder()..update(updates))._build();

  _$DateFormatListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'DateFormatListResponse', 'data');
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
    return (newBuiltValueToStringHelper(r'DateFormatListResponse')
          ..add('data', data))
        .toString();
  }
}

class DateFormatListResponseBuilder
    implements Builder<DateFormatListResponse, DateFormatListResponseBuilder> {
  _$DateFormatListResponse? _$v;

  ListBuilder<DateFormatEntity>? _data;
  ListBuilder<DateFormatEntity> get data =>
      _$this._data ??= new ListBuilder<DateFormatEntity>();
  set data(ListBuilder<DateFormatEntity>? data) => _$this._data = data;

  DateFormatListResponseBuilder();

  DateFormatListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DateFormatListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DateFormatListResponse;
  }

  @override
  void update(void Function(DateFormatListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DateFormatListResponse build() => _build();

  _$DateFormatListResponse _build() {
    _$DateFormatListResponse _$result;
    try {
      _$result = _$v ?? new _$DateFormatListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'DateFormatListResponse', _$failedField, e.toString());
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
          [void Function(DateFormatItemResponseBuilder)? updates]) =>
      (new DateFormatItemResponseBuilder()..update(updates))._build();

  _$DateFormatItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'DateFormatItemResponse', 'data');
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
    return (newBuiltValueToStringHelper(r'DateFormatItemResponse')
          ..add('data', data))
        .toString();
  }
}

class DateFormatItemResponseBuilder
    implements Builder<DateFormatItemResponse, DateFormatItemResponseBuilder> {
  _$DateFormatItemResponse? _$v;

  DateFormatEntityBuilder? _data;
  DateFormatEntityBuilder get data =>
      _$this._data ??= new DateFormatEntityBuilder();
  set data(DateFormatEntityBuilder? data) => _$this._data = data;

  DateFormatItemResponseBuilder();

  DateFormatItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DateFormatItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DateFormatItemResponse;
  }

  @override
  void update(void Function(DateFormatItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DateFormatItemResponse build() => _build();

  _$DateFormatItemResponse _build() {
    _$DateFormatItemResponse _$result;
    try {
      _$result = _$v ?? new _$DateFormatItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'DateFormatItemResponse', _$failedField, e.toString());
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
          [void Function(DateFormatEntityBuilder)? updates]) =>
      (new DateFormatEntityBuilder()..update(updates))._build();

  _$DateFormatEntity._({required this.format, required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        format, r'DateFormatEntity', 'format');
    BuiltValueNullFieldError.checkNotNull(id, r'DateFormatEntity', 'id');
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

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, format.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DateFormatEntity')
          ..add('format', format)
          ..add('id', id))
        .toString();
  }
}

class DateFormatEntityBuilder
    implements Builder<DateFormatEntity, DateFormatEntityBuilder> {
  _$DateFormatEntity? _$v;

  String? _format;
  String? get format => _$this._format;
  set format(String? format) => _$this._format = format;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateFormatEntityBuilder();

  DateFormatEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _format = $v.format;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DateFormatEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DateFormatEntity;
  }

  @override
  void update(void Function(DateFormatEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DateFormatEntity build() => _build();

  _$DateFormatEntity _build() {
    final _$result = _$v ??
        new _$DateFormatEntity._(
            format: BuiltValueNullFieldError.checkNotNull(
                format, r'DateFormatEntity', 'format'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'DateFormatEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
