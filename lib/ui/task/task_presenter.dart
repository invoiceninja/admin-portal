// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/link_text.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskPresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity? userCompany) {
    return [
      TaskFields.status,
      TaskFields.number,
      TaskFields.client,
      TaskFields.project,
      TaskFields.description,
      TaskFields.duration,
      EntityFields.state,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity? userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      TaskFields.number,
      TaskFields.isInvoiced,
      TaskFields.rate,
      TaskFields.calculatedRate,
      TaskFields.invoice,
      TaskFields.client,
      TaskFields.project,
      TaskFields.timeLog,
      TaskFields.isRunning,
      TaskFields.customValue1,
      TaskFields.customValue2,
      TaskFields.customValue3,
      TaskFields.customValue4,
      TaskFields.documents,
      TaskFields.date,
      TaskFields.amount,
    ];
  }

  @override
  Widget getField({String? field, required BuildContext context}) {
    final localization = AppLocalization.of(context);
    final task = entity as TaskEntity;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final client = state.clientState.get(task.clientId);

    switch (field) {
      case TaskFields.status:
        return EntityStatusChip(entity: task, showState: true);
      case TaskFields.client:
        return LinkTextRelatedEntity(entity: client, relation: task);
      case TaskFields.rate:
        return Text(formatNumber(task.rate, context, clientId: task.clientId)!);
      case TaskFields.calculatedRate:
        final rate = taskRateSelector(
          task: task,
          client: client,
          company: state.company,
          project: state.projectState.get(task.projectId),
          group: state.groupState.get(client.groupId),
        );
        return Text(formatNumber(rate, context, clientId: task.clientId)!);
      case TaskFields.project:
        final project = state.projectState.get(task.projectId);
        return LinkTextRelatedEntity(entity: project, relation: task);
      case TaskFields.description:
        return TableTooltip(message: task.description);
      case TaskFields.duration:
        return Text(formatDuration(task.calculateDuration()));
      case TaskFields.number:
        return Text(task.number.toString());
      case TaskFields.invoice:
        return Text(
            state.invoiceState.map[task.invoiceId]?.listDisplayName ?? '');
      case TaskFields.date:
        final taskTimes = task.getTaskTimes();
        final taskTime = taskTimes.isEmpty ? null : taskTimes.first;
        return Text(taskTime == null
            ? ''
            : formatDate(taskTime.startDate!.toIso8601String(), context));
      case TaskFields.timeLog:
        final notes = <String>[];
        task
            .getTaskTimes()
            .where((time) => time.startDate != null && time.endDate != null)
            .forEach((time) {
          final start = formatDate(time.startDate!.toIso8601String(), context,
              showTime: true, showDate: true);
          final end = formatDate(time.endDate!.toIso8601String(), context,
              showTime: true, showDate: false);
          notes.add('$start - $end');
        });
        return Text(notes.join('\n'));
      case TaskFields.isRunning:
        return Text(task.isRunning ? localization!.yes : localization!.no);
      case TaskFields.isInvoiced:
        return Text(task.isInvoiced ? localization!.yes : localization!.no);
      case TaskFields.customValue1:
        return Text(presentCustomField(context, task.customValue1)!);
      case TaskFields.customValue2:
        return Text(presentCustomField(context, task.customValue2)!);
      case TaskFields.customValue3:
        return Text(presentCustomField(context, task.customValue3)!);
      case TaskFields.customValue4:
        return Text(presentCustomField(context, task.customValue4)!);
      case TaskFields.documents:
        return Text('${task.documents.length}');
      case TaskFields.amount:
        return Text(formatNumber(
          task.calculateAmount(
            taskRateSelector(
              company: state.company,
              project: state.projectState.map[task.projectId],
              client: state.clientState.map[task.clientId],
              task: task,
              group: state.groupState.map[client.groupId],
            )!,
          ),
          context,
          clientId: client.id,
        )!);
    }

    return super.getField(field: field, context: context);
  }
}
