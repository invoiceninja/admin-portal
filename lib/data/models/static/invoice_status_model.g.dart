// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_status_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<InvoiceStatusListResponse> _$invoiceStatusListResponseSerializer =
    new _$InvoiceStatusListResponseSerializer();
Serializer<InvoiceStatusItemResponse> _$invoiceStatusItemResponseSerializer =
    new _$InvoiceStatusItemResponseSerializer();
Serializer<InvoiceStatusEntity> _$invoiceStatusEntitySerializer =
    new _$InvoiceStatusEntitySerializer();

class _$InvoiceStatusListResponseSerializer
    implements StructuredSerializer<InvoiceStatusListResponse> {
  @override
  final Iterable<Type> types = const [
    InvoiceStatusListResponse,
    _$InvoiceStatusListResponse
  ];
  @override
  final String wireName = 'InvoiceStatusListResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, InvoiceStatusListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(InvoiceStatusEntity)])),
    ];

    return result;
  }

  @override
  InvoiceStatusListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceStatusListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceStatusEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$InvoiceStatusItemResponseSerializer
    implements StructuredSerializer<InvoiceStatusItemResponse> {
  @override
  final Iterable<Type> types = const [
    InvoiceStatusItemResponse,
    _$InvoiceStatusItemResponse
  ];
  @override
  final String wireName = 'InvoiceStatusItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, InvoiceStatusItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(InvoiceStatusEntity)),
    ];

    return result;
  }

  @override
  InvoiceStatusItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceStatusItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(InvoiceStatusEntity))
              as InvoiceStatusEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$InvoiceStatusEntitySerializer
    implements StructuredSerializer<InvoiceStatusEntity> {
  @override
  final Iterable<Type> types = const [
    InvoiceStatusEntity,
    _$InvoiceStatusEntity
  ];
  @override
  final String wireName = 'InvoiceStatusEntity';

  @override
  Iterable<Object> serialize(
      Serializers serializers, InvoiceStatusEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  InvoiceStatusEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceStatusEntityBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$InvoiceStatusListResponse extends InvoiceStatusListResponse {
  @override
  final BuiltList<InvoiceStatusEntity> data;

  factory _$InvoiceStatusListResponse(
          [void Function(InvoiceStatusListResponseBuilder) updates]) =>
      (new InvoiceStatusListResponseBuilder()..update(updates)).build();

  _$InvoiceStatusListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('InvoiceStatusListResponse', 'data');
    }
  }

  @override
  InvoiceStatusListResponse rebuild(
          void Function(InvoiceStatusListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceStatusListResponseBuilder toBuilder() =>
      new InvoiceStatusListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvoiceStatusListResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvoiceStatusListResponse')
          ..add('data', data))
        .toString();
  }
}

class InvoiceStatusListResponseBuilder
    implements
        Builder<InvoiceStatusListResponse, InvoiceStatusListResponseBuilder> {
  _$InvoiceStatusListResponse _$v;

  ListBuilder<InvoiceStatusEntity> _data;
  ListBuilder<InvoiceStatusEntity> get data =>
      _$this._data ??= new ListBuilder<InvoiceStatusEntity>();
  set data(ListBuilder<InvoiceStatusEntity> data) => _$this._data = data;

  InvoiceStatusListResponseBuilder();

  InvoiceStatusListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceStatusListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvoiceStatusListResponse;
  }

  @override
  void update(void Function(InvoiceStatusListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvoiceStatusListResponse build() {
    _$InvoiceStatusListResponse _$result;
    try {
      _$result = _$v ?? new _$InvoiceStatusListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InvoiceStatusListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$InvoiceStatusItemResponse extends InvoiceStatusItemResponse {
  @override
  final InvoiceStatusEntity data;

  factory _$InvoiceStatusItemResponse(
          [void Function(InvoiceStatusItemResponseBuilder) updates]) =>
      (new InvoiceStatusItemResponseBuilder()..update(updates)).build();

  _$InvoiceStatusItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('InvoiceStatusItemResponse', 'data');
    }
  }

  @override
  InvoiceStatusItemResponse rebuild(
          void Function(InvoiceStatusItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceStatusItemResponseBuilder toBuilder() =>
      new InvoiceStatusItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvoiceStatusItemResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvoiceStatusItemResponse')
          ..add('data', data))
        .toString();
  }
}

class InvoiceStatusItemResponseBuilder
    implements
        Builder<InvoiceStatusItemResponse, InvoiceStatusItemResponseBuilder> {
  _$InvoiceStatusItemResponse _$v;

  InvoiceStatusEntityBuilder _data;
  InvoiceStatusEntityBuilder get data =>
      _$this._data ??= new InvoiceStatusEntityBuilder();
  set data(InvoiceStatusEntityBuilder data) => _$this._data = data;

  InvoiceStatusItemResponseBuilder();

  InvoiceStatusItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceStatusItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvoiceStatusItemResponse;
  }

  @override
  void update(void Function(InvoiceStatusItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvoiceStatusItemResponse build() {
    _$InvoiceStatusItemResponse _$result;
    try {
      _$result = _$v ?? new _$InvoiceStatusItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InvoiceStatusItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$InvoiceStatusEntity extends InvoiceStatusEntity {
  @override
  final String id;
  @override
  final String name;

  factory _$InvoiceStatusEntity(
          [void Function(InvoiceStatusEntityBuilder) updates]) =>
      (new InvoiceStatusEntityBuilder()..update(updates)).build();

  _$InvoiceStatusEntity._({this.id, this.name}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('InvoiceStatusEntity', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('InvoiceStatusEntity', 'name');
    }
  }

  @override
  InvoiceStatusEntity rebuild(
          void Function(InvoiceStatusEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceStatusEntityBuilder toBuilder() =>
      new InvoiceStatusEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvoiceStatusEntity && id == other.id && name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvoiceStatusEntity')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class InvoiceStatusEntityBuilder
    implements Builder<InvoiceStatusEntity, InvoiceStatusEntityBuilder> {
  _$InvoiceStatusEntity _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  InvoiceStatusEntityBuilder();

  InvoiceStatusEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceStatusEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvoiceStatusEntity;
  }

  @override
  void update(void Function(InvoiceStatusEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvoiceStatusEntity build() {
    final _$result = _$v ?? new _$InvoiceStatusEntity._(id: id, name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
