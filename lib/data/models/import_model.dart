import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';

part 'import_model.g.dart';

abstract class PreImportResponse
    implements Built<PreImportResponse, PreImportResponseBuilder> {
  factory PreImportResponse() {
    return _$PreImportResponse._();
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
    return _$PreImportResponseEntityDetails._();
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
    @required String hash,
    @required String importType,
    @required bool skipHeader,
    @required BuiltMap<String, ImportRequestMapping> columnMap,
  }) {
    return _$ImportRequest._(
      hash: hash,
      importType: importType,
      skipHeader: skipHeader,
      columnMap: columnMap,
    );
  }

  ImportRequest._();

  @override
  @memoized
  int get hashCode;

  String get hash;

  @BuiltValueField(wireName: 'import_type')
  String get importType;

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
  static const ImportType freshbooks = _$freshbooks;
  static const ImportType invoice2go = _$invoice2go;

  static const ImportType invoicely = _$invoicely;
  static const ImportType waveaccounting = _$waveaccounting;
  static const ImportType zoho = _$zoho;

  static BuiltSet<ImportType> get values => _$typeValues;

  Map<String, String> get uploadParts {
    switch (this) {
      case ImportType.csv:
        return {
          EntityType.client.toString(): 'clients',
          EntityType.invoice.toString(): 'invoices',
          EntityType.payment.toString(): 'payments',
          EntityType.product.toString(): 'products',
          EntityType.vendor.toString(): 'vendors',
          EntityType.expense.toString(): 'expenses',
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
