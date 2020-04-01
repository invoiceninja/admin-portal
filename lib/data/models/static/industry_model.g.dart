// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'industry_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<IndustryListResponse> _$industryListResponseSerializer =
    new _$IndustryListResponseSerializer();
Serializer<IndustryItemResponse> _$industryItemResponseSerializer =
    new _$IndustryItemResponseSerializer();
Serializer<IndustryEntity> _$industryEntitySerializer =
    new _$IndustryEntitySerializer();

class _$IndustryListResponseSerializer
    implements StructuredSerializer<IndustryListResponse> {
  @override
  final Iterable<Type> types = const [
    IndustryListResponse,
    _$IndustryListResponse
  ];
  @override
  final String wireName = 'IndustryListResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, IndustryListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(IndustryEntity)])),
    ];

    return result;
  }

  @override
  IndustryListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new IndustryListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(IndustryEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$IndustryItemResponseSerializer
    implements StructuredSerializer<IndustryItemResponse> {
  @override
  final Iterable<Type> types = const [
    IndustryItemResponse,
    _$IndustryItemResponse
  ];
  @override
  final String wireName = 'IndustryItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, IndustryItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(IndustryEntity)),
    ];

    return result;
  }

  @override
  IndustryItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new IndustryItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(IndustryEntity)) as IndustryEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$IndustryEntitySerializer
    implements StructuredSerializer<IndustryEntity> {
  @override
  final Iterable<Type> types = const [IndustryEntity, _$IndustryEntity];
  @override
  final String wireName = 'IndustryEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, IndustryEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  IndustryEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new IndustryEntityBuilder();

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

class _$IndustryListResponse extends IndustryListResponse {
  @override
  final BuiltList<IndustryEntity> data;

  factory _$IndustryListResponse(
          [void Function(IndustryListResponseBuilder) updates]) =>
      (new IndustryListResponseBuilder()..update(updates)).build();

  _$IndustryListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('IndustryListResponse', 'data');
    }
  }

  @override
  IndustryListResponse rebuild(
          void Function(IndustryListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IndustryListResponseBuilder toBuilder() =>
      new IndustryListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IndustryListResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('IndustryListResponse')
          ..add('data', data))
        .toString();
  }
}

class IndustryListResponseBuilder
    implements Builder<IndustryListResponse, IndustryListResponseBuilder> {
  _$IndustryListResponse _$v;

  ListBuilder<IndustryEntity> _data;
  ListBuilder<IndustryEntity> get data =>
      _$this._data ??= new ListBuilder<IndustryEntity>();
  set data(ListBuilder<IndustryEntity> data) => _$this._data = data;

  IndustryListResponseBuilder();

  IndustryListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IndustryListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$IndustryListResponse;
  }

  @override
  void update(void Function(IndustryListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$IndustryListResponse build() {
    _$IndustryListResponse _$result;
    try {
      _$result = _$v ?? new _$IndustryListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'IndustryListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$IndustryItemResponse extends IndustryItemResponse {
  @override
  final IndustryEntity data;

  factory _$IndustryItemResponse(
          [void Function(IndustryItemResponseBuilder) updates]) =>
      (new IndustryItemResponseBuilder()..update(updates)).build();

  _$IndustryItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('IndustryItemResponse', 'data');
    }
  }

  @override
  IndustryItemResponse rebuild(
          void Function(IndustryItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IndustryItemResponseBuilder toBuilder() =>
      new IndustryItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IndustryItemResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('IndustryItemResponse')
          ..add('data', data))
        .toString();
  }
}

class IndustryItemResponseBuilder
    implements Builder<IndustryItemResponse, IndustryItemResponseBuilder> {
  _$IndustryItemResponse _$v;

  IndustryEntityBuilder _data;
  IndustryEntityBuilder get data =>
      _$this._data ??= new IndustryEntityBuilder();
  set data(IndustryEntityBuilder data) => _$this._data = data;

  IndustryItemResponseBuilder();

  IndustryItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IndustryItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$IndustryItemResponse;
  }

  @override
  void update(void Function(IndustryItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$IndustryItemResponse build() {
    _$IndustryItemResponse _$result;
    try {
      _$result = _$v ?? new _$IndustryItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'IndustryItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$IndustryEntity extends IndustryEntity {
  @override
  final String name;
  @override
  final String id;

  factory _$IndustryEntity([void Function(IndustryEntityBuilder) updates]) =>
      (new IndustryEntityBuilder()..update(updates)).build();

  _$IndustryEntity._({this.name, this.id}) : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('IndustryEntity', 'name');
    }
  }

  @override
  IndustryEntity rebuild(void Function(IndustryEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IndustryEntityBuilder toBuilder() =>
      new IndustryEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IndustryEntity && name == other.name && id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, name.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('IndustryEntity')
          ..add('name', name)
          ..add('id', id))
        .toString();
  }
}

class IndustryEntityBuilder
    implements Builder<IndustryEntity, IndustryEntityBuilder> {
  _$IndustryEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  IndustryEntityBuilder();

  IndustryEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IndustryEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$IndustryEntity;
  }

  @override
  void update(void Function(IndustryEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$IndustryEntity build() {
    final _$result = _$v ?? new _$IndustryEntity._(name: name, id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
