// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ImportType _$csv = const ImportType._('csv');
const ImportType _$freshbooks = const ImportType._('freshbooks');
const ImportType _$invoice2go = const ImportType._('invoice2go');
const ImportType _$invoicely = const ImportType._('invoicely');
const ImportType _$waveaccounting = const ImportType._('waveaccounting');
const ImportType _$zoho = const ImportType._('zoho');

ImportType _$typeValueOf(String name) {
  switch (name) {
    case 'csv':
      return _$csv;
    case 'freshbooks':
      return _$freshbooks;
    case 'invoice2go':
      return _$invoice2go;
    case 'invoicely':
      return _$invoicely;
    case 'waveaccounting':
      return _$waveaccounting;
    case 'zoho':
      return _$zoho;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ImportType> _$typeValues =
    new BuiltSet<ImportType>(const <ImportType>[
  _$csv,
  _$freshbooks,
  _$invoice2go,
  _$invoicely,
  _$waveaccounting,
  _$zoho,
]);

Serializer<PreImportResponse> _$preImportResponseSerializer =
    new _$PreImportResponseSerializer();
Serializer<PreImportResponseEntityDetails>
    _$preImportResponseEntityDetailsSerializer =
    new _$PreImportResponseEntityDetailsSerializer();
Serializer<ImportRequest> _$importRequestSerializer =
    new _$ImportRequestSerializer();
Serializer<ImportType> _$importTypeSerializer = new _$ImportTypeSerializer();

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
      'mappings',
      serializers.serialize(object.mappings,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(PreImportResponseEntityDetails)
          ])),
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
      final Object value = iterator.current;
      switch (key) {
        case 'hash':
          result.hash = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'mappings':
          result.mappings.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(PreImportResponseEntityDetails)
              ])));
          break;
      }
    }

    return result.build();
  }
}

class _$PreImportResponseEntityDetailsSerializer
    implements StructuredSerializer<PreImportResponseEntityDetails> {
  @override
  final Iterable<Type> types = const [
    PreImportResponseEntityDetails,
    _$PreImportResponseEntityDetails
  ];
  @override
  final String wireName = 'PreImportResponseEntityDetails';

  @override
  Iterable<Object> serialize(
      Serializers serializers, PreImportResponseEntityDetails object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'available',
      serializers.serialize(object.available,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'headers',
      serializers.serialize(object.headers,
          specifiedType: const FullType(BuiltList, const [
            const FullType(BuiltList, const [const FullType(String)])
          ])),
    ];

    return result;
  }

  @override
  PreImportResponseEntityDetails deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PreImportResponseEntityDetailsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'available':
          result.available.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'headers':
          result.headers.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(BuiltList, const [const FullType(String)])
              ])) as BuiltList<Object>);
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
      'import_type',
      serializers.serialize(object.importType,
          specifiedType: const FullType(String)),
      'skip_header',
      serializers.serialize(object.skipHeader,
          specifiedType: const FullType(bool)),
      'column_map',
      serializers.serialize(object.columnMap,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(
                BuiltMap, const [const FullType(int), const FullType(String)])
          ])),
    ];
    Object value;
    value = object.dummy;
    if (value != null) {
      result
        ..add('dummy_field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(int), const FullType(String)])));
    }
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
      final Object value = iterator.current;
      switch (key) {
        case 'hash':
          result.hash = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'import_type':
          result.importType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'skip_header':
          result.skipHeader = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'column_map':
          result.columnMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(BuiltMap,
                    const [const FullType(int), const FullType(String)])
              ])));
          break;
        case 'dummy_field':
          result.dummy.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(int), const FullType(String)])));
          break;
      }
    }

    return result.build();
  }
}

class _$ImportTypeSerializer implements PrimitiveSerializer<ImportType> {
  @override
  final Iterable<Type> types = const <Type>[ImportType];
  @override
  final String wireName = 'ImportType';

  @override
  Object serialize(Serializers serializers, ImportType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  ImportType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ImportType.valueOf(serialized as String);
}

class _$PreImportResponse extends PreImportResponse {
  @override
  final String hash;
  @override
  final BuiltMap<String, PreImportResponseEntityDetails> mappings;

  factory _$PreImportResponse(
          [void Function(PreImportResponseBuilder) updates]) =>
      (new PreImportResponseBuilder()..update(updates)).build();

  _$PreImportResponse._({this.hash, this.mappings}) : super._() {
    BuiltValueNullFieldError.checkNotNull(hash, 'PreImportResponse', 'hash');
    BuiltValueNullFieldError.checkNotNull(
        mappings, 'PreImportResponse', 'mappings');
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
        mappings == other.mappings;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, hash.hashCode), mappings.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PreImportResponse')
          ..add('hash', hash)
          ..add('mappings', mappings))
        .toString();
  }
}

class PreImportResponseBuilder
    implements Builder<PreImportResponse, PreImportResponseBuilder> {
  _$PreImportResponse _$v;

  String _hash;
  String get hash => _$this._hash;
  set hash(String hash) => _$this._hash = hash;

  MapBuilder<String, PreImportResponseEntityDetails> _mappings;
  MapBuilder<String, PreImportResponseEntityDetails> get mappings =>
      _$this._mappings ??=
          new MapBuilder<String, PreImportResponseEntityDetails>();
  set mappings(MapBuilder<String, PreImportResponseEntityDetails> mappings) =>
      _$this._mappings = mappings;

  PreImportResponseBuilder();

  PreImportResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _hash = $v.hash;
      _mappings = $v.mappings.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PreImportResponse other) {
    ArgumentError.checkNotNull(other, 'other');
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
              hash: BuiltValueNullFieldError.checkNotNull(
                  hash, 'PreImportResponse', 'hash'),
              mappings: mappings.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'mappings';
        mappings.build();
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

class _$PreImportResponseEntityDetails extends PreImportResponseEntityDetails {
  @override
  final BuiltList<String> available;
  @override
  final BuiltList<BuiltList<String>> headers;

  factory _$PreImportResponseEntityDetails(
          [void Function(PreImportResponseEntityDetailsBuilder) updates]) =>
      (new PreImportResponseEntityDetailsBuilder()..update(updates)).build();

  _$PreImportResponseEntityDetails._({this.available, this.headers})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        available, 'PreImportResponseEntityDetails', 'available');
    BuiltValueNullFieldError.checkNotNull(
        headers, 'PreImportResponseEntityDetails', 'headers');
  }

  @override
  PreImportResponseEntityDetails rebuild(
          void Function(PreImportResponseEntityDetailsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PreImportResponseEntityDetailsBuilder toBuilder() =>
      new PreImportResponseEntityDetailsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PreImportResponseEntityDetails &&
        available == other.available &&
        headers == other.headers;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??=
        $jf($jc($jc(0, available.hashCode), headers.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PreImportResponseEntityDetails')
          ..add('available', available)
          ..add('headers', headers))
        .toString();
  }
}

class PreImportResponseEntityDetailsBuilder
    implements
        Builder<PreImportResponseEntityDetails,
            PreImportResponseEntityDetailsBuilder> {
  _$PreImportResponseEntityDetails _$v;

  ListBuilder<String> _available;
  ListBuilder<String> get available =>
      _$this._available ??= new ListBuilder<String>();
  set available(ListBuilder<String> available) => _$this._available = available;

  ListBuilder<BuiltList<String>> _headers;
  ListBuilder<BuiltList<String>> get headers =>
      _$this._headers ??= new ListBuilder<BuiltList<String>>();
  set headers(ListBuilder<BuiltList<String>> headers) =>
      _$this._headers = headers;

  PreImportResponseEntityDetailsBuilder();

  PreImportResponseEntityDetailsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _available = $v.available.toBuilder();
      _headers = $v.headers.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PreImportResponseEntityDetails other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PreImportResponseEntityDetails;
  }

  @override
  void update(void Function(PreImportResponseEntityDetailsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PreImportResponseEntityDetails build() {
    _$PreImportResponseEntityDetails _$result;
    try {
      _$result = _$v ??
          new _$PreImportResponseEntityDetails._(
              available: available.build(), headers: headers.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'available';
        available.build();
        _$failedField = 'headers';
        headers.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PreImportResponseEntityDetails', _$failedField, e.toString());
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
  final String importType;
  @override
  final bool skipHeader;
  @override
  final BuiltMap<String, BuiltMap<int, String>> columnMap;
  @override
  final BuiltMap<int, String> dummy;

  factory _$ImportRequest([void Function(ImportRequestBuilder) updates]) =>
      (new ImportRequestBuilder()..update(updates)).build();

  _$ImportRequest._(
      {this.hash, this.importType, this.skipHeader, this.columnMap, this.dummy})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(hash, 'ImportRequest', 'hash');
    BuiltValueNullFieldError.checkNotNull(
        importType, 'ImportRequest', 'importType');
    BuiltValueNullFieldError.checkNotNull(
        skipHeader, 'ImportRequest', 'skipHeader');
    BuiltValueNullFieldError.checkNotNull(
        columnMap, 'ImportRequest', 'columnMap');
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
        importType == other.importType &&
        skipHeader == other.skipHeader &&
        columnMap == other.columnMap &&
        dummy == other.dummy;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc($jc($jc(0, hash.hashCode), importType.hashCode),
                skipHeader.hashCode),
            columnMap.hashCode),
        dummy.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ImportRequest')
          ..add('hash', hash)
          ..add('importType', importType)
          ..add('skipHeader', skipHeader)
          ..add('columnMap', columnMap)
          ..add('dummy', dummy))
        .toString();
  }
}

class ImportRequestBuilder
    implements Builder<ImportRequest, ImportRequestBuilder> {
  _$ImportRequest _$v;

  String _hash;
  String get hash => _$this._hash;
  set hash(String hash) => _$this._hash = hash;

  String _importType;
  String get importType => _$this._importType;
  set importType(String importType) => _$this._importType = importType;

  bool _skipHeader;
  bool get skipHeader => _$this._skipHeader;
  set skipHeader(bool skipHeader) => _$this._skipHeader = skipHeader;

  MapBuilder<String, BuiltMap<int, String>> _columnMap;
  MapBuilder<String, BuiltMap<int, String>> get columnMap =>
      _$this._columnMap ??= new MapBuilder<String, BuiltMap<int, String>>();
  set columnMap(MapBuilder<String, BuiltMap<int, String>> columnMap) =>
      _$this._columnMap = columnMap;

  MapBuilder<int, String> _dummy;
  MapBuilder<int, String> get dummy =>
      _$this._dummy ??= new MapBuilder<int, String>();
  set dummy(MapBuilder<int, String> dummy) => _$this._dummy = dummy;

  ImportRequestBuilder();

  ImportRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _hash = $v.hash;
      _importType = $v.importType;
      _skipHeader = $v.skipHeader;
      _columnMap = $v.columnMap.toBuilder();
      _dummy = $v.dummy?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ImportRequest other) {
    ArgumentError.checkNotNull(other, 'other');
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
              hash: BuiltValueNullFieldError.checkNotNull(
                  hash, 'ImportRequest', 'hash'),
              importType: BuiltValueNullFieldError.checkNotNull(
                  importType, 'ImportRequest', 'importType'),
              skipHeader: BuiltValueNullFieldError.checkNotNull(
                  skipHeader, 'ImportRequest', 'skipHeader'),
              columnMap: columnMap.build(),
              dummy: _dummy?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'columnMap';
        columnMap.build();
        _$failedField = 'dummy';
        _dummy?.build();
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
