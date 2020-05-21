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
  Iterable<Object> serialize(Serializers serializers, CreditListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(InvoiceEntity)])),
    ];

    return result;
  }

  @override
  CreditListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CreditListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceEntity)]))
              as BuiltList<Object>);
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
  Iterable<Object> serialize(Serializers serializers, CreditItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(InvoiceEntity)),
    ];

    return result;
  }

  @override
  CreditItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CreditItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(InvoiceEntity)) as InvoiceEntity);
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
          [void Function(CreditListResponseBuilder) updates]) =>
      (new CreditListResponseBuilder()..update(updates)).build();

  _$CreditListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('CreditListResponse', 'data');
    }
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CreditListResponse')
          ..add('data', data))
        .toString();
  }
}

class CreditListResponseBuilder
    implements Builder<CreditListResponse, CreditListResponseBuilder> {
  _$CreditListResponse _$v;

  ListBuilder<InvoiceEntity> _data;
  ListBuilder<InvoiceEntity> get data =>
      _$this._data ??= new ListBuilder<InvoiceEntity>();
  set data(ListBuilder<InvoiceEntity> data) => _$this._data = data;

  CreditListResponseBuilder();

  CreditListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreditListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CreditListResponse;
  }

  @override
  void update(void Function(CreditListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CreditListResponse build() {
    _$CreditListResponse _$result;
    try {
      _$result = _$v ?? new _$CreditListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CreditListResponse', _$failedField, e.toString());
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
          [void Function(CreditItemResponseBuilder) updates]) =>
      (new CreditItemResponseBuilder()..update(updates)).build();

  _$CreditItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('CreditItemResponse', 'data');
    }
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CreditItemResponse')
          ..add('data', data))
        .toString();
  }
}

class CreditItemResponseBuilder
    implements Builder<CreditItemResponse, CreditItemResponseBuilder> {
  _$CreditItemResponse _$v;

  InvoiceEntityBuilder _data;
  InvoiceEntityBuilder get data => _$this._data ??= new InvoiceEntityBuilder();
  set data(InvoiceEntityBuilder data) => _$this._data = data;

  CreditItemResponseBuilder();

  CreditItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreditItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CreditItemResponse;
  }

  @override
  void update(void Function(CreditItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CreditItemResponse build() {
    _$CreditItemResponse _$result;
    try {
      _$result = _$v ?? new _$CreditItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CreditItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
