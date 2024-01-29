// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ImportType _$csv = const ImportType._('csv');
const ImportType _$json = const ImportType._('json');
const ImportType _$freshbooks = const ImportType._('freshbooks');
const ImportType _$invoice2go = const ImportType._('invoice2go');
const ImportType _$invoicely = const ImportType._('invoicely');
const ImportType _$waveaccounting = const ImportType._('waveaccounting');
const ImportType _$zoho = const ImportType._('zoho');

ImportType _$typeValueOf(String name) {
  switch (name) {
    case 'csv':
      return _$csv;
    case 'json':
      return _$json;
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
  _$json,
  _$freshbooks,
  _$invoice2go,
  _$invoicely,
  _$waveaccounting,
  _$zoho,
]);

const ExportType _$activities = const ExportType._('activities');
const ExportType _$clients = const ExportType._('clients');
const ExportType _$client_contacts = const ExportType._('client_contacts');
const ExportType _$credits = const ExportType._('credits');
const ExportType _$documents = const ExportType._('documents');
const ExportType _$expenses = const ExportType._('expenses');
const ExportType _$invoices = const ExportType._('invoices');
const ExportType _$invoice_items = const ExportType._('invoice_items');
const ExportType _$quotes = const ExportType._('quotes');
const ExportType _$quote_items = const ExportType._('quote_items');
const ExportType _$recurring_invoices =
    const ExportType._('recurring_invoices');
const ExportType _$payments = const ExportType._('payments');
const ExportType _$products = const ExportType._('products');
const ExportType _$tasks = const ExportType._('tasks');
const ExportType _$profitloss = const ExportType._('profitloss');
const ExportType _$vendor = const ExportType._('vendor');
const ExportType _$purchase_order = const ExportType._('purchase_order');
const ExportType _$purchase_order_item =
    const ExportType._('purchase_order_item');
const ExportType _$ar_detailed = const ExportType._('ar_detailed');
const ExportType _$ar_summary = const ExportType._('ar_summary');
const ExportType _$client_balance = const ExportType._('client_balance');
const ExportType _$client_sales = const ExportType._('client_sales');
const ExportType _$tax_summary = const ExportType._('tax_summary');
const ExportType _$user_sales = const ExportType._('user_sales');

ExportType _$exportValueOf(String name) {
  switch (name) {
    case 'activities':
      return _$activities;
    case 'clients':
      return _$clients;
    case 'client_contacts':
      return _$client_contacts;
    case 'credits':
      return _$credits;
    case 'documents':
      return _$documents;
    case 'expenses':
      return _$expenses;
    case 'invoices':
      return _$invoices;
    case 'invoice_items':
      return _$invoice_items;
    case 'quotes':
      return _$quotes;
    case 'quote_items':
      return _$quote_items;
    case 'recurring_invoices':
      return _$recurring_invoices;
    case 'payments':
      return _$payments;
    case 'products':
      return _$products;
    case 'tasks':
      return _$tasks;
    case 'profitloss':
      return _$profitloss;
    case 'vendor':
      return _$vendor;
    case 'purchase_order':
      return _$purchase_order;
    case 'purchase_order_item':
      return _$purchase_order_item;
    case 'ar_detailed':
      return _$ar_detailed;
    case 'ar_summary':
      return _$ar_summary;
    case 'client_balance':
      return _$client_balance;
    case 'client_sales':
      return _$client_sales;
    case 'tax_summary':
      return _$tax_summary;
    case 'user_sales':
      return _$user_sales;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ExportType> _$exportValues =
    new BuiltSet<ExportType>(const <ExportType>[
  _$activities,
  _$clients,
  _$client_contacts,
  _$credits,
  _$documents,
  _$expenses,
  _$invoices,
  _$invoice_items,
  _$quotes,
  _$quote_items,
  _$recurring_invoices,
  _$payments,
  _$products,
  _$tasks,
  _$profitloss,
  _$vendor,
  _$purchase_order,
  _$purchase_order_item,
  _$ar_detailed,
  _$ar_summary,
  _$client_balance,
  _$client_sales,
  _$tax_summary,
  _$user_sales,
]);

Serializer<PreImportResponse> _$preImportResponseSerializer =
    new _$PreImportResponseSerializer();
Serializer<PreImportResponseEntityDetails>
    _$preImportResponseEntityDetailsSerializer =
    new _$PreImportResponseEntityDetailsSerializer();
Serializer<ImportRequest> _$importRequestSerializer =
    new _$ImportRequestSerializer();
Serializer<ImportRequestMapping> _$importRequestMappingSerializer =
    new _$ImportRequestMappingSerializer();
Serializer<ImportType> _$importTypeSerializer = new _$ImportTypeSerializer();
Serializer<ExportType> _$exportTypeSerializer = new _$ExportTypeSerializer();

class _$PreImportResponseSerializer
    implements StructuredSerializer<PreImportResponse> {
  @override
  final Iterable<Type> types = const [PreImportResponse, _$PreImportResponse];
  @override
  final String wireName = 'PreImportResponse';

  @override
  Iterable<Object?> serialize(Serializers serializers, PreImportResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PreImportResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'hash':
          result.hash = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'mappings':
          result.mappings.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(PreImportResponseEntityDetails)
              ]))!);
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
  Iterable<Object?> serialize(
      Serializers serializers, PreImportResponseEntityDetails object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PreImportResponseEntityDetailsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'available':
          result.available.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'headers':
          result.headers.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(BuiltList, const [const FullType(String)])
              ]))! as BuiltList<Object?>);
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
  Iterable<Object?> serialize(Serializers serializers, ImportRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'hash',
      serializers.serialize(object.hash, specifiedType: const FullType(String)),
      'import_type',
      serializers.serialize(object.importType,
          specifiedType: const FullType(String)),
      'bank_integration_id',
      serializers.serialize(object.bankAccountId,
          specifiedType: const FullType(String)),
      'skip_header',
      serializers.serialize(object.skipHeader,
          specifiedType: const FullType(bool)),
      'column_map',
      serializers.serialize(object.columnMap,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(ImportRequestMapping)
          ])),
    ];

    return result;
  }

  @override
  ImportRequest deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ImportRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'hash':
          result.hash = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'import_type':
          result.importType = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'bank_integration_id':
          result.bankAccountId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'skip_header':
          result.skipHeader = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'column_map':
          result.columnMap.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(ImportRequestMapping)
              ]))!);
          break;
      }
    }

    return result.build();
  }
}

class _$ImportRequestMappingSerializer
    implements StructuredSerializer<ImportRequestMapping> {
  @override
  final Iterable<Type> types = const [
    ImportRequestMapping,
    _$ImportRequestMapping
  ];
  @override
  final String wireName = 'ImportRequestMapping';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ImportRequestMapping object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'mapping',
      serializers.serialize(object.mapping,
          specifiedType: const FullType(
              BuiltMap, const [const FullType(int), const FullType(String)])),
    ];

    return result;
  }

  @override
  ImportRequestMapping deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ImportRequestMappingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'mapping':
          result.mapping.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(int), const FullType(String)]))!);
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

class _$ExportTypeSerializer implements PrimitiveSerializer<ExportType> {
  @override
  final Iterable<Type> types = const <Type>[ExportType];
  @override
  final String wireName = 'ExportType';

  @override
  Object serialize(Serializers serializers, ExportType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  ExportType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ExportType.valueOf(serialized as String);
}

class _$PreImportResponse extends PreImportResponse {
  @override
  final String hash;
  @override
  final BuiltMap<String, PreImportResponseEntityDetails> mappings;

  factory _$PreImportResponse(
          [void Function(PreImportResponseBuilder)? updates]) =>
      (new PreImportResponseBuilder()..update(updates))._build();

  _$PreImportResponse._({required this.hash, required this.mappings})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(hash, r'PreImportResponse', 'hash');
    BuiltValueNullFieldError.checkNotNull(
        mappings, r'PreImportResponse', 'mappings');
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

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, hash.hashCode);
    _$hash = $jc(_$hash, mappings.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PreImportResponse')
          ..add('hash', hash)
          ..add('mappings', mappings))
        .toString();
  }
}

class PreImportResponseBuilder
    implements Builder<PreImportResponse, PreImportResponseBuilder> {
  _$PreImportResponse? _$v;

  String? _hash;
  String? get hash => _$this._hash;
  set hash(String? hash) => _$this._hash = hash;

  MapBuilder<String, PreImportResponseEntityDetails>? _mappings;
  MapBuilder<String, PreImportResponseEntityDetails> get mappings =>
      _$this._mappings ??=
          new MapBuilder<String, PreImportResponseEntityDetails>();
  set mappings(MapBuilder<String, PreImportResponseEntityDetails>? mappings) =>
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
  void update(void Function(PreImportResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PreImportResponse build() => _build();

  _$PreImportResponse _build() {
    _$PreImportResponse _$result;
    try {
      _$result = _$v ??
          new _$PreImportResponse._(
              hash: BuiltValueNullFieldError.checkNotNull(
                  hash, r'PreImportResponse', 'hash'),
              mappings: mappings.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'mappings';
        mappings.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PreImportResponse', _$failedField, e.toString());
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
          [void Function(PreImportResponseEntityDetailsBuilder)? updates]) =>
      (new PreImportResponseEntityDetailsBuilder()..update(updates))._build();

  _$PreImportResponseEntityDetails._(
      {required this.available, required this.headers})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        available, r'PreImportResponseEntityDetails', 'available');
    BuiltValueNullFieldError.checkNotNull(
        headers, r'PreImportResponseEntityDetails', 'headers');
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

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, available.hashCode);
    _$hash = $jc(_$hash, headers.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PreImportResponseEntityDetails')
          ..add('available', available)
          ..add('headers', headers))
        .toString();
  }
}

class PreImportResponseEntityDetailsBuilder
    implements
        Builder<PreImportResponseEntityDetails,
            PreImportResponseEntityDetailsBuilder> {
  _$PreImportResponseEntityDetails? _$v;

  ListBuilder<String>? _available;
  ListBuilder<String> get available =>
      _$this._available ??= new ListBuilder<String>();
  set available(ListBuilder<String>? available) =>
      _$this._available = available;

  ListBuilder<BuiltList<String>>? _headers;
  ListBuilder<BuiltList<String>> get headers =>
      _$this._headers ??= new ListBuilder<BuiltList<String>>();
  set headers(ListBuilder<BuiltList<String>>? headers) =>
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
  void update(void Function(PreImportResponseEntityDetailsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PreImportResponseEntityDetails build() => _build();

  _$PreImportResponseEntityDetails _build() {
    _$PreImportResponseEntityDetails _$result;
    try {
      _$result = _$v ??
          new _$PreImportResponseEntityDetails._(
              available: available.build(), headers: headers.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'available';
        available.build();
        _$failedField = 'headers';
        headers.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PreImportResponseEntityDetails', _$failedField, e.toString());
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
  final String bankAccountId;
  @override
  final bool skipHeader;
  @override
  final BuiltMap<String, ImportRequestMapping> columnMap;

  factory _$ImportRequest([void Function(ImportRequestBuilder)? updates]) =>
      (new ImportRequestBuilder()..update(updates))._build();

  _$ImportRequest._(
      {required this.hash,
      required this.importType,
      required this.bankAccountId,
      required this.skipHeader,
      required this.columnMap})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(hash, r'ImportRequest', 'hash');
    BuiltValueNullFieldError.checkNotNull(
        importType, r'ImportRequest', 'importType');
    BuiltValueNullFieldError.checkNotNull(
        bankAccountId, r'ImportRequest', 'bankAccountId');
    BuiltValueNullFieldError.checkNotNull(
        skipHeader, r'ImportRequest', 'skipHeader');
    BuiltValueNullFieldError.checkNotNull(
        columnMap, r'ImportRequest', 'columnMap');
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
        bankAccountId == other.bankAccountId &&
        skipHeader == other.skipHeader &&
        columnMap == other.columnMap;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, hash.hashCode);
    _$hash = $jc(_$hash, importType.hashCode);
    _$hash = $jc(_$hash, bankAccountId.hashCode);
    _$hash = $jc(_$hash, skipHeader.hashCode);
    _$hash = $jc(_$hash, columnMap.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ImportRequest')
          ..add('hash', hash)
          ..add('importType', importType)
          ..add('bankAccountId', bankAccountId)
          ..add('skipHeader', skipHeader)
          ..add('columnMap', columnMap))
        .toString();
  }
}

class ImportRequestBuilder
    implements Builder<ImportRequest, ImportRequestBuilder> {
  _$ImportRequest? _$v;

  String? _hash;
  String? get hash => _$this._hash;
  set hash(String? hash) => _$this._hash = hash;

  String? _importType;
  String? get importType => _$this._importType;
  set importType(String? importType) => _$this._importType = importType;

  String? _bankAccountId;
  String? get bankAccountId => _$this._bankAccountId;
  set bankAccountId(String? bankAccountId) =>
      _$this._bankAccountId = bankAccountId;

  bool? _skipHeader;
  bool? get skipHeader => _$this._skipHeader;
  set skipHeader(bool? skipHeader) => _$this._skipHeader = skipHeader;

  MapBuilder<String, ImportRequestMapping>? _columnMap;
  MapBuilder<String, ImportRequestMapping> get columnMap =>
      _$this._columnMap ??= new MapBuilder<String, ImportRequestMapping>();
  set columnMap(MapBuilder<String, ImportRequestMapping>? columnMap) =>
      _$this._columnMap = columnMap;

  ImportRequestBuilder();

  ImportRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _hash = $v.hash;
      _importType = $v.importType;
      _bankAccountId = $v.bankAccountId;
      _skipHeader = $v.skipHeader;
      _columnMap = $v.columnMap.toBuilder();
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
  void update(void Function(ImportRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ImportRequest build() => _build();

  _$ImportRequest _build() {
    _$ImportRequest _$result;
    try {
      _$result = _$v ??
          new _$ImportRequest._(
              hash: BuiltValueNullFieldError.checkNotNull(
                  hash, r'ImportRequest', 'hash'),
              importType: BuiltValueNullFieldError.checkNotNull(
                  importType, r'ImportRequest', 'importType'),
              bankAccountId: BuiltValueNullFieldError.checkNotNull(
                  bankAccountId, r'ImportRequest', 'bankAccountId'),
              skipHeader: BuiltValueNullFieldError.checkNotNull(
                  skipHeader, r'ImportRequest', 'skipHeader'),
              columnMap: columnMap.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'columnMap';
        columnMap.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ImportRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ImportRequestMapping extends ImportRequestMapping {
  @override
  final BuiltMap<int, String> mapping;

  factory _$ImportRequestMapping(
          [void Function(ImportRequestMappingBuilder)? updates]) =>
      (new ImportRequestMappingBuilder()..update(updates))._build();

  _$ImportRequestMapping._({required this.mapping}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        mapping, r'ImportRequestMapping', 'mapping');
  }

  @override
  ImportRequestMapping rebuild(
          void Function(ImportRequestMappingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ImportRequestMappingBuilder toBuilder() =>
      new ImportRequestMappingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ImportRequestMapping && mapping == other.mapping;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, mapping.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ImportRequestMapping')
          ..add('mapping', mapping))
        .toString();
  }
}

class ImportRequestMappingBuilder
    implements Builder<ImportRequestMapping, ImportRequestMappingBuilder> {
  _$ImportRequestMapping? _$v;

  MapBuilder<int, String>? _mapping;
  MapBuilder<int, String> get mapping =>
      _$this._mapping ??= new MapBuilder<int, String>();
  set mapping(MapBuilder<int, String>? mapping) => _$this._mapping = mapping;

  ImportRequestMappingBuilder();

  ImportRequestMappingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mapping = $v.mapping.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ImportRequestMapping other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ImportRequestMapping;
  }

  @override
  void update(void Function(ImportRequestMappingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ImportRequestMapping build() => _build();

  _$ImportRequestMapping _build() {
    _$ImportRequestMapping _$result;
    try {
      _$result = _$v ?? new _$ImportRequestMapping._(mapping: mapping.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'mapping';
        mapping.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ImportRequestMapping', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
