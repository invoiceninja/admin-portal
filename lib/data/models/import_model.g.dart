// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PreImportResponse> _$preImportResponseSerializer =
    new _$PreImportResponseSerializer();

class _$PreImportResponseSerializer
    implements StructuredSerializer<PreImportResponse> {
  @override
  final Iterable<Type> types = const [PreImportResponse, _$PreImportResponse];
  @override
  final String wireName = 'PreImportResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, PreImportResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'hash',
      serializers.serialize(object.hash, specifiedType: const FullType(String)),
      'headers',
      serializers.serialize(object.headers,
          specifiedType: const FullType(BuiltList, const [
            const FullType(BuiltList, const [const FullType(String)])
          ])),
      'available',
      serializers.serialize(object.available,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  PreImportResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PreImportResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'hash':
          result.hash = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'headers':
          result.headers.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(BuiltList, const [const FullType(String)])
              ])) as BuiltList<Object>);
          break;
        case 'available':
          result.available.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$PreImportResponse extends PreImportResponse {
  @override
  final String hash;
  @override
  final BuiltList<BuiltList<String>> headers;
  @override
  final BuiltList<String> available;

  factory _$PreImportResponse(
          [void Function(PreImportResponseBuilder) updates]) =>
      (new PreImportResponseBuilder()..update(updates)).build();

  _$PreImportResponse._({this.hash, this.headers, this.available}) : super._() {
    if (hash == null) {
      throw new BuiltValueNullFieldError('PreImportResponse', 'hash');
    }
    if (headers == null) {
      throw new BuiltValueNullFieldError('PreImportResponse', 'headers');
    }
    if (available == null) {
      throw new BuiltValueNullFieldError('PreImportResponse', 'available');
    }
  }

  @override
  PreImportResponse rebuild(void Function(PreImportResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PreImportResponseBuilder toBuilder() =>
      new PreImportResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PreImportResponse &&
        hash == other.hash &&
        headers == other.headers &&
        available == other.available;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf(
        $jc($jc($jc(0, hash.hashCode), headers.hashCode), available.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PreImportResponse')
          ..add('hash', hash)
          ..add('headers', headers)
          ..add('available', available))
        .toString();
  }
}

class PreImportResponseBuilder
    implements Builder<PreImportResponse, PreImportResponseBuilder> {
  _$PreImportResponse _$v;

  String _hash;
  String get hash => _$this._hash;
  set hash(String hash) => _$this._hash = hash;

  ListBuilder<BuiltList<String>> _headers;
  ListBuilder<BuiltList<String>> get headers =>
      _$this._headers ??= new ListBuilder<BuiltList<String>>();
  set headers(ListBuilder<BuiltList<String>> headers) =>
      _$this._headers = headers;

  ListBuilder<String> _available;
  ListBuilder<String> get available =>
      _$this._available ??= new ListBuilder<String>();
  set available(ListBuilder<String> available) => _$this._available = available;

  PreImportResponseBuilder();

  PreImportResponseBuilder get _$this {
    if (_$v != null) {
      _hash = _$v.hash;
      _headers = _$v.headers?.toBuilder();
      _available = _$v.available?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PreImportResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PreImportResponse;
  }

  @override
  void update(void Function(PreImportResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PreImportResponse build() {
    _$PreImportResponse _$result;
    try {
      _$result = _$v ??
          new _$PreImportResponse._(
              hash: hash,
              headers: headers.build(),
              available: available.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'headers';
        headers.build();
        _$failedField = 'available';
        available.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PreImportResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
