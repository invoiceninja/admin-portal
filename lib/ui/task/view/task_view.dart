import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/bottom_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_documents.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_overview.dart';
import 'package:invoiceninja_flutter/ui/task/view/task_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskView extends StatefulWidget {
  const TaskView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
    @required this.tabIndex,
  }) : super(key: key);

  final TaskViewVM viewModel;
  final bool isFilter;
  final int tabIndex;

  @override
  _TaskViewState createState() => new _TaskViewState();
}

class _TaskViewState extends State<TaskView>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();

    final state = widget.viewModel.state;
    _controller = TabController(
        vsync: this,
        length: 2,
        initialIndex: widget.isFilter ? 0 : state.taskUIState.tabIndex);
    _controller.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (widget.isFilter) {
      return;
    }

    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateTaskTab(tabIndex: _controller.index));
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.tabIndex != widget.tabIndex) {
      _controller.index = widget.tabIndex;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTabChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final task = viewModel.task;
    final localization = AppLocalization.of(context);
    final documents = task.documents;
    final state = viewModel.state;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: task,
      showClearSelection: state.prefState.showKanban,
      appBarBottom: TabBar(
        controller: _controller,
        isScrollable: false,
        tabs: [
          Tab(
            text: localization.overview,
          ),
          Tab(
            text: documents.isEmpty
                ? localization.documents
                : '${localization.documents} (${documents.length})',
          ),
        ],
      ),
      body: Builder(builder: (context) {
        return Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
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
      floatingActionButton: Builder(builder: (BuildContext context) {
        return task.isInvoiced || task.isDeleted
            ? SizedBox()
            : FloatingActionButton(
                heroTag: 'task_view_fab',
                backgroundColor: Theme.of(context).primaryColorDark,
                onPressed: () => viewModel.onFabPressed(context),
                child: Icon(
                  task.isRunning ? Icons.stop : Icons.play_arrow,
                  color: Colors.white,
                ),
                tooltip:
                    task.isRunning ? localization.stop : localization.start,
              );
      }),
    );
  }
}
