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
  invoice_amount,
  invoice_date,
  invoice_due_date,
  client,
  client_balance,
  client_address1,
  client_address2,
  client_shipping_address1,
  client_shipping_address2,
  vendor,
  vendor_city,
  vendor_state,
  vendor_country,
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
    final vendor = vendorMap[task.vendorId];
    final invoice = invoiceMap[task.invoiceId];

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
          value = invoice;
          break;
        case TaskReportFields.invoice_amount:
          value = invoice.amount;
          break;
        case TaskReportFields.invoice_date:
          value = invoice.date;
          break;
        case TaskReportFields.invoice_due_date:
          value = invoice.dueDate;
          break;
        case TaskReportFields.client:
          value = clientMap[task.clientId];
          break;
        case TaskReportFields.client_balance:
          value = client.balance;
          break;
        case TaskReportFields.client_address1:
          value = client.address1;
          break;
        case TaskReportFields.client_address2:
          value = client.address2;
          break;
        case TaskReportFields.client_shipping_address1:
          value = client.shippingAddress1;
          break;
        case TaskReportFields.client_shipping_address2:
          value = client.shippingAddress2;
          break;
        case TaskReportFields.vendor:
          value = vendorMap[task.vendorId];
          break;
        case TaskReportFields.vendor_city:
          value = vendor?.city;
          break;
        case TaskReportFields.vendor_state:
          value = vendor?.state;
          break;
        case TaskReportFields.vendor_country:
          value = staticState.countryMap[vendor?.countryId];
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

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, taskReportSettings, selectedColumns));

  return ReportResult(
    allColumns: TaskReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
