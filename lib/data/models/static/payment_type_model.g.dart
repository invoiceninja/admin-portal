// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_type_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

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
  Iterable<Object?> serialize(
      Serializers serializers, PaymentTypeListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(PaymentTypeEntity)])),
    ];

    return result;
  }

  @override
  PaymentTypeListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaymentTypeListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PaymentTypeEntity)]))!
              as BuiltList<Object?>);
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
  Iterable<Object?> serialize(
      Serializers serializers, PaymentTypeItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(PaymentTypeEntity)),
    ];

    return result;
  }

  @override
  PaymentTypeItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaymentTypeItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(PaymentTypeEntity))!
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
  Iterable<Object?> serialize(Serializers serializers, PaymentTypeEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  PaymentTypeEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaymentTypeEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
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

class _$PaymentTypeListResponse extends PaymentTypeListResponse {
  @override
  final BuiltList<PaymentTypeEntity> data;

  factory _$PaymentTypeListResponse(
          [void Function(PaymentTypeListResponseBuilder)? updates]) =>
      (new PaymentTypeListResponseBuilder()..update(updates))._build();

  _$PaymentTypeListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'PaymentTypeListResponse', 'data');
  }

  @override
  PaymentTypeListResponse rebuild(
          void Function(PaymentTypeListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentTypeListResponseBuilder toBuilder() =>
      new PaymentTypeListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentTypeListResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'PaymentTypeListResponse')
          ..add('data', data))
        .toString();
  }
}

class PaymentTypeListResponseBuilder
    implements
        Builder<PaymentTypeListResponse, PaymentTypeListResponseBuilder> {
  _$PaymentTypeListResponse? _$v;

  ListBuilder<PaymentTypeEntity>? _data;
  ListBuilder<PaymentTypeEntity> get data =>
      _$this._data ??= new ListBuilder<PaymentTypeEntity>();
  set data(ListBuilder<PaymentTypeEntity>? data) => _$this._data = data;

  PaymentTypeListResponseBuilder();

  PaymentTypeListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentTypeListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PaymentTypeListResponse;
  }

  @override
  void update(void Function(PaymentTypeListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaymentTypeListResponse build() => _build();

  _$PaymentTypeListResponse _build() {
    _$PaymentTypeListResponse _$result;
    try {
      _$result = _$v ?? new _$PaymentTypeListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PaymentTypeListResponse', _$failedField, e.toString());
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
          [void Function(PaymentTypeItemResponseBuilder)? updates]) =>
      (new PaymentTypeItemResponseBuilder()..update(updates))._build();

  _$PaymentTypeItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'PaymentTypeItemResponse', 'data');
  }

  @override
  PaymentTypeItemResponse rebuild(
          void Function(PaymentTypeItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentTypeItemResponseBuilder toBuilder() =>
      new PaymentTypeItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentTypeItemResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'PaymentTypeItemResponse')
          ..add('data', data))
        .toString();
  }
}

class PaymentTypeItemResponseBuilder
    implements
        Builder<PaymentTypeItemResponse, PaymentTypeItemResponseBuilder> {
  _$PaymentTypeItemResponse? _$v;

  PaymentTypeEntityBuilder? _data;
  PaymentTypeEntityBuilder get data =>
      _$this._data ??= new PaymentTypeEntityBuilder();
  set data(PaymentTypeEntityBuilder? data) => _$this._data = data;

  PaymentTypeItemResponseBuilder();

  PaymentTypeItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentTypeItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PaymentTypeItemResponse;
  }

  @override
  void update(void Function(PaymentTypeItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaymentTypeItemResponse build() => _build();

  _$PaymentTypeItemResponse _build() {
    _$PaymentTypeItemResponse _$result;
    try {
      _$result = _$v ?? new _$PaymentTypeItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PaymentTypeItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PaymentTypeEntity extends PaymentTypeEntity {
  @override
  final String name;
  @override
  final String id;

  factory _$PaymentTypeEntity(
          [void Function(PaymentTypeEntityBuilder)? updates]) =>
      (new PaymentTypeEntityBuilder()..update(updates))._build();

  _$PaymentTypeEntity._({required this.name, required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'PaymentTypeEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(id, r'PaymentTypeEntity', 'id');
  }

  @override
  PaymentTypeEntity rebuild(void Function(PaymentTypeEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentTypeEntityBuilder toBuilder() =>
      new PaymentTypeEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentTypeEntity && name == other.name && id == other.id;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaymentTypeEntity')
          ..add('name', name)
          ..add('id', id))
        .toString();
  }
}

class PaymentTypeEntityBuilder
    implements Builder<PaymentTypeEntity, PaymentTypeEntityBuilder> {
  _$PaymentTypeEntity? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  PaymentTypeEntityBuilder();

  PaymentTypeEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentTypeEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PaymentTypeEntity;
  }

  @override
  void update(void Function(PaymentTypeEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaymentTypeEntity build() => _build();

  _$PaymentTypeEntity _build() {
    final _$result = _$v ??
        new _$PaymentTypeEntity._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'PaymentTypeEntity', 'name'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'PaymentTypeEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
