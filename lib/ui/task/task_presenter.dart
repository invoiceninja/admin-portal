import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskPresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity userCompany) {
    return [
      TaskFields.status,
      TaskFields.client,
      TaskFields.project,
      TaskFields.description,
      TaskFields.duration,
      EntityFields.state,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity userCompany) {
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
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final localization = AppLocalization.of(context);
    final task = entity as TaskEntity;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    switch (field) {
      case TaskFields.status:
        return EntityStatusChip(entity: task);
      case TaskFields.client:
        return Text(state.clientState.map[task.clientId]?.displayName ?? '');
      case TaskFields.rate:
        return Text(formatNumber(task.rate, context, clientId: task.clientId));
      case TaskFields.calculatedRate:
        final client = state.clientState.get(task.clientId);
        final rate = taskRateSelector(
          task: task,
          client: client,
          company: state.company,
          project: state.projectState.get(task.projectId),
          group: state.groupState.get(client.groupId),
        );
        return Text(formatNumber(rate, context, clientId: task.clientId));
      case TaskFields.project:
        return Text(state.projectState.map[task.projectId]?.name ?? '');
      case TaskFields.description:
        return Text(task.description);
      case TaskFields.duration:
        return Text(formatDuration(task.calculateDuration()));
      case TaskFields.number:
        return Text(task.number.toString());
      case TaskFields.invoice:
        return Text(
            state.invoiceState.map[task.invoiceId]?.listDisplayName ?? '');
      case TaskFields.timeLog:
        final notes = <String>[];
        task
            .getTaskTimes()
            .where((time) => time.startDate != null && time.endDate != null)
            .forEach((time) {
          final start = formatDate(time.startDate.toIso8601String(), context,
              showTime: true, showDate: true);
          final end = formatDate(time.endDate.toIso8601String(), context,
              showTime: true, showDate: false);
          notes.add('$start - $end');
        });
        return Text(notes.join('\n'));
      case TaskFields.isRunning:
        return Text(task.isRunning ? localization.yes : localization.no);
      case TaskFields.isInvoiced:
        return Text(task.isInvoiced ? localization.yes : localization.no);
      case TaskFields.customValue1:
        return Text(presentCustomField(task.customValue1));
      case TaskFields.customValue2:
        return Text(presentCustomField(task.customValue2));
      case TaskFields.customValue3:
        return Text(presentCustomField(task.customValue3));
      case TaskFields.customValue4:
        return Text(presentCustomField(task.customValue4));
      case TaskFields.documents:
        return Text('${task.documents.length}');
    }

    return super.getField(field: field, context: context);
  }
}
