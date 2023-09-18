// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'font_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FontEntity> _$fontEntitySerializer = new _$FontEntitySerializer();

class _$FontEntitySerializer implements StructuredSerializer<FontEntity> {
  @override
  final Iterable<Type> types = const [FontEntity, _$FontEntity];
  @override
  final String wireName = 'FontEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, FontEntity object,
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
  FontEntity deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FontEntityBuilder();

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

class _$FontEntity extends FontEntity {
  @override
  final String name;
  @override
  final String id;

  factory _$FontEntity([void Function(FontEntityBuilder)? updates]) =>
      (new FontEntityBuilder()..update(updates))._build();

  _$FontEntity._({required this.name, required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'FontEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(id, r'FontEntity', 'id');
  }

  @override
  FontEntity rebuild(void Function(FontEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FontEntityBuilder toBuilder() => new FontEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FontEntity && name == other.name && id == other.id;
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
    return (newBuiltValueToStringHelper(r'FontEntity')
          ..add('name', name)
          ..add('id', id))
        .toString();
  }
}

class FontEntityBuilder implements Builder<FontEntity, FontEntityBuilder> {
  _$FontEntity? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  FontEntityBuilder();

  FontEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FontEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FontEntity;
  }

  @override
  void update(void Function(FontEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FontEntity build() => _build();

  _$FontEntity _build() {
    final _$result = _$v ??
        new _$FontEntity._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'FontEntity', 'name'),
            id: BuiltValueNullFieldError.checkNotNull(id, r'FontEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
