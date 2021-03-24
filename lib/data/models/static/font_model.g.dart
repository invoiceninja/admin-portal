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
  Iterable<Object> serialize(Serializers serializers, FontEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  FontEntity deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FontEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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

  factory _$FontEntity([void Function(FontEntityBuilder) updates]) =>
      (new FontEntityBuilder()..update(updates)).build();

  _$FontEntity._({this.name, this.id}) : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('FontEntity', 'name');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('FontEntity', 'id');
    }
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, name.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FontEntity')
          ..add('name', name)
          ..add('id', id))
        .toString();
  }
}

class FontEntityBuilder implements Builder<FontEntity, FontEntityBuilder> {
  _$FontEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  FontEntityBuilder();

  FontEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FontEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FontEntity;
  }

  @override
  void update(void Function(FontEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FontEntity build() {
    final _$result = _$v ?? new _$FontEntity._(name: name, id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
