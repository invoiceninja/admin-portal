// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<QuoteListResponse> _$quoteListResponseSerializer =
    new _$QuoteListResponseSerializer();
Serializer<QuoteItemResponse> _$quoteItemResponseSerializer =
    new _$QuoteItemResponseSerializer();

class _$QuoteListResponseSerializer
    implements StructuredSerializer<QuoteListResponse> {
  @override
  final Iterable<Type> types = const [QuoteListResponse, _$QuoteListResponse];
  @override
  final String wireName = 'QuoteListResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, QuoteListResponse object,
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
  QuoteListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new QuoteListResponseBuilder();

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

class _$QuoteItemResponseSerializer
    implements StructuredSerializer<QuoteItemResponse> {
  @override
  final Iterable<Type> types = const [QuoteItemResponse, _$QuoteItemResponse];
  @override
  final String wireName = 'QuoteItemResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, QuoteItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(InvoiceEntity)),
    ];

    return result;
  }

  @override
  QuoteItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new QuoteItemResponseBuilder();

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

class _$QuoteListResponse extends QuoteListResponse {
  @override
  final BuiltList<InvoiceEntity> data;

  factory _$QuoteListResponse(
          [void Function(QuoteListResponseBuilder) updates]) =>
      (new QuoteListResponseBuilder()..update(updates)).build();

  _$QuoteListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('QuoteListResponse', 'data');
    }
  }

  @override
  QuoteListResponse rebuild(void Function(QuoteListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuoteListResponseBuilder toBuilder() =>
      new QuoteListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuoteListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('QuoteListResponse')..add('data', data))
        .toString();
  }
}

class QuoteListResponseBuilder
    implements Builder<QuoteListResponse, QuoteListResponseBuilder> {
  _$QuoteListResponse _$v;

  ListBuilder<InvoiceEntity> _data;
  ListBuilder<InvoiceEntity> get data =>
      _$this._data ??= new ListBuilder<InvoiceEntity>();
  set data(ListBuilder<InvoiceEntity> data) => _$this._data = data;

  QuoteListResponseBuilder();

  QuoteListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QuoteListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$QuoteListResponse;
  }

  @override
  void update(void Function(QuoteListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$QuoteListResponse build() {
    _$QuoteListResponse _$result;
    try {
      _$result = _$v ?? new _$QuoteListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'QuoteListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$QuoteItemResponse extends QuoteItemResponse {
  @override
  final InvoiceEntity data;

  factory _$QuoteItemResponse(
          [void Function(QuoteItemResponseBuilder) updates]) =>
      (new QuoteItemResponseBuilder()..update(updates)).build();

  _$QuoteItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('QuoteItemResponse', 'data');
    }
  }

  @override
  QuoteItemResponse rebuild(void Function(QuoteItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuoteItemResponseBuilder toBuilder() =>
      new QuoteItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuoteItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('QuoteItemResponse')..add('data', data))
        .toString();
  }
}

class QuoteItemResponseBuilder
    implements Builder<QuoteItemResponse, QuoteItemResponseBuilder> {
  _$QuoteItemResponse _$v;

  InvoiceEntityBuilder _data;
  InvoiceEntityBuilder get data => _$this._data ??= new InvoiceEntityBuilder();
  set data(InvoiceEntityBuilder data) => _$this._data = data;

  QuoteItemResponseBuilder();

  QuoteItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QuoteItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$QuoteItemResponse;
  }

  @override
  void update(void Function(QuoteItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$QuoteItemResponse build() {
    _$QuoteItemResponse _$result;
    try {
      _$result = _$v ?? new _$QuoteItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'QuoteItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
