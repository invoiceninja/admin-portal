import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/document_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:memoize/memoize.dart';

enum DocumentReportFields {
  name,
  type,
  invoice,
  invoice_amount,
  invoice_date,
  invoice_due_date,
  expense,
  project,
  vendor,
}

var memoizedDocumentReport = memo9((
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, DocumentEntity> documentMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, ProjectEntity> projectMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    documentReport(userCompany, reportsUIState, documentMap, invoiceMap,
        expenseMap, projectMap, vendorMap, userMap, staticState));

ReportResult documentReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, DocumentEntity> documentMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ExpenseEntity> expenseMap,
  BuiltMap<String, ProjectEntity> projectMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
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
    DocumentReportFields.invoice,
    DocumentReportFields.expense,
    DocumentReportFields.vendor,
  ];

  if (documentReportSettings.columns.isNotEmpty) {
    columns = BuiltList(documentReportSettings.columns
        .map((e) => EnumUtils.fromString(DocumentReportFields.values, e))
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var documentId in documentMap.keys) {
    final document = documentMap[documentId];
    final invoice = invoiceMap[document.invoiceId];
    final expense = expenseMap[document.expenseId];
    final project = projectMap[document.projectId];
    final vendor = vendorMap[document.vendorId];

    if (document.isDeleted) {
      continue;
    }

    bool skip = false;
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
        case DocumentReportFields.invoice:
          value = invoice.listDisplayName;
          break;
        case DocumentReportFields.invoice_amount:
          value = invoice.amount;
          break;
        case DocumentReportFields.invoice_date:
          value = invoice.date;
          break;
        case DocumentReportFields.invoice_due_date:
          value = invoice.dueDate;
          break;
        case DocumentReportFields.expense:
          value = expense.listDisplayName;
          break;
        case DocumentReportFields.project:
          value = project.listDisplayName;
          break;
        case DocumentReportFields.vendor:
          value = vendor.listDisplayName;
          break;
      }

      if (!ReportResult.matchField(
        value: value,
        userCompany: userCompany,
        reportsUIState: reportsUIState,
        column: EnumUtils.parse(column),
      )) {
        skip = true;
      }

      if (value.runtimeType == bool) {
        row.add(document.getReportBool(value: value));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        row.add(document.getReportNumber(value: value));
      } else {
        row.add(document.getReportString(value: value));
      }
    }

    if (!skip) {
      data.add(row);
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) => sortReportTableRows(rowA, rowB, documentReportSettings, selectedColumns));

  return ReportResult(
    allColumns:
        DocumentReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
