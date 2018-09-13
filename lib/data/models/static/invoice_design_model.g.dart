// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_design_model.dart';

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

Serializer<InvoiceDesignListResponse> _$invoiceDesignListResponseSerializer =
    new _$InvoiceDesignListResponseSerializer();
Serializer<InvoiceDesignItemResponse> _$invoiceDesignItemResponseSerializer =
    new _$InvoiceDesignItemResponseSerializer();
Serializer<InvoiceDesignEntity> _$invoiceDesignEntitySerializer =
    new _$InvoiceDesignEntitySerializer();

class _$InvoiceDesignListResponseSerializer
    implements StructuredSerializer<InvoiceDesignListResponse> {
  @override
  final Iterable<Type> types = const [
    InvoiceDesignListResponse,
    _$InvoiceDesignListResponse
  ];
  @override
  final String wireName = 'InvoiceDesignListResponse';

  @override
  Iterable serialize(Serializers serializers, InvoiceDesignListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(InvoiceDesignEntity)])),
    ];

    return result;
  }

  @override
  InvoiceDesignListResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceDesignListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceDesignEntity)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$InvoiceDesignItemResponseSerializer
    implements StructuredSerializer<InvoiceDesignItemResponse> {
  @override
  final Iterable<Type> types = const [
    InvoiceDesignItemResponse,
    _$InvoiceDesignItemResponse
  ];
  @override
  final String wireName = 'InvoiceDesignItemResponse';

  @override
  Iterable serialize(Serializers serializers, InvoiceDesignItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(InvoiceDesignEntity)),
    ];

    return result;
  }

  @override
  InvoiceDesignItemResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceDesignItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(InvoiceDesignEntity))
              as InvoiceDesignEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$InvoiceDesignEntitySerializer
    implements StructuredSerializer<InvoiceDesignEntity> {
  @override
  final Iterable<Type> types = const [
    InvoiceDesignEntity,
    _$InvoiceDesignEntity
  ];
  @override
  final String wireName = 'InvoiceDesignEntity';

  @override
  Iterable serialize(Serializers serializers, InvoiceDesignEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'javascript',
      serializers.serialize(object.javascript,
          specifiedType: const FullType(String)),
      'pdfmake',
      serializers.serialize(object.pdfmake,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  InvoiceDesignEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceDesignEntityBuilder();

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
        case 'javascript':
          result.javascript = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'pdfmake':
          result.pdfmake = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$InvoiceDesignListResponse extends InvoiceDesignListResponse {
  @override
  final BuiltList<InvoiceDesignEntity> data;

  factory _$InvoiceDesignListResponse(
          [void updates(InvoiceDesignListResponseBuilder b)]) =>
      (new InvoiceDesignListResponseBuilder()..update(updates)).build();

  _$InvoiceDesignListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('InvoiceDesignListResponse', 'data');
    }
  }

  @override
  InvoiceDesignListResponse rebuild(
          void updates(InvoiceDesignListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceDesignListResponseBuilder toBuilder() =>
      new InvoiceDesignListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvoiceDesignListResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvoiceDesignListResponse')
          ..add('data', data))
        .toString();
  }
}

class InvoiceDesignListResponseBuilder
    implements
        Builder<InvoiceDesignListResponse, InvoiceDesignListResponseBuilder> {
  _$InvoiceDesignListResponse _$v;

  ListBuilder<InvoiceDesignEntity> _data;
  ListBuilder<InvoiceDesignEntity> get data =>
      _$this._data ??= new ListBuilder<InvoiceDesignEntity>();
  set data(ListBuilder<InvoiceDesignEntity> data) => _$this._data = data;

  InvoiceDesignListResponseBuilder();

  InvoiceDesignListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceDesignListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvoiceDesignListResponse;
  }

  @override
  void update(void updates(InvoiceDesignListResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$InvoiceDesignListResponse build() {
    _$InvoiceDesignListResponse _$result;
    try {
      _$result = _$v ?? new _$InvoiceDesignListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InvoiceDesignListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$InvoiceDesignItemResponse extends InvoiceDesignItemResponse {
  @override
  final InvoiceDesignEntity data;

  factory _$InvoiceDesignItemResponse(
          [void updates(InvoiceDesignItemResponseBuilder b)]) =>
      (new InvoiceDesignItemResponseBuilder()..update(updates)).build();

  _$InvoiceDesignItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('InvoiceDesignItemResponse', 'data');
    }
  }

  @override
  InvoiceDesignItemResponse rebuild(
          void updates(InvoiceDesignItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceDesignItemResponseBuilder toBuilder() =>
      new InvoiceDesignItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvoiceDesignItemResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvoiceDesignItemResponse')
          ..add('data', data))
        .toString();
  }
}

class InvoiceDesignItemResponseBuilder
    implements
        Builder<InvoiceDesignItemResponse, InvoiceDesignItemResponseBuilder> {
  _$InvoiceDesignItemResponse _$v;

  InvoiceDesignEntityBuilder _data;
  InvoiceDesignEntityBuilder get data =>
      _$this._data ??= new InvoiceDesignEntityBuilder();
  set data(InvoiceDesignEntityBuilder data) => _$this._data = data;

  InvoiceDesignItemResponseBuilder();

  InvoiceDesignItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceDesignItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvoiceDesignItemResponse;
  }

  @override
  void update(void updates(InvoiceDesignItemResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$InvoiceDesignItemResponse build() {
    _$InvoiceDesignItemResponse _$result;
    try {
      _$result = _$v ?? new _$InvoiceDesignItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InvoiceDesignItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$InvoiceDesignEntity extends InvoiceDesignEntity {
  @override
  final int id;
  @override
  final String name;
  @override
  final String javascript;
  @override
  final String pdfmake;

  factory _$InvoiceDesignEntity([void updates(InvoiceDesignEntityBuilder b)]) =>
      (new InvoiceDesignEntityBuilder()..update(updates)).build();

  _$InvoiceDesignEntity._({this.id, this.name, this.javascript, this.pdfmake})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('InvoiceDesignEntity', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('InvoiceDesignEntity', 'name');
    }
    if (javascript == null) {
      throw new BuiltValueNullFieldError('InvoiceDesignEntity', 'javascript');
    }
    if (pdfmake == null) {
      throw new BuiltValueNullFieldError('InvoiceDesignEntity', 'pdfmake');
    }
  }

  @override
  InvoiceDesignEntity rebuild(void updates(InvoiceDesignEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceDesignEntityBuilder toBuilder() =>
      new InvoiceDesignEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvoiceDesignEntity &&
        id == other.id &&
        name == other.name &&
        javascript == other.javascript &&
        pdfmake == other.pdfmake;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), name.hashCode), javascript.hashCode),
        pdfmake.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvoiceDesignEntity')
          ..add('id', id)
          ..add('name', name)
          ..add('javascript', javascript)
          ..add('pdfmake', pdfmake))
        .toString();
  }
}

class InvoiceDesignEntityBuilder
    implements Builder<InvoiceDesignEntity, InvoiceDesignEntityBuilder> {
  _$InvoiceDesignEntity _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _javascript;
  String get javascript => _$this._javascript;
  set javascript(String javascript) => _$this._javascript = javascript;

  String _pdfmake;
  String get pdfmake => _$this._pdfmake;
  set pdfmake(String pdfmake) => _$this._pdfmake = pdfmake;

  InvoiceDesignEntityBuilder();

  InvoiceDesignEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _javascript = _$v.javascript;
      _pdfmake = _$v.pdfmake;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceDesignEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvoiceDesignEntity;
  }

  @override
  void update(void updates(InvoiceDesignEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$InvoiceDesignEntity build() {
    final _$result = _$v ??
        new _$InvoiceDesignEntity._(
            id: id, name: name, javascript: javascript, pdfmake: pdfmake);
    replace(_$result);
    return _$result;
  }
}
