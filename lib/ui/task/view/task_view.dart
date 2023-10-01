// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/bottom_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_documents.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_overview.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskView extends StatefulWidget {
  const TaskView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
    required this.tabIndex,
  }) : super(key: key);

  final TaskViewVM viewModel;
  final bool isFilter;
  final int tabIndex;

  @override
  _TaskViewState createState() => new _TaskViewState();
}

class _TaskViewState extends State<TaskView>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();

    final state = widget.viewModel.state;
    _controller = TabController(
        vsync: this,
        length: 2,
        initialIndex: widget.isFilter ? 0 : state.taskUIState.tabIndex);
    _controller!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (widget.isFilter) {
      return;
    }

    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateTaskTab(tabIndex: _controller!.index));
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.tabIndex != widget.tabIndex) {
      _controller!.index = widget.tabIndex;
    }
  }

  @override
  void dispose() {
    _controller!.removeListener(_onTabChanged);
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final task = viewModel.task;
    final localization = AppLocalization.of(context);
    final documents = task.documents;
    final state = viewModel.state;
    final company = state.company;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: task,
      isEditable: !state.company.invoiceTaskLock || !task.isInvoiced,
      appBarBottom: company.isModuleEnabled(EntityType.document)
          ? TabBar(
              controller: _controller,
              isScrollable: false,
              tabs: [
                Tab(
                  text: localization!.overview,
                ),
                Tab(
                  text: documents.isEmpty
                      ? localization.documents
                      : '${localization.documents} (${documents.length})',
                ),
              ],
            )
          : null,
      body: Builder(builder: (context) {
        return Column(
          children: <Widget>[
            Expanded(
              child: company.isModuleEnabled(EntityType.document)
                  ? TabBarView(
                      controller: _controller,
                      children: <Widget>[
                        RefreshIndicator(
                          onRefresh: () => viewModel.onRefreshed(context),
                          child: TaskOverview(
                            viewModel: viewModel,
                            isFilter: widget.isFilter,
                          ),
                        ),
                        RefreshIndicator(
                          onRefresh: () => viewModel.onRefreshed(context),
                          child: TaskViewDocuments(
                            viewModel: viewModel,
                            key: ValueKey(viewModel.task.id),
                          ),
                        ),
                      ],
                    )
                  : RefreshIndicator(
                      onRefresh: () => viewModel.onRefreshed(context),
                      child: TaskOverview(
                        viewModel: viewModel,
                        isFilter: widget.isFilter,
                      ),
                    ),
            ),
            BottomButtons(
              entity: task,
              action1: task.isRunning
                  ? EntityAction.stop
                  : task.getTaskTimes().isEmpty
                      ? EntityAction.start
                      : EntityAction.resume,
              action2: task.isInvoiced
                  ? EntityAction.archive
                  : EntityAction.invoiceTask,
              action1Enabled: !task.isInvoiced,
            ),
          ],
        );
      }),
    );
  }
}
