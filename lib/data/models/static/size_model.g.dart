// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size_model.dart';

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

Serializer<SizeListResponse> _$sizeListResponseSerializer =
    new _$SizeListResponseSerializer();
Serializer<SizeItemResponse> _$sizeItemResponseSerializer =
    new _$SizeItemResponseSerializer();
Serializer<SizeEntity> _$sizeEntitySerializer = new _$SizeEntitySerializer();

class _$SizeListResponseSerializer
    implements StructuredSerializer<SizeListResponse> {
  @override
  final Iterable<Type> types = const [SizeListResponse, _$SizeListResponse];
  @override
  final String wireName = 'SizeListResponse';

  @override
  Iterable serialize(Serializers serializers, SizeListResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(SizeEntity)])),
    ];

    return result;
  }

  @override
  SizeListResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new SizeListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(SizeEntity)])) as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$SizeItemResponseSerializer
    implements StructuredSerializer<SizeItemResponse> {
  @override
  final Iterable<Type> types = const [SizeItemResponse, _$SizeItemResponse];
  @override
  final String wireName = 'SizeItemResponse';

  @override
  Iterable serialize(Serializers serializers, SizeItemResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(SizeEntity)),
    ];

    return result;
  }

  @override
  SizeItemResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new SizeItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(SizeEntity)) as SizeEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$SizeEntitySerializer implements StructuredSerializer<SizeEntity> {
  @override
  final Iterable<Type> types = const [SizeEntity, _$SizeEntity];
  @override
  final String wireName = 'SizeEntity';

  @override
  Iterable serialize(Serializers serializers, SizeEntity object,
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
  SizeEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new SizeEntityBuilder();

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

class _$SizeListResponse extends SizeListResponse {
  @override
  final BuiltList<SizeEntity> data;

  factory _$SizeListResponse([void updates(SizeListResponseBuilder b)]) =>
      (new SizeListResponseBuilder()..update(updates)).build();

  _$SizeListResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('SizeListResponse', 'data');
  }

  @override
  SizeListResponse rebuild(void updates(SizeListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SizeListResponseBuilder toBuilder() =>
      new SizeListResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! SizeListResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SizeListResponse')..add('data', data))
        .toString();
  }
}

class SizeListResponseBuilder
    implements Builder<SizeListResponse, SizeListResponseBuilder> {
  _$SizeListResponse _$v;

  ListBuilder<SizeEntity> _data;
  ListBuilder<SizeEntity> get data =>
      _$this._data ??= new ListBuilder<SizeEntity>();
  set data(ListBuilder<SizeEntity> data) => _$this._data = data;

  SizeListResponseBuilder();

  SizeListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SizeListResponse other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$SizeListResponse;
  }

  @override
  void update(void updates(SizeListResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SizeListResponse build() {
    _$SizeListResponse _$result;
    try {
      _$result = _$v ?? new _$SizeListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SizeListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SizeItemResponse extends SizeItemResponse {
  @override
  final SizeEntity data;

  factory _$SizeItemResponse([void updates(SizeItemResponseBuilder b)]) =>
      (new SizeItemResponseBuilder()..update(updates)).build();

  _$SizeItemResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('SizeItemResponse', 'data');
  }

  @override
  SizeItemResponse rebuild(void updates(SizeItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SizeItemResponseBuilder toBuilder() =>
      new SizeItemResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! SizeItemResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SizeItemResponse')..add('data', data))
        .toString();
  }
}

class SizeItemResponseBuilder
    implements Builder<SizeItemResponse, SizeItemResponseBuilder> {
  _$SizeItemResponse _$v;

  SizeEntityBuilder _data;
  SizeEntityBuilder get data => _$this._data ??= new SizeEntityBuilder();
  set data(SizeEntityBuilder data) => _$this._data = data;

  SizeItemResponseBuilder();

  SizeItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SizeItemResponse other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$SizeItemResponse;
  }

  @override
  void update(void updates(SizeItemResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SizeItemResponse build() {
    _$SizeItemResponse _$result;
    try {
      _$result = _$v ?? new _$SizeItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SizeItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SizeEntity extends SizeEntity {
  @override
  final int id;
  @override
  final String name;

  factory _$SizeEntity([void updates(SizeEntityBuilder b)]) =>
      (new SizeEntityBuilder()..update(updates)).build();

  _$SizeEntity._({this.id, this.name}) : super._() {
    if (id == null) throw new BuiltValueNullFieldError('SizeEntity', 'id');
    if (name == null) throw new BuiltValueNullFieldError('SizeEntity', 'name');
  }

  @override
  SizeEntity rebuild(void updates(SizeEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SizeEntityBuilder toBuilder() => new SizeEntityBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! SizeEntity) return false;
    return id == other.id && name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SizeEntity')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class SizeEntityBuilder implements Builder<SizeEntity, SizeEntityBuilder> {
  _$SizeEntity _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  SizeEntityBuilder();

  SizeEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SizeEntity other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$SizeEntity;
  }

  @override
  void update(void updates(SizeEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SizeEntity build() {
    final _$result = _$v ?? new _$SizeEntity._(id: id, name: name);
    replace(_$result);
    return _$result;
  }
}
