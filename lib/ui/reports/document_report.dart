import 'package:built_collection/built_collection.dart';
import 'package:intl/intl.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/document_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:memoize/memoize.dart';

enum DocumentReportFields {
  name,
  size,
  width,
  height,
  file_type,
  record_type,
  record_name,
  created_at,
  created_by,
  updated_at,
}

var memoizedDocumentReport = memo10((
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, ProductEntity> productMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, InvoiceEntity> quoteMap,
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, ProjectEntity> projectMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
) =>
    documentReport(
      userCompany,
      reportsUIState,
      clientMap,
      productMap,
      invoiceMap,
      quoteMap,
      expenseMap,
      projectMap,
      vendorMap,
      userMap,
    ));

ReportResult documentReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, ProductEntity> productMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, InvoiceEntity> quoteMap,
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, ProjectEntity> projectMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
) {
  final List<List<ReportElement>> data = [];
  BuiltList<DocumentReportFields> columns;

  final localization =
      AppLocalization(AppLocalization.createLocale(Intl.defaultLocale));
  final reportSettings = userCompany.settings.reportSettings;
  final documentReportSettings =
      reportSettings != null && reportSettings.containsKey(kReportDocument)
          ? reportSettings[kReportDocument]
          : ReportSettingsEntity();

  final defaultColumns = [
    DocumentReportFields.record_type,
    DocumentReportFields.record_name,
    DocumentReportFields.name,
    DocumentReportFields.file_type,
  ];

  if (documentReportSettings.columns.isNotEmpty) {
    columns = BuiltList(documentReportSettings.columns
        .map((e) => EnumUtils.fromString(DocumentReportFields.values, e))
        .where((element) => element != null)
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  List<ReportElement> _getRow(BaseEntity entity, DocumentEntity document) {
    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case DocumentReportFields.name:
          value = document.name;
          break;
        case DocumentReportFields.file_type:
          value = document.type;
          break;
        case DocumentReportFields.created_at:
          value = convertTimestampToDateString(document.createdAt);
          break;
        case DocumentReportFields.created_by:
          value = userMap[document.createdUserId]?.listDisplayName ?? '';
          break;
        case DocumentReportFields.record_name:
          value = entity.listDisplayName;
          break;
        case DocumentReportFields.record_type:
          value = entity.entityType;
          break;
        case DocumentReportFields.updated_at:
          value = convertTimestampToDateString(document.updatedAt);
          break;
        case DocumentReportFields.size:
          value = document.size;
          break;
        case DocumentReportFields.width:
          value = document.width;
          break;
        case DocumentReportFields.height:
          value = document.height;
          break;
      }

      if (!ReportResult.matchField(
        value: value,
        userCompany: userCompany,
        reportsUIState: reportsUIState,
        column: EnumUtils.parse(column),
        localization: localization,
      )) {
        skip = true;
      }

      if (value.runtimeType == bool) {
        row.add(entity.getReportBool(value: value));
      } else if (value.runtimeType == int) {
        row.add(entity.getReportInt(value: value));
      } else if (value.runtimeType == double) {
        row.add(entity.getReportDouble(value: value));
      } else if (value.runtimeType == EntityType) {
        row.add(entity.getReportEntityType());
      } else {
        row.add(entity.getReportString(value: value));
      }
    }

    return skip ? null : row;
  }

  clientMap.forEach((clientId, client) {
    client.documents.forEach((document) {
      final row = _getRow(client, document);
      if (row != null) {
        data.add(row);
      }
    });
  });

  productMap.forEach((productId, product) {
    product.documents.forEach((document) {
      final row = _getRow(product, document);
      if (row != null) {
        data.add(row);
      }
    });
  });

  invoiceMap.forEach((invoiceId, invoice) {
    invoice.documents.forEach((document) {
      final row = _getRow(invoice, document);
      if (row != null) {
        data.add(row);
      }
    });
  });

  quoteMap.forEach((quoteId, quote) {
    quote.documents.forEach((document) {
      final row = _getRow(quote, document);
      if (row != null) {
        data.add(row);
      }
    });
  });

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, documentReportSettings, selectedColumns));

  return ReportResult(
    allColumns:
        DocumentReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
    showTotals: false,
  );
}
