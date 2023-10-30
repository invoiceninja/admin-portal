// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_selectors.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

enum TaskReportFields {
  number,
  id,
  rate,
  calculated_rate,
  start_time,
  end_time,
  duration,
  description,
  invoice,
  invoice_amount,
  invoice_date,
  invoice_due_date,
  project,
  client,
  client_balance,
  client_address1,
  client_address2,
  client_shipping_address1,
  client_shipping_address2,
  task1,
  task2,
  task3,
  task4,
  status,
  assigned_to,
  created_by,
  amount,
  record_state,
  is_invoiced,
}

var memoizedTaskReport = memo10((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, TaskEntity> taskMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, GroupEntity> groupMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String?, TaskStatusEntity?> taskStatusMap,
  BuiltMap<String, UserEntity> userMap,
  BuiltMap<String, ProjectEntity> projectMap,
  StaticState staticState,
) =>
    taskReport(
      userCompany!,
      reportsUIState,
      taskMap,
      invoiceMap,
      groupMap,
      clientMap,
      taskStatusMap,
      userMap,
      projectMap,
      staticState,
    ));

ReportResult taskReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, TaskEntity> taskMap,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, GroupEntity> groupMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String?, TaskStatusEntity?> taskStatusMap,
  BuiltMap<String, UserEntity> userMap,
  BuiltMap<String, ProjectEntity> projectMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  final List<BaseEntity> entities = [];
  BuiltList<TaskReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final taskReportSettings = reportSettings.containsKey(kReportTask)
      ? reportSettings[kReportTask]!
      : ReportSettingsEntity();

  final defaultColumns = [
    TaskReportFields.start_time,
    TaskReportFields.end_time,
    TaskReportFields.duration,
    TaskReportFields.description,
    TaskReportFields.client,
    TaskReportFields.project,
    TaskReportFields.invoice,
    TaskReportFields.status,
  ];

  if (taskReportSettings.columns.isNotEmpty) {
    columns = BuiltList(taskReportSettings.columns
        .map((e) => EnumUtils.fromString(TaskReportFields.values, e))
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var taskId in taskMap.keys) {
    final task = taskMap[taskId]!;
    final client = clientMap[task.clientId] ?? ClientEntity();
    final invoice = invoiceMap[task.invoiceId] ?? InvoiceEntity();
    final project = projectMap[task.projectId] ?? ProjectEntity();
    final group = groupMap[client.groupId] ?? GroupEntity();

    if ((task.isDeleted! && !userCompany.company.reportIncludeDeleted) ||
        client.isDeleted!) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case TaskReportFields.id:
          value = task.id;
          break;
        case TaskReportFields.number:
          value = task.number;
          break;
        case TaskReportFields.rate:
          value = task.rate;
          break;
        case TaskReportFields.calculated_rate:
          value = taskRateSelector(
            company: userCompany.company,
            project: project,
            client: client,
            task: task,
            group: group,
          );
          break;
        case TaskReportFields.start_time:
          final timestamp = task.startTimestamp;
          value = (timestamp ?? 0) > 0
              ? convertTimestampToDateString(timestamp)
              : '';
          break;
        case TaskReportFields.end_time:
          final timestamp = task.endTimestamp;
          value = (timestamp ?? 0) > 0
              ? convertTimestampToDateString(timestamp)
              : '';
          break;
        case TaskReportFields.description:
          value = task.description;
          break;
        case TaskReportFields.invoice:
          value = invoice.listDisplayName;
          break;
        case TaskReportFields.invoice_amount:
          value = invoice.amount;
          break;
        case TaskReportFields.invoice_date:
          value = invoice.isNew ? '' : invoice.date;
          break;
        case TaskReportFields.invoice_due_date:
          value = invoice.isNew ? '' : invoice.dueDate;
          break;
        case TaskReportFields.duration:
          value = task.calculateDuration().inSeconds;
          break;
        case TaskReportFields.project:
          value = projectMap[task.projectId]?.name ?? '';
          break;
        case TaskReportFields.client:
          value = clientMap[task.clientId]?.displayName ?? '';
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
        case TaskReportFields.task1:
          value = presentCustomField(
            value: task.customValue1,
            customFieldType: CustomFieldType.task1,
            company: userCompany.company,
          );
          break;
        case TaskReportFields.task2:
          value = presentCustomField(
            value: task.customValue2,
            customFieldType: CustomFieldType.task2,
            company: userCompany.company,
          );
          break;
        case TaskReportFields.task3:
          value = presentCustomField(
            value: task.customValue3,
            customFieldType: CustomFieldType.task3,
            company: userCompany.company,
          );
          break;
        case TaskReportFields.task4:
          value = presentCustomField(
            value: task.customValue4,
            customFieldType: CustomFieldType.task4,
            company: userCompany.company,
          );
          break;
        case TaskReportFields.status:
          value = taskStatusMap[task.statusId]?.name ?? '';
          break;
        case TaskReportFields.assigned_to:
          value = userMap[task.assignedUserId]?.listDisplayName ?? '';
          break;
        case TaskReportFields.created_by:
          value = userMap[task.createdUserId]?.listDisplayName ?? '';
          break;
        case TaskReportFields.amount:
          value = task.calculateAmount(
            taskRateSelector(
              company: userCompany.company,
              project: project,
              client: client,
              task: task,
              group: group,
            )!,
          );
          break;
        case TaskReportFields.record_state:
          value = AppLocalization.of(navigatorKey.currentContext!)!
              .lookup(task.entityState);
          break;
        case TaskReportFields.is_invoiced:
          value = task.isInvoiced;
          break;
      }

      if (!ReportResult.matchField(
        value: value,
        userCompany: userCompany,
        reportsUIState: reportsUIState,
        column: EnumUtils.parse(column),
      )!) {
        skip = true;
      }

      if (column == TaskReportFields.duration) {
        row.add(task.getReportDuration(
            value: value, currencyId: client.currencyId));
      } else if (value.runtimeType == bool) {
        row.add(task.getReportBool(value: value));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        row.add(task.getReportDouble(
            value: value, currencyId: client.settings.currencyId));
      } else {
        row.add(task.getReportString(value: value));
      }
    }

    if (!skip) {
      data.add(row);
      entities.add(task);
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, taskReportSettings, selectedColumns)!);

  return ReportResult(
    allColumns: TaskReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
    entities: entities,
  );
}
