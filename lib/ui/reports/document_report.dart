// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:intl/intl.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

enum DocumentReportFields {
  name,
  size,
  width,
  height,
  file_type,
  record_type,
  created_at,
  created_by,
  updated_at,
  private,
}

var memoizedDocumentReport = memo4((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, DocumentEntity> documentMap,
  BuiltMap<String, UserEntity> userMap,
) =>
    documentReport(
      userCompany!,
      reportsUIState,
      documentMap,
      userMap,
    ));

ReportResult documentReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, DocumentEntity> documentMap,
  BuiltMap<String, UserEntity> userMap,
) {
  final List<List<ReportElement>> data = [];
  final List<BaseEntity> entities = [];
  BuiltList<DocumentReportFields> columns;

  final localization =
      AppLocalization(AppLocalization.createLocale(Intl.defaultLocale));
  final reportSettings = userCompany.settings.reportSettings;
  final documentReportSettings = reportSettings.containsKey(kReportDocument)
      ? reportSettings[kReportDocument]!
      : ReportSettingsEntity();

  final defaultColumns = [
    DocumentReportFields.record_type,
    DocumentReportFields.name,
    DocumentReportFields.file_type,
    DocumentReportFields.size,
    DocumentReportFields.width,
    DocumentReportFields.height,
    DocumentReportFields.private,
  ];

  if (documentReportSettings.columns.isNotEmpty) {
    columns = BuiltList(documentReportSettings.columns
        .map((e) => EnumUtils.fromString(DocumentReportFields.values, e))
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  documentMap.values.forEach((document) {
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
        case DocumentReportFields.record_type:
          value = document.parentType;
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
        case DocumentReportFields.private:
          value = !document.isPublic;
          break;
      }

      if (!ReportResult.matchField(
        value: value,
        userCompany: userCompany,
        reportsUIState: reportsUIState,
        column: EnumUtils.parse(column),
        localization: localization,
      )!) {
        skip = true;
      }

      if (value.runtimeType == bool) {
        row.add(document.getReportBool(value: value));
      } else if (value.runtimeType == int) {
        row.add(document.getReportInt(value: value));
      } else if (value.runtimeType == double) {
        row.add(document.getReportDouble(value: value));
      } else if (value.runtimeType == EntityType) {
        row.add(ReportEntityTypeValue(
            entityId: document.parentId,
            entityType: document.parentType,
            value: document.parentType));
      } else {
        row.add(document.getReportString(value: value));
      }
    }

    if (!skip) {
      data.add(row);
      entities.add(document);
    }
  });

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) => sortReportTableRows(
      rowA, rowB, documentReportSettings, selectedColumns)!);

  return ReportResult(
    allColumns:
        DocumentReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
    showTotals: false,
    entities: entities,
  );
}
