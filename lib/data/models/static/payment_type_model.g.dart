// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_type_model.dart';

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

Serializer<PaymentTypeListResponse> _$paymentTypeListResponseSerializer =
    new _$PaymentTypeListResponseSerializer();
Serializer<PaymentTypeItemResponse> _$paymentTypeItemResponseSerializer =
    new _$PaymentTypeItemResponseSerializer();
Serializer<PaymentTypeEntity> _$paymentTypeEntitySerializer =
    new _$PaymentTypeEntitySerializer();

class _$PaymentTypeListResponseSerializer
    implements StructuredSerializer<PaymentTypeListResponse> {
  @override
  final Iterable<Type> types = const [
    PaymentTypeListResponse,
    _$PaymentTypeListResponse
  ];
  @override
  final String wireName = 'PaymentTypeListResponse';

  @override
  Iterable serialize(Serializers serializers, PaymentTypeListResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(PaymentTypeEntity)])),
    ];

    return result;
  }

  @override
  PaymentTypeListResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new PaymentTypeListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PaymentTypeEntity)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$PaymentTypeItemResponseSerializer
    implements StructuredSerializer<PaymentTypeItemResponse> {
  @override
  final Iterable<Type> types = const [
    PaymentTypeItemResponse,
    _$PaymentTypeItemResponse
  ];
  @override
  final String wireName = 'PaymentTypeItemResponse';

  @override
  Iterable serialize(Serializers serializers, PaymentTypeItemResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(PaymentTypeEntity)),
    ];

    return result;
  }

  @override
  PaymentTypeItemResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new PaymentTypeItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(PaymentTypeEntity))
              as PaymentTypeEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$PaymentTypeEntitySerializer
    implements StructuredSerializer<PaymentTypeEntity> {
  @override
  final Iterable<Type> types = const [PaymentTypeEntity, _$PaymentTypeEntity];
  @override
  final String wireName = 'PaymentTypeEntity';

  @override
  Iterable serialize(Serializers serializers, PaymentTypeEntity object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  PaymentTypeEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new PaymentTypeEntityBuilder();

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
      }
    }

    return result.build();
  }
}

class _$PaymentTypeListResponse extends PaymentTypeListResponse {
  @override
  final BuiltList<PaymentTypeEntity> data;

  factory _$PaymentTypeListResponse(
          [void updates(PaymentTypeListResponseBuilder b)]) =>
      (new PaymentTypeListResponseBuilder()..update(updates)).build();

  _$PaymentTypeListResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('PaymentTypeListResponse', 'data');
  }

  @override
  PaymentTypeListResponse rebuild(
          void updates(PaymentTypeListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentTypeListResponseBuilder toBuilder() =>
      new PaymentTypeListResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! PaymentTypeListResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentTypeListResponse')
          ..add('data', data))
        .toString();
  }
}

class PaymentTypeListResponseBuilder
    implements
        Builder<PaymentTypeListResponse, PaymentTypeListResponseBuilder> {
  _$PaymentTypeListResponse _$v;

  ListBuilder<PaymentTypeEntity> _data;
  ListBuilder<PaymentTypeEntity> get data =>
      _$this._data ??= new ListBuilder<PaymentTypeEntity>();
  set data(ListBuilder<PaymentTypeEntity> data) => _$this._data = data;

  PaymentTypeListResponseBuilder();

  PaymentTypeListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentTypeListResponse other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$PaymentTypeListResponse;
  }

  @override
  void update(void updates(PaymentTypeListResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentTypeListResponse build() {
    _$PaymentTypeListResponse _$result;
    try {
      _$result = _$v ?? new _$PaymentTypeListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PaymentTypeListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PaymentTypeItemResponse extends PaymentTypeItemResponse {
  @override
  final PaymentTypeEntity data;

  factory _$PaymentTypeItemResponse(
          [void updates(PaymentTypeItemResponseBuilder b)]) =>
      (new PaymentTypeItemResponseBuilder()..update(updates)).build();

  _$PaymentTypeItemResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('PaymentTypeItemResponse', 'data');
  }

  @override
  PaymentTypeItemResponse rebuild(
          void updates(PaymentTypeItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentTypeItemResponseBuilder toBuilder() =>
      new PaymentTypeItemResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! PaymentTypeItemResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentTypeItemResponse')
          ..add('data', data))
        .toString();
  }
}

class PaymentTypeItemResponseBuilder
    implements
        Builder<PaymentTypeItemResponse, PaymentTypeItemResponseBuilder> {
  _$PaymentTypeItemResponse _$v;

  PaymentTypeEntityBuilder _data;
  PaymentTypeEntityBuilder get data =>
      _$this._data ??= new PaymentTypeEntityBuilder();
  set data(PaymentTypeEntityBuilder data) => _$this._data = data;

  PaymentTypeItemResponseBuilder();

  PaymentTypeItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentTypeItemResponse other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$PaymentTypeItemResponse;
  }

  @override
  void update(void updates(PaymentTypeItemResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentTypeItemResponse build() {
    _$PaymentTypeItemResponse _$result;
    try {
      _$result = _$v ?? new _$PaymentTypeItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PaymentTypeItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PaymentTypeEntity extends PaymentTypeEntity {
  @override
  final int id;
  @override
  final String name;

  factory _$PaymentTypeEntity([void updates(PaymentTypeEntityBuilder b)]) =>
      (new PaymentTypeEntityBuilder()..update(updates)).build();

  _$PaymentTypeEntity._({this.id, this.name}) : super._() {
    if (id == null)
      throw new BuiltValueNullFieldError('PaymentTypeEntity', 'id');
    if (name == null)
      throw new BuiltValueNullFieldError('PaymentTypeEntity', 'name');
  }

  @override
  PaymentTypeEntity rebuild(void updates(PaymentTypeEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentTypeEntityBuilder toBuilder() =>
      new PaymentTypeEntityBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! PaymentTypeEntity) return false;
    return id == other.id && name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentTypeEntity')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class PaymentTypeEntityBuilder
    implements Builder<PaymentTypeEntity, PaymentTypeEntityBuilder> {
  _$PaymentTypeEntity _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  PaymentTypeEntityBuilder();

  PaymentTypeEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentTypeEntity other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$PaymentTypeEntity;
  }

  @override
  void update(void updates(PaymentTypeEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentTypeEntity build() {
    final _$result = _$v ?? new _$PaymentTypeEntity._(id: id, name: name);
    replace(_$result);
    return _$result;
  }
}
