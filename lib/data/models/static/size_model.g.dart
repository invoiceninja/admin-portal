// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size_model.dart';

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

Serializer<SizeListResponse> _$sizeListResponseSerializer =
    new _$SizeListResponseSerializer();
Serializer<SizeItemResponse> _$sizeItemResponseSerializer =
    new _$SizeItemResponseSerializer();
Serializer<Size> _$sizeSerializer = new _$SizeSerializer();

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
              const FullType(BuiltList, const [const FullType(Size)])),
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
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Size)]))
              as BuiltList);
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
      serializers.serialize(object.data, specifiedType: const FullType(Size)),
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
              specifiedType: const FullType(Size)) as Size);
          break;
      }
    }

    return result.build();
  }
}

class _$SizeSerializer implements StructuredSerializer<Size> {
  @override
  final Iterable<Type> types = const [Size, _$Size];
  @override
  final String wireName = 'Size';

  @override
  Iterable serialize(Serializers serializers, Size object,
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
  Size deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new SizeBuilder();

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

class _$SizeListResponse extends SizeListResponse {
  @override
  final BuiltList<Size> data;

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

  ListBuilder<Size> _data;
  ListBuilder<Size> get data => _$this._data ??= new ListBuilder<Size>();
  set data(ListBuilder<Size> data) => _$this._data = data;

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
  final Size data;

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

  SizeBuilder _data;
  SizeBuilder get data => _$this._data ??= new SizeBuilder();
  set data(SizeBuilder data) => _$this._data = data;

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

class _$Size extends Size {
  @override
  final String name;

  factory _$Size([void updates(SizeBuilder b)]) =>
      (new SizeBuilder()..update(updates)).build();

  _$Size._({this.name}) : super._();

  @override
  Size rebuild(void updates(SizeBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SizeBuilder toBuilder() => new SizeBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Size) return false;
    return name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc(0, name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Size')..add('name', name)).toString();
  }
}

class SizeBuilder implements Builder<Size, SizeBuilder> {
  _$Size _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  SizeBuilder();

  SizeBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Size other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Size;
  }

  @override
  void update(void updates(SizeBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Size build() {
    final _$result = _$v ?? new _$Size._(name: name);
    replace(_$result);
    return _$result;
  }
}
