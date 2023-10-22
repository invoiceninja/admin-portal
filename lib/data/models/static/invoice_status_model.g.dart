// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_status_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<InvoiceStatusEntity> _$invoiceStatusEntitySerializer =
    new _$InvoiceStatusEntitySerializer();

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
  Iterable<Object?> serialize(
      Serializers serializers, InvoiceStatusEntity object,
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
  InvoiceStatusEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceStatusEntityBuilder();

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

class _$InvoiceStatusEntity extends InvoiceStatusEntity {
  @override
  final String id;
  @override
  final String name;

  factory _$InvoiceStatusEntity(
          [void Function(InvoiceStatusEntityBuilder)? updates]) =>
      (new InvoiceStatusEntityBuilder()..update(updates))._build();

  _$InvoiceStatusEntity._({required this.id, required this.name}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'InvoiceStatusEntity', 'id');
    BuiltValueNullFieldError.checkNotNull(name, r'InvoiceStatusEntity', 'name');
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
    return (newBuiltValueToStringHelper(r'InvoiceStatusEntity')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class InvoiceStatusEntityBuilder
    implements Builder<InvoiceStatusEntity, InvoiceStatusEntityBuilder> {
  _$InvoiceStatusEntity? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  InvoiceStatusEntityBuilder();

  InvoiceStatusEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceStatusEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$InvoiceStatusEntity;
  }

  @override
  void update(void Function(InvoiceStatusEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InvoiceStatusEntity build() => _build();

  _$InvoiceStatusEntity _build() {
    final _$result = _$v ??
        new _$InvoiceStatusEntity._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'InvoiceStatusEntity', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'InvoiceStatusEntity', 'name'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
