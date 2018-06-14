// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'industry_model.dart';

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

Serializer<IndustryListResponse> _$industryListResponseSerializer =
    new _$IndustryListResponseSerializer();
Serializer<IndustryItemResponse> _$industryItemResponseSerializer =
    new _$IndustryItemResponseSerializer();
Serializer<Industry> _$industrySerializer = new _$IndustrySerializer();

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
  Iterable serialize(Serializers serializers, IndustryListResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Industry)])),
    ];

    return result;
  }

  @override
  IndustryListResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
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
                  BuiltList, const [const FullType(Industry)])) as BuiltList);
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
  Iterable serialize(Serializers serializers, IndustryItemResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(Industry)),
    ];

    return result;
  }

  @override
  IndustryItemResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new IndustryItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(Industry)) as Industry);
          break;
      }
    }

    return result.build();
  }
}

class _$IndustrySerializer implements StructuredSerializer<Industry> {
  @override
  final Iterable<Type> types = const [Industry, _$Industry];
  @override
  final String wireName = 'Industry';

  @override
  Iterable serialize(Serializers serializers, Industry object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Industry deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new IndustryBuilder();

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
      }
    }

    return result.build();
  }
}

class _$IndustryListResponse extends IndustryListResponse {
  @override
  final BuiltList<Industry> data;

  factory _$IndustryListResponse(
          [void updates(IndustryListResponseBuilder b)]) =>
      (new IndustryListResponseBuilder()..update(updates)).build();

  _$IndustryListResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('IndustryListResponse', 'data');
  }

  @override
  IndustryListResponse rebuild(void updates(IndustryListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  IndustryListResponseBuilder toBuilder() =>
      new IndustryListResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! IndustryListResponse) return false;
    return data == other.data;
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

  ListBuilder<Industry> _data;
  ListBuilder<Industry> get data =>
      _$this._data ??= new ListBuilder<Industry>();
  set data(ListBuilder<Industry> data) => _$this._data = data;

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
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$IndustryListResponse;
  }

  @override
  void update(void updates(IndustryListResponseBuilder b)) {
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
  final Industry data;

  factory _$IndustryItemResponse(
          [void updates(IndustryItemResponseBuilder b)]) =>
      (new IndustryItemResponseBuilder()..update(updates)).build();

  _$IndustryItemResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('IndustryItemResponse', 'data');
  }

  @override
  IndustryItemResponse rebuild(void updates(IndustryItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  IndustryItemResponseBuilder toBuilder() =>
      new IndustryItemResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! IndustryItemResponse) return false;
    return data == other.data;
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

  IndustryBuilder _data;
  IndustryBuilder get data => _$this._data ??= new IndustryBuilder();
  set data(IndustryBuilder data) => _$this._data = data;

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
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$IndustryItemResponse;
  }

  @override
  void update(void updates(IndustryItemResponseBuilder b)) {
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

class _$Industry extends Industry {
  @override
  final String name;

  factory _$Industry([void updates(IndustryBuilder b)]) =>
      (new IndustryBuilder()..update(updates)).build();

  _$Industry._({this.name}) : super._();

  @override
  Industry rebuild(void updates(IndustryBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  IndustryBuilder toBuilder() => new IndustryBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Industry) return false;
    return name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc(0, name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Industry')..add('name', name))
        .toString();
  }
}

class IndustryBuilder implements Builder<Industry, IndustryBuilder> {
  _$Industry _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  IndustryBuilder();

  IndustryBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Industry other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Industry;
  }

  @override
  void update(void updates(IndustryBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Industry build() {
    final _$result = _$v ?? new _$Industry._(name: name);
    replace(_$result);
    return _$result;
  }
}
