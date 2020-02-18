import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:memoize/memoize.dart';

enum TaskReportFields {
  start_date,
  end_date,
  description,
  invoice,
  client,
  vendor,
  custom_value1,
  custom_value2,
  custom_value3,
  custom_value4,
}

var memoizedTaskReport = memo8((
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, TaskEntity> taskMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    taskReport(userCompany, reportsUIState, taskMap, invoiceMap, clientMap,
        vendorMap, userMap, staticState));

ReportResult taskReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, TaskEntity> taskMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  BuiltList<TaskReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final taskReportSettings =
      reportSettings != null && reportSettings.containsKey(kReportTask)
          ? reportSettings[kReportTask]
          : ReportSettingsEntity();

  final defaultColumns = [
    TaskReportFields.start_date,
    TaskReportFields.end_date,
    TaskReportFields.description,
    TaskReportFields.client,
    TaskReportFields.invoice,
    TaskReportFields.vendor,
  ];

  if (taskReportSettings.columns.isNotEmpty) {
    columns = BuiltList(taskReportSettings.columns
        .map((e) => EnumUtils.fromString(TaskReportFields.values, e))
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var taskId in taskMap.keys) {
    final task = taskMap[taskId];
    final client = clientMap[task.clientId];

    if (task.isDeleted) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case TaskReportFields.start_date:
          // TODO: Check
          value = task.taskTimes[0]?.startDate;
          break;
        case TaskReportFields.end_date:
          // TODO: Check
          value = task.taskTimes[0]?.endDate;
          break;
        case TaskReportFields.description:
          value = task.description;
          break;
        case TaskReportFields.invoice:
          value = invoiceMap[task.invoiceId];
          break;
        case TaskReportFields.client:
          value = clientMap[task.clientId];
          break;
        case TaskReportFields.vendor:
          value = vendorMap[task.vendorId];
          break;
        case TaskReportFields.custom_value1:
          value = task.customValue1;
          break;
        case TaskReportFields.custom_value2:
          value = task.customValue2;
          break;
        case TaskReportFields.custom_value3:
          value = task.customValue3;
          break;
        case TaskReportFields.custom_value4:
          value = task.customValue4;
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
        row.add(task.getReportBool(value: value));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        row.add(task.getReportNumber(
            value: value, currencyId: client.settings.currencyId));
      } else {
        row.add(task.getReportString(value: value));
      }
    }

    if (!skip) {
      data.add(row);
    }
  }

  data.sort((rowA, rowB) {
    if (rowA.length <= taskReportSettings.sortIndex ||
        rowB.length <= taskReportSettings.sortIndex) {
      return 0;
    }

    final String valueA = rowA[taskReportSettings.sortIndex].value;
    final String valueB = rowB[taskReportSettings.sortIndex].value;

    if (taskReportSettings.sortAscending) {
      return valueA.compareTo(valueB);
    } else {
      return valueB.compareTo(valueA);
    }
  });

  return ReportResult(
    allColumns: TaskReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: columns.map((item) => EnumUtils.parse(item)).toList(),
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
