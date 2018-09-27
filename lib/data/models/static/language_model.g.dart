// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

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
  Iterable serialize(Serializers serializers, LanguageListResponse object,
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
  LanguageListResponse deserialize(Serializers serializers, Iterable serialized,
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
              as BuiltList);
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
  Iterable serialize(Serializers serializers, LanguageItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(LanguageEntity)),
    ];

    return result;
  }

  @override
  LanguageItemResponse deserialize(Serializers serializers, Iterable serialized,
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
  Iterable serialize(Serializers serializers, LanguageEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'locale',
      serializers.serialize(object.locale,
          specifiedType: const FullType(String)),
    ];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  LanguageEntity deserialize(Serializers serializers, Iterable serialized,
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
              specifiedType: const FullType(int)) as int;
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
          [void updates(LanguageListResponseBuilder b)]) =>
      (new LanguageListResponseBuilder()..update(updates)).build();

  _$LanguageListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('LanguageListResponse', 'data');
    }
  }

  @override
  LanguageListResponse rebuild(void updates(LanguageListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  LanguageListResponseBuilder toBuilder() =>
      new LanguageListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LanguageListResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
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
  void update(void updates(LanguageListResponseBuilder b)) {
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
          [void updates(LanguageItemResponseBuilder b)]) =>
      (new LanguageItemResponseBuilder()..update(updates)).build();

  _$LanguageItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('LanguageItemResponse', 'data');
    }
  }

  @override
  LanguageItemResponse rebuild(void updates(LanguageItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  LanguageItemResponseBuilder toBuilder() =>
      new LanguageItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LanguageItemResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
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
  void update(void updates(LanguageItemResponseBuilder b)) {
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
  final int id;

  factory _$LanguageEntity([void updates(LanguageEntityBuilder b)]) =>
      (new LanguageEntityBuilder()..update(updates)).build();

  _$LanguageEntity._({this.name, this.locale, this.id}) : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('LanguageEntity', 'name');
    }
    if (locale == null) {
      throw new BuiltValueNullFieldError('LanguageEntity', 'locale');
    }
  }

  @override
  LanguageEntity rebuild(void updates(LanguageEntityBuilder b)) =>
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

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, name.hashCode), locale.hashCode), id.hashCode));
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

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

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
  void update(void updates(LanguageEntityBuilder b)) {
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
