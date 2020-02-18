import 'dart:math';

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
          value = invoiceMap[document.invoiceId].listDisplayName;
          break;
        case DocumentReportFields.expense:
          value = expenseMap[document.expenseId].listDisplayName;
          break;
        case DocumentReportFields.project:
          value = projectMap[document.projectId].listDisplayName;
          break;
        case DocumentReportFields.vendor:
          value = vendorMap[document.vendorId].listDisplayName;
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

  data.sort((rowA, rowB) {
    if (rowA.length <= documentReportSettings.sortIndex ||
        rowB.length <= documentReportSettings.sortIndex) {
      return 0;
    }

    final String valueA = rowA[documentReportSettings.sortIndex].value;
    final String valueB = rowB[documentReportSettings.sortIndex].value;

    if (documentReportSettings.sortAscending) {
      return valueA.compareTo(valueB);
    } else {
      return valueB.compareTo(valueA);
    }
  });

  return ReportResult(
    allColumns:
        DocumentReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: columns.map((item) => EnumUtils.parse(item)).toList(),
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
