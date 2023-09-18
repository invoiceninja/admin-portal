// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_status_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PaymentStatusEntity> _$paymentStatusEntitySerializer =
    new _$PaymentStatusEntitySerializer();

class _$PaymentStatusEntitySerializer
    implements StructuredSerializer<PaymentStatusEntity> {
  @override
  final Iterable<Type> types = const [
    PaymentStatusEntity,
    _$PaymentStatusEntity
  ];
  @override
  final String wireName = 'PaymentStatusEntity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, PaymentStatusEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  PaymentStatusEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaymentStatusEntityBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$PaymentStatusEntity extends PaymentStatusEntity {
  @override
  final String id;
  @override
  final String name;

  factory _$PaymentStatusEntity(
          [void Function(PaymentStatusEntityBuilder)? updates]) =>
      (new PaymentStatusEntityBuilder()..update(updates))._build();

  _$PaymentStatusEntity._({required this.id, required this.name}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'PaymentStatusEntity', 'id');
    BuiltValueNullFieldError.checkNotNull(name, r'PaymentStatusEntity', 'name');
  }

  @override
  PaymentStatusEntity rebuild(
          void Function(PaymentStatusEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentStatusEntityBuilder toBuilder() =>
      new PaymentStatusEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentStatusEntity && id == other.id && name == other.name;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaymentStatusEntity')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class PaymentStatusEntityBuilder
    implements Builder<PaymentStatusEntity, PaymentStatusEntityBuilder> {
  _$PaymentStatusEntity? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  PaymentStatusEntityBuilder();

  PaymentStatusEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentStatusEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PaymentStatusEntity;
  }

  @override
  void update(void Function(PaymentStatusEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaymentStatusEntity build() => _build();

  _$PaymentStatusEntity _build() {
    final _$result = _$v ??
        new _$PaymentStatusEntity._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'PaymentStatusEntity', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'PaymentStatusEntity', 'name'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
