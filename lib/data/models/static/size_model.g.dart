// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

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
  Iterable<Object> serialize(Serializers serializers, SizeListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(SizeEntity)])),
    ];

    return result;
  }

  @override
  SizeListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
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
                      BuiltList, const [const FullType(SizeEntity)]))
              as BuiltList<Object>);
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
  Iterable<Object> serialize(Serializers serializers, SizeItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(SizeEntity)),
    ];

    return result;
  }

  @override
  SizeItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
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
  Iterable<Object> serialize(Serializers serializers, SizeEntity object,
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
  SizeEntity deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SizeEntityBuilder();

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

class _$SizeListResponse extends SizeListResponse {
  @override
  final BuiltList<SizeEntity> data;

  factory _$SizeListResponse(
          [void Function(SizeListResponseBuilder) updates]) =>
      (new SizeListResponseBuilder()..update(updates)).build();

  _$SizeListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('SizeListResponse', 'data');
    }
  }

  @override
  SizeListResponse rebuild(void Function(SizeListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SizeListResponseBuilder toBuilder() =>
      new SizeListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SizeListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
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
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SizeListResponse;
  }

  @override
  void update(void Function(SizeListResponseBuilder) updates) {
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

  factory _$SizeItemResponse(
          [void Function(SizeItemResponseBuilder) updates]) =>
      (new SizeItemResponseBuilder()..update(updates)).build();

  _$SizeItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('SizeItemResponse', 'data');
    }
  }

  @override
  SizeItemResponse rebuild(void Function(SizeItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SizeItemResponseBuilder toBuilder() =>
      new SizeItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SizeItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
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
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SizeItemResponse;
  }

  @override
  void update(void Function(SizeItemResponseBuilder) updates) {
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
  final String name;
  @override
  final String id;

  factory _$SizeEntity([void Function(SizeEntityBuilder) updates]) =>
      (new SizeEntityBuilder()..update(updates)).build();

  _$SizeEntity._({this.name, this.id}) : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('SizeEntity', 'name');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('SizeEntity', 'id');
    }
  }

  @override
  SizeEntity rebuild(void Function(SizeEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SizeEntityBuilder toBuilder() => new SizeEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SizeEntity && name == other.name && id == other.id;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, name.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SizeEntity')
          ..add('name', name)
          ..add('id', id))
        .toString();
  }
}

class SizeEntityBuilder implements Builder<SizeEntity, SizeEntityBuilder> {
  _$SizeEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  SizeEntityBuilder();

  SizeEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SizeEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SizeEntity;
  }

  @override
  void update(void Function(SizeEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SizeEntity build() {
    final _$result = _$v ?? new _$SizeEntity._(name: name, id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
