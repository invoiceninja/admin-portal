// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';

part 'import_model.g.dart';

abstract class PreImportResponse
    implements Built<PreImportResponse, PreImportResponseBuilder> {
  factory PreImportResponse() {
    return _$PreImportResponse._(
      hash: '',
      mappings: BuiltMap<String, PreImportResponseEntityDetails>(),
    );
  }

  PreImportResponse._();

  @override
  @memoized
  int get hashCode;

  String get hash;

  BuiltMap<String, PreImportResponseEntityDetails> get mappings;

  static Serializer<PreImportResponse> get serializer =>
      _$preImportResponseSerializer;
}

abstract class PreImportResponseEntityDetails
    implements
        Built<PreImportResponseEntityDetails,
            PreImportResponseEntityDetailsBuilder> {
  factory PreImportResponseEntityDetails() {
    return _$PreImportResponseEntityDetails._(
      available: BuiltList<String>(),
      headers: BuiltList<BuiltList<String>>(),
    );
  }

  PreImportResponseEntityDetails._();

  @override
  @memoized
  int get hashCode;

  BuiltList<String> get available;
  BuiltList<BuiltList<String>> get headers;

  BuiltList<String> get fields1 =>
      headers.isEmpty ? BuiltList<String>() : headers[0];

  BuiltList<String> get fields2 =>
      headers.length < 2 ? BuiltList<String>() : headers[1];

  static Serializer<PreImportResponseEntityDetails> get serializer =>
      _$preImportResponseEntityDetailsSerializer;
}

abstract class ImportRequest
    implements Built<ImportRequest, ImportRequestBuilder> {
  factory ImportRequest({
    required String hash,
    required String importType,
    required bool skipHeader,
    required String bankAccountId,
    required BuiltMap<String, ImportRequestMapping> columnMap,
  }) {
    return _$ImportRequest._(
      hash: hash,
      importType: importType,
      skipHeader: skipHeader,
      columnMap: columnMap,
      bankAccountId: bankAccountId,
    );
  }

  ImportRequest._();

  @override
  @memoized
  int get hashCode;

  String get hash;

  @BuiltValueField(wireName: 'import_type')
  String get importType;

  @BuiltValueField(wireName: 'bank_integration_id')
  String get bankAccountId;

  @BuiltValueField(wireName: 'skip_header')
  bool get skipHeader;

  @BuiltValueField(wireName: 'column_map')
  BuiltMap<String, ImportRequestMapping> get columnMap;

  static Serializer<ImportRequest> get serializer => _$importRequestSerializer;
}

abstract class ImportRequestMapping
    implements Built<ImportRequestMapping, ImportRequestMappingBuilder> {
  factory ImportRequestMapping(BuiltMap<int, String> mapping) {
    return _$ImportRequestMapping._(mapping: mapping);
  }

  ImportRequestMapping._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'mapping')
  BuiltMap<int, String> get mapping;

  static Serializer<ImportRequestMapping> get serializer =>
      _$importRequestMappingSerializer;
}

class ImportType extends EnumClass {
  const ImportType._(String name) : super(name);

  static Serializer<ImportType> get serializer => _$importTypeSerializer;

  static const ImportType csv = _$csv;
  static const ImportType json = _$json;
  static const ImportType freshbooks = _$freshbooks;
  static const ImportType invoice2go = _$invoice2go;
  static const ImportType invoicely = _$invoicely;
  static const ImportType waveaccounting = _$waveaccounting;
  static const ImportType zoho = _$zoho;

  static BuiltSet<ImportType> get values => _$typeValues;

  Map<String, String> get uploadParts {
    switch (this) {
      case ImportType.json:
        return {
          'json': 'json',
        };
      case ImportType.csv:
        return {
          EntityType.client.apiValue: 'clients',
          EntityType.product.apiValue: 'products',
          EntityType.invoice.apiValue: 'invoices',
          EntityType.recurringInvoice.apiValue: 'recurring_invoices',
          EntityType.payment.apiValue: 'payments',
          EntityType.quote.apiValue: 'quotes',
          EntityType.task.apiValue: 'tasks',
          EntityType.vendor.apiValue: 'vendors',
          EntityType.expense.apiValue: 'expenses',
          EntityType.transaction.apiValue: 'transactions',
        };
      case ImportType.freshbooks:
      case ImportType.invoicely:
        return {
          EntityType.client.toString(): 'clients',
          EntityType.invoice.toString(): 'invoices',
        };
      case ImportType.waveaccounting:
        return {
          EntityType.client.toString(): 'clients',
          EntityType.invoice.toString(): 'accounting',
        };
      case ImportType.zoho:
        return {
          EntityType.client.toString(): 'contacts',
          EntityType.invoice.toString(): 'invoices',
        };
      case ImportType.invoice2go:
        return {
          EntityType.invoice.toString(): 'invoices',
        };
      default:
        return {};
    }
  }

  static ImportType valueOf(String name) => _$typeValueOf(name);
}

class ExportType extends EnumClass {
  const ExportType._(String name) : super(name);

  static Serializer<ExportType> get serializer => _$exportTypeSerializer;

  static const ExportType activities = _$activities;
  static const ExportType clients = _$clients;
  static const ExportType client_contacts = _$client_contacts;
  static const ExportType credits = _$credits;
  static const ExportType documents = _$documents;
  static const ExportType expenses = _$expenses;
  static const ExportType invoices = _$invoices;
  static const ExportType invoice_items = _$invoice_items;
  static const ExportType quotes = _$quotes;
  static const ExportType quote_items = _$quote_items;
  static const ExportType recurring_invoices = _$recurring_invoices;
  static const ExportType payments = _$payments;
  static const ExportType products = _$products;
  static const ExportType tasks = _$tasks;
  static const ExportType profitloss = _$profitloss;
  static const ExportType vendor = _$vendor;
  static const ExportType purchase_order = _$purchase_order;
  static const ExportType purchase_order_item = _$purchase_order_item;
  static const ExportType ar_detailed = _$ar_detailed;
  static const ExportType ar_summary = _$ar_summary;
  static const ExportType client_balance = _$client_balance;
  static const ExportType client_sales = _$client_sales;
  static const ExportType tax_summary = _$tax_summary;
  static const ExportType user_sales = _$user_sales;

  static BuiltSet<ExportType> get values => _$exportValues;

  static ExportType valueOf(String name) => _$exportValueOf(name);
}
