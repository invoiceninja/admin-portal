// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/task_status/view/task_status_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskStatusView extends StatefulWidget {
  const TaskStatusView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
  }) : super(key: key);

  final TaskStatusViewVM viewModel;
  final bool isFilter;

  @override
  _TaskStatusViewState createState() => new _TaskStatusViewState();
}

class _TaskStatusViewState extends State<TaskStatusView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final taskStatus = viewModel.taskStatus;
    final localization = AppLocalization.of(context)!;
    final amount = memoizedCalculateTaskStatusAmount(
        taskStatus.id, viewModel.state.taskState.map);

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: taskStatus,
      onBackPressed: () => viewModel.onBackPressed(),
      body: ScrollableListView(
        children: <Widget>[
          EntityHeader(
              entity: taskStatus,
              label: localization.total,
              value: formatDuration(Duration(seconds: amount))),
          ListDivider(),
          EntitiesListTile(
            entity: taskStatus,
            isFilter: widget.isFilter,
            entityType: EntityType.task,
            title: localization.tasks,
            subtitle: memoizedTaskStatsForTaskStatus(
                    taskStatus.id, state.taskState.map)
                .present(localization.active, localization.archived),
          ),
        ],
      ),
    );
  }
}
