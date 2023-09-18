// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_status_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DocumentStatusEntity> _$documentStatusEntitySerializer =
    new _$DocumentStatusEntitySerializer();

class _$DocumentStatusEntitySerializer
    implements StructuredSerializer<DocumentStatusEntity> {
  @override
  final Iterable<Type> types = const [
    DocumentStatusEntity,
    _$DocumentStatusEntity
  ];
  @override
  final String wireName = 'DocumentStatusEntity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, DocumentStatusEntity object,
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
  DocumentStatusEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DocumentStatusEntityBuilder();

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

class _$DocumentStatusEntity extends DocumentStatusEntity {
  @override
  final String id;
  @override
  final String name;

  factory _$DocumentStatusEntity(
          [void Function(DocumentStatusEntityBuilder)? updates]) =>
      (new DocumentStatusEntityBuilder()..update(updates))._build();

  _$DocumentStatusEntity._({required this.id, required this.name}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'DocumentStatusEntity', 'id');
    BuiltValueNullFieldError.checkNotNull(
        name, r'DocumentStatusEntity', 'name');
  }

  @override
  DocumentStatusEntity rebuild(
          void Function(DocumentStatusEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DocumentStatusEntityBuilder toBuilder() =>
      new DocumentStatusEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DocumentStatusEntity &&
        id == other.id &&
        name == other.name;
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
    return (newBuiltValueToStringHelper(r'DocumentStatusEntity')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class DocumentStatusEntityBuilder
    implements Builder<DocumentStatusEntity, DocumentStatusEntityBuilder> {
  _$DocumentStatusEntity? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  DocumentStatusEntityBuilder();

  DocumentStatusEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DocumentStatusEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DocumentStatusEntity;
  }

  @override
  void update(void Function(DocumentStatusEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DocumentStatusEntity build() => _build();

  _$DocumentStatusEntity _build() {
    final _$result = _$v ??
        new _$DocumentStatusEntity._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'DocumentStatusEntity', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'DocumentStatusEntity', 'name'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
