// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LanguageListResponse> _$languageListResponseSerializer =
    new _$LanguageListResponseSerializer();
Serializer<LanguageItemResponse> _$languageItemResponseSerializer =
    new _$LanguageItemResponseSerializer();
Serializer<LanguageEntity> _$languageEntitySerializer =
    new _$LanguageEntitySerializer();

class _$LanguageListResponseSerializer
    implements StructuredSerializer<LanguageListResponse> {
  @override
  final Iterable<Type> types = const [
    LanguageListResponse,
    _$LanguageListResponse
  ];
  @override
  final String wireName = 'LanguageListResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, LanguageListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(LanguageEntity)])),
    ];

    return result;
  }

  @override
  LanguageListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LanguageListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(LanguageEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$LanguageItemResponseSerializer
    implements StructuredSerializer<LanguageItemResponse> {
  @override
  final Iterable<Type> types = const [
    LanguageItemResponse,
    _$LanguageItemResponse
  ];
  @override
  final String wireName = 'LanguageItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, LanguageItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(LanguageEntity)),
    ];

    return result;
  }

  @override
  LanguageItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LanguageItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(LanguageEntity)) as LanguageEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$LanguageEntitySerializer
    implements StructuredSerializer<LanguageEntity> {
  @override
  final Iterable<Type> types = const [LanguageEntity, _$LanguageEntity];
  @override
  final String wireName = 'LanguageEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, LanguageEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'locale',
      serializers.serialize(object.locale,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  LanguageEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LanguageEntityBuilder();

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
        case 'locale':
          result.locale = serializers.deserialize(value,
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

class _$LanguageListResponse extends LanguageListResponse {
  @override
  final BuiltList<LanguageEntity> data;

  factory _$LanguageListResponse(
          [void Function(LanguageListResponseBuilder) updates]) =>
      (new LanguageListResponseBuilder()..update(updates)).build();

  _$LanguageListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('LanguageListResponse', 'data');
    }
  }

  @override
  LanguageListResponse rebuild(
          void Function(LanguageListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LanguageListResponseBuilder toBuilder() =>
      new LanguageListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LanguageListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LanguageListResponse')
          ..add('data', data))
        .toString();
  }
}

class LanguageListResponseBuilder
    implements Builder<LanguageListResponse, LanguageListResponseBuilder> {
  _$LanguageListResponse _$v;

  ListBuilder<LanguageEntity> _data;
  ListBuilder<LanguageEntity> get data =>
      _$this._data ??= new ListBuilder<LanguageEntity>();
  set data(ListBuilder<LanguageEntity> data) => _$this._data = data;

  LanguageListResponseBuilder();

  LanguageListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LanguageListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LanguageListResponse;
  }

  @override
  void update(void Function(LanguageListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LanguageListResponse build() {
    _$LanguageListResponse _$result;
    try {
      _$result = _$v ?? new _$LanguageListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LanguageListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$LanguageItemResponse extends LanguageItemResponse {
  @override
  final LanguageEntity data;

  factory _$LanguageItemResponse(
          [void Function(LanguageItemResponseBuilder) updates]) =>
      (new LanguageItemResponseBuilder()..update(updates)).build();

  _$LanguageItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('LanguageItemResponse', 'data');
    }
  }

  @override
  LanguageItemResponse rebuild(
          void Function(LanguageItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LanguageItemResponseBuilder toBuilder() =>
      new LanguageItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LanguageItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LanguageItemResponse')
          ..add('data', data))
        .toString();
  }
}

class LanguageItemResponseBuilder
    implements Builder<LanguageItemResponse, LanguageItemResponseBuilder> {
  _$LanguageItemResponse _$v;

  LanguageEntityBuilder _data;
  LanguageEntityBuilder get data =>
      _$this._data ??= new LanguageEntityBuilder();
  set data(LanguageEntityBuilder data) => _$this._data = data;

  LanguageItemResponseBuilder();

  LanguageItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LanguageItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LanguageItemResponse;
  }

  @override
  void update(void Function(LanguageItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LanguageItemResponse build() {
    _$LanguageItemResponse _$result;
    try {
      _$result = _$v ?? new _$LanguageItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LanguageItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$LanguageEntity extends LanguageEntity {
  @override
  final String name;
  @override
  final String locale;
  @override
  final String id;

  factory _$LanguageEntity([void Function(LanguageEntityBuilder) updates]) =>
      (new LanguageEntityBuilder()..update(updates)).build();

  _$LanguageEntity._({this.name, this.locale, this.id}) : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('LanguageEntity', 'name');
    }
    if (locale == null) {
      throw new BuiltValueNullFieldError('LanguageEntity', 'locale');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('LanguageEntity', 'id');
    }
  }

  @override
  LanguageEntity rebuild(void Function(LanguageEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LanguageEntityBuilder toBuilder() =>
      new LanguageEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LanguageEntity &&
        name == other.name &&
        locale == other.locale &&
        id == other.id;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??=
        $jf($jc($jc($jc(0, name.hashCode), locale.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LanguageEntity')
          ..add('name', name)
          ..add('locale', locale)
          ..add('id', id))
        .toString();
  }
}

class LanguageEntityBuilder
    implements Builder<LanguageEntity, LanguageEntityBuilder> {
  _$LanguageEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _locale;
  String get locale => _$this._locale;
  set locale(String locale) => _$this._locale = locale;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  LanguageEntityBuilder();

  LanguageEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _locale = _$v.locale;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LanguageEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LanguageEntity;
  }

  @override
  void update(void Function(LanguageEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LanguageEntity build() {
    final _$result =
        _$v ?? new _$LanguageEntity._(name: name, locale: locale, id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
