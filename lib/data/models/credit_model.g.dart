// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CreditListResponse> _$creditListResponseSerializer =
    new _$CreditListResponseSerializer();
Serializer<CreditItemResponse> _$creditItemResponseSerializer =
    new _$CreditItemResponseSerializer();

class _$CreditListResponseSerializer
    implements StructuredSerializer<CreditListResponse> {
  @override
  final Iterable<Type> types = const [CreditListResponse, _$CreditListResponse];
  @override
  final String wireName = 'CreditListResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, CreditListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(InvoiceEntity)])),
    ];

    return result;
  }

  @override
  CreditListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CreditListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceEntity)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$CreditItemResponseSerializer
    implements StructuredSerializer<CreditItemResponse> {
  @override
  final Iterable<Type> types = const [CreditItemResponse, _$CreditItemResponse];
  @override
  final String wireName = 'CreditItemResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, CreditItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(InvoiceEntity)),
    ];

    return result;
  }

  @override
  CreditItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CreditItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(InvoiceEntity))! as InvoiceEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$CreditListResponse extends CreditListResponse {
  @override
  final BuiltList<InvoiceEntity> data;

  factory _$CreditListResponse(
          [void Function(CreditListResponseBuilder)? updates]) =>
      (new CreditListResponseBuilder()..update(updates))._build();

  _$CreditListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'CreditListResponse', 'data');
  }

  @override
  CreditListResponse rebuild(
          void Function(CreditListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreditListResponseBuilder toBuilder() =>
      new CreditListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreditListResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'CreditListResponse')
          ..add('data', data))
        .toString();
  }
}

class CreditListResponseBuilder
    implements Builder<CreditListResponse, CreditListResponseBuilder> {
  _$CreditListResponse? _$v;

  ListBuilder<InvoiceEntity>? _data;
  ListBuilder<InvoiceEntity> get data =>
      _$this._data ??= new ListBuilder<InvoiceEntity>();
  set data(ListBuilder<InvoiceEntity>? data) => _$this._data = data;

  CreditListResponseBuilder();

  CreditListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreditListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CreditListResponse;
  }

  @override
  void update(void Function(CreditListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreditListResponse build() => _build();

  _$CreditListResponse _build() {
    _$CreditListResponse _$result;
    try {
      _$result = _$v ?? new _$CreditListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CreditListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CreditItemResponse extends CreditItemResponse {
  @override
  final InvoiceEntity data;

  factory _$CreditItemResponse(
          [void Function(CreditItemResponseBuilder)? updates]) =>
      (new CreditItemResponseBuilder()..update(updates))._build();

  _$CreditItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'CreditItemResponse', 'data');
  }

  @override
  CreditItemResponse rebuild(
          void Function(CreditItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreditItemResponseBuilder toBuilder() =>
      new CreditItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreditItemResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'CreditItemResponse')
          ..add('data', data))
        .toString();
  }
}

class CreditItemResponseBuilder
    implements Builder<CreditItemResponse, CreditItemResponseBuilder> {
  _$CreditItemResponse? _$v;

  InvoiceEntityBuilder? _data;
  InvoiceEntityBuilder get data => _$this._data ??= new InvoiceEntityBuilder();
  set data(InvoiceEntityBuilder? data) => _$this._data = data;

  CreditItemResponseBuilder();

  CreditItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreditItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CreditItemResponse;
  }

  @override
  void update(void Function(CreditItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreditItemResponse build() => _build();

  _$CreditItemResponse _build() {
    _$CreditItemResponse _$result;
    try {
      _$result = _$v ?? new _$CreditItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CreditItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
