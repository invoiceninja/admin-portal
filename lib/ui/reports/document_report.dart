import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/document_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:memoize/memoize.dart';

enum DocumentReportFields {
  name,
  type,
}

var memoizedDocumentReport = memo6((
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, ProjectEntity> projectMap,
  BuiltMap<String, VendorEntity> vendorMap,
) =>
    documentReport(
      userCompany,
      reportsUIState,
      invoiceMap,
      expenseMap,
      projectMap,
      vendorMap,
    ));

ReportResult documentReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, ProjectEntity> projectMap,
  BuiltMap<String, VendorEntity> vendorMap,
) {
  final List<List<ReportElement>> data = [];
  BuiltList<DocumentReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final documentReportSettings =
      reportSettings != null && reportSettings.containsKey(kReportDocument)
          ? reportSettings[kReportDocument]
          : ReportSettingsEntity();

  final defaultColumns = [
    DocumentReportFields.name,
    DocumentReportFields.type,
  ];

  if (documentReportSettings.columns.isNotEmpty) {
    columns = BuiltList(documentReportSettings.columns
        .map((e) => EnumUtils.fromString(DocumentReportFields.values, e))
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  List<ReportElement> _getRow(DocumentEntity document) {
    if (document.isDeleted ?? false) {
      return null;
    }

    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case DocumentReportFields.name:
          value = document.name;
          break;
        case DocumentReportFields.type:
          value = document.type;
          break;
      }

      if (!ReportResult.matchField(
        value: value,
        userCompany: userCompany,
        reportsUIState: reportsUIState,
        column: EnumUtils.parse(column),
      )) {
        return null;
      }

      if (value.runtimeType == bool) {
        row.add(document.getReportBool(value: value));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        row.add(document.getReportNumber(value: value));
      } else {
        row.add(document.getReportString(value: value));
      }
    }

    return row;
  }

  invoiceMap.forEach((invoiceId, invoice) {
    invoice.documents.forEach((document) {
      final row = _getRow(document);
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
