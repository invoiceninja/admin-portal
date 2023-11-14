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

enum TaskItemReportFields {
  number,
  id,
  rate,
  calculated_rate,
  start_time,
  end_time,
  duration,
  description,
  item_description,
  invoice,
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

var memoizedTaskItemReport = memo10((
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
    taskItemReport(
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

ReportResult taskItemReport(
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
  BuiltList<TaskItemReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final taskReportSettings = reportSettings.containsKey(kReportTaskItem)
      ? reportSettings[kReportTaskItem]!
      : ReportSettingsEntity();

  final defaultColumns = [
    TaskItemReportFields.number,
    TaskItemReportFields.start_time,
    TaskItemReportFields.end_time,
    TaskItemReportFields.duration,
    TaskItemReportFields.description,
    TaskItemReportFields.client,
    TaskItemReportFields.project,
    TaskItemReportFields.invoice,
    TaskItemReportFields.status,
  ];

  if (taskReportSettings.columns.isNotEmpty) {
    columns = BuiltList(taskReportSettings.columns
        .map((e) => EnumUtils.fromString(TaskItemReportFields.values, e))
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

    for (var taskItem in task.getTaskTimes()) {
      bool skip = false;
      final List<ReportElement> row = [];

      for (var column in columns) {
        dynamic value = '';

        switch (column) {
          case TaskItemReportFields.id:
            value = task.id;
            break;
          case TaskItemReportFields.number:
            value = task.number;
            break;
          case TaskItemReportFields.rate:
            value = task.rate;
            break;
          case TaskItemReportFields.calculated_rate:
            value = taskRateSelector(
              company: userCompany.company,
              project: project,
              client: client,
              task: task,
              group: group,
            );
            break;
          case TaskItemReportFields.start_time:
            if (taskItem.startDate == null) {
              value = '';
            } else {
              final timestamp =
                  (taskItem.startDate!.millisecondsSinceEpoch / 1000).floor();
              value =
                  timestamp > 0 ? convertTimestampToDateString(timestamp) : '';
            }
            break;
          case TaskItemReportFields.end_time:
            if (taskItem.endDate == null) {
              value = '';
            } else {
              final timestamp =
                  (taskItem.endDate!.millisecondsSinceEpoch / 1000).floor();
              value =
                  timestamp > 0 ? convertTimestampToDateString(timestamp) : '';
            }
            break;
          case TaskItemReportFields.description:
            value = task.description;
            break;
          case TaskItemReportFields.item_description:
            value = taskItem.description;
            break;
          case TaskItemReportFields.invoice:
            value = invoice.listDisplayName;
            break;
          case TaskItemReportFields.invoice_date:
            value = invoice.isNew ? '' : invoice.date;
            break;
          case TaskItemReportFields.invoice_due_date:
            value = invoice.isNew ? '' : invoice.dueDate;
            break;
          case TaskItemReportFields.duration:
            value = taskItem.duration.inSeconds;
            break;
          case TaskItemReportFields.project:
            value = projectMap[task.projectId]?.name ?? '';
            break;
          case TaskItemReportFields.client:
            value = clientMap[task.clientId]?.displayName ?? '';
            break;
          case TaskItemReportFields.client_balance:
            value = client.balance;
            break;
          case TaskItemReportFields.client_address1:
            value = client.address1;
            break;
          case TaskItemReportFields.client_address2:
            value = client.address2;
            break;
          case TaskItemReportFields.client_shipping_address1:
            value = client.shippingAddress1;
            break;
          case TaskItemReportFields.client_shipping_address2:
            value = client.shippingAddress2;
            break;
          case TaskItemReportFields.task1:
            value = presentCustomField(
              value: task.customValue1,
              customFieldType: CustomFieldType.task1,
              company: userCompany.company,
            );
            break;
          case TaskItemReportFields.task2:
            value = presentCustomField(
              value: task.customValue2,
              customFieldType: CustomFieldType.task2,
              company: userCompany.company,
            );
            break;
          case TaskItemReportFields.task3:
            value = presentCustomField(
              value: task.customValue3,
              customFieldType: CustomFieldType.task3,
              company: userCompany.company,
            );
            break;
          case TaskItemReportFields.task4:
            value = presentCustomField(
              value: task.customValue4,
              customFieldType: CustomFieldType.task4,
              company: userCompany.company,
            );
            break;
          case TaskItemReportFields.status:
            value = taskStatusMap[task.statusId]?.name ?? '';
            break;
          case TaskItemReportFields.assigned_to:
            value = userMap[task.assignedUserId]?.listDisplayName ?? '';
            break;
          case TaskItemReportFields.created_by:
            value = userMap[task.createdUserId]?.listDisplayName ?? '';
            break;
          case TaskItemReportFields.amount:
            value = taskItem.calculateAmount(
              taskRateSelector(
                company: userCompany.company,
                project: project,
                client: client,
                task: task,
                group: group,
              )!,
            );
            break;
          case TaskItemReportFields.record_state:
            value = AppLocalization.of(navigatorKey.currentContext!)!
                .lookup(task.entityState);
            break;
          case TaskItemReportFields.is_invoiced:
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

        if (column == TaskItemReportFields.duration) {
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
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, taskReportSettings, selectedColumns)!);

  return ReportResult(
    allColumns:
        TaskItemReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
    entities: entities,
  );
}
