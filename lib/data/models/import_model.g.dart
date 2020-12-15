// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PreImportResponse> _$preImportResponseSerializer =
    new _$PreImportResponseSerializer();
Serializer<ImportRequest> _$importRequestSerializer =
    new _$ImportRequestSerializer();

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

class _$ImportRequestSerializer implements StructuredSerializer<ImportRequest> {
  @override
  final Iterable<Type> types = const [ImportRequest, _$ImportRequest];
  @override
  final String wireName = 'ImportRequest';

  @override
  Iterable<Object> serialize(Serializers serializers, ImportRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'hash',
      serializers.serialize(object.hash, specifiedType: const FullType(String)),
      'entity_type',
      serializers.serialize(object.entityType,
          specifiedType: const FullType(String)),
      'skip_header',
      serializers.serialize(object.skipHeader,
          specifiedType: const FullType(bool)),
      'column_map',
      serializers.serialize(object.columnMap,
          specifiedType: const FullType(
              BuiltMap, const [const FullType(int), const FullType(String)])),
    ];

    return result;
  }

  @override
  ImportRequest deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ImportRequestBuilder();

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
        case 'entity_type':
          result.entityType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'skip_header':
          result.skipHeader = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'column_map':
          result.columnMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(int), const FullType(String)])));
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

class _$ImportRequest extends ImportRequest {
  @override
  final String hash;
  @override
  final String entityType;
  @override
  final bool skipHeader;
  @override
  final BuiltMap<int, String> columnMap;

  factory _$ImportRequest([void Function(ImportRequestBuilder) updates]) =>
      (new ImportRequestBuilder()..update(updates)).build();

  _$ImportRequest._(
      {this.hash, this.entityType, this.skipHeader, this.columnMap})
      : super._() {
    if (hash == null) {
      throw new BuiltValueNullFieldError('ImportRequest', 'hash');
    }
    if (entityType == null) {
      throw new BuiltValueNullFieldError('ImportRequest', 'entityType');
    }
    if (skipHeader == null) {
      throw new BuiltValueNullFieldError('ImportRequest', 'skipHeader');
    }
    if (columnMap == null) {
      throw new BuiltValueNullFieldError('ImportRequest', 'columnMap');
    }
  }

  @override
  ImportRequest rebuild(void Function(ImportRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ImportRequestBuilder toBuilder() => new ImportRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ImportRequest &&
        hash == other.hash &&
        entityType == other.entityType &&
        skipHeader == other.skipHeader &&
        columnMap == other.columnMap;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc($jc($jc(0, hash.hashCode), entityType.hashCode),
            skipHeader.hashCode),
        columnMap.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ImportRequest')
          ..add('hash', hash)
          ..add('entityType', entityType)
          ..add('skipHeader', skipHeader)
          ..add('columnMap', columnMap))
        .toString();
  }
}

class ImportRequestBuilder
    implements Builder<ImportRequest, ImportRequestBuilder> {
  _$ImportRequest _$v;

  String _hash;
  String get hash => _$this._hash;
  set hash(String hash) => _$this._hash = hash;

  String _entityType;
  String get entityType => _$this._entityType;
  set entityType(String entityType) => _$this._entityType = entityType;

  bool _skipHeader;
  bool get skipHeader => _$this._skipHeader;
  set skipHeader(bool skipHeader) => _$this._skipHeader = skipHeader;

  MapBuilder<int, String> _columnMap;
  MapBuilder<int, String> get columnMap =>
      _$this._columnMap ??= new MapBuilder<int, String>();
  set columnMap(MapBuilder<int, String> columnMap) =>
      _$this._columnMap = columnMap;

  ImportRequestBuilder();

  ImportRequestBuilder get _$this {
    if (_$v != null) {
      _hash = _$v.hash;
      _entityType = _$v.entityType;
      _skipHeader = _$v.skipHeader;
      _columnMap = _$v.columnMap?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ImportRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ImportRequest;
  }

  @override
  void update(void Function(ImportRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ImportRequest build() {
    _$ImportRequest _$result;
    try {
      _$result = _$v ??
          new _$ImportRequest._(
              hash: hash,
              entityType: entityType,
              skipHeader: skipHeader,
              columnMap: columnMap.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'columnMap';
        columnMap.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ImportRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
