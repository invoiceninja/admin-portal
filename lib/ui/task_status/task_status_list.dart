// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/task_status/task_status_list_item.dart';
import 'package:invoiceninja_flutter/ui/task_status/task_status_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskStatusList extends StatefulWidget {
  const TaskStatusList({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final TaskStatusListVM viewModel;

  @override
  _TaskStatusListState createState() => _TaskStatusListState();
}

class _TaskStatusListState extends State<TaskStatusList> {
  // TODO remove this https://github.com/flutter/flutter/issues/71946
  ScrollController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final listUIState = state.uiState.taskStatusUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final viewModel = widget.viewModel;

    if (!viewModel.state.isLoaded) {
      return LoadingIndicator();
    }

    if (viewModel.taskStatusList.isEmpty) {
      return Center(
          child: HelpText(AppLocalization.of(context)!.noRecordsFound));
    }

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        if (state.isSaving) LinearProgressIndicator(),
        RefreshIndicator(
          onRefresh: () => widget.viewModel.onRefreshed(context),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ReorderableListView(
              scrollController: _controller,
              onReorder: (oldIndex, newIndex) {
                // https://stackoverflow.com/a/54164333/497368
                // These two lines are workarounds for ReorderableListView problems
                if (newIndex > widget.viewModel.taskStatusList.length) {
                  newIndex = widget.viewModel.taskStatusList.length;
                }

                //if (oldIndex < newIndex) {
                //  newIndex--;
                //}

                widget.viewModel.onSortChanged(oldIndex, newIndex);
              },
              children: viewModel.taskStatusList.map((taskStatusId) {
                final taskStatus = viewModel.taskStatusMap[taskStatusId];
                return TaskStatusListItem(
                    key: ValueKey('__task_status_$taskStatusId'),
                    user: state.userCompany.user,
                    filter: viewModel.filter,
                    taskStatus: taskStatus,
                    /*
                  onRemovePressed: widget.viewModel.state.settingsUIState.isFiltered
                      ? () => widget.viewModel.onRemovePressed(companyGatewayId)
                      : null,
                      */
                    isChecked: isInMultiselect &&
                        listUIState.isSelected(taskStatus!.id));
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
