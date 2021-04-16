import 'dart:async';
import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/app_text_button.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/task/kanban_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:timeago/timeago.dart' as timeago;

class KanbanView extends StatefulWidget {
  const KanbanView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final KanbanVM viewModel;

  @override
  _KanbanViewState createState() => _KanbanViewState();
}

class _KanbanViewState extends State<KanbanView> {
  final _boardViewController = new BoardViewController();

  List<String> _statuses;
  Map<String, List<String>> _tasks;

  @override
  void initState() {
    super.initState();
    _initBoard();
  }

  void _initBoard() {
    print('## INIT BOARD');
    final viewModel = widget.viewModel;
    final state = viewModel.state;

    _statuses = state.taskStatusState.list
        .where((statusId) => state.taskStatusState.get(statusId).isActive)
        .toList();

    _statuses.sort((statusIdA, statusIdB) {
      final statusA = state.taskStatusState.get(statusIdA);
      final statusB = state.taskStatusState.get(statusIdB);
      if (statusA.statusOrder == statusB.statusOrder) {
        return statusB.updatedAt.compareTo(statusA.updatedAt);
      } else {
        return (statusA.statusOrder ?? 99999)
            .compareTo(statusB.statusOrder ?? 99999);
      }
    });

    _tasks = {};
    viewModel.taskList.forEach((taskId) {
      final task = state.taskState.map[taskId];
      if (task.statusId.isNotEmpty) {
        final status = state.taskStatusState.get(task.statusId);
        if (!_tasks.containsKey(status.id)) {
          _tasks[status.id] = [];
        }
        _tasks[status.id].add(task.id);
      }
    });

    _tasks.forEach((key, value) {
      _tasks[key].sort((taskIdA, taskIdB) {
        final taskA = state.taskState.get(taskIdA);
        final taskB = state.taskState.get(taskIdB);
        if (taskA.statusOrder == taskB.statusOrder) {
          return taskB.updatedAt.compareTo(taskA.updatedAt);
        } else {
          return (taskA.statusOrder ?? 99999)
              .compareTo(taskB.statusOrder ?? 99999);
        }
      });
    });
  }

  void _onBoardChanged() {
    final localization = AppLocalization.of(context);
    final completer =
        snackBarCompleter<Null>(context, localization.updatedTaskStatus);
    completer.future.catchError((Object error) {
      _initBoard();
    });

    widget.viewModel.onBoardChanged(completer, _statuses, _tasks);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = widget.viewModel.state;
    final color = state.prefState.enableDarkMode
        ? Theme.of(context).cardColor
        : Colors.grey.shade300;

    final boardList = _statuses.map((statusId) {
      final status = state.taskStatusState.get(statusId);
      return BoardList(
        backgroundColor: color,
        headerBackgroundColor: color,
        onDropList: (endIndex, startIndex) {
          if (endIndex == startIndex) {
            return;
          }

          setState(() {
            final status = _statuses[startIndex];
            _statuses.removeAt(startIndex);
            _statuses = [
              ..._statuses.sublist(0, endIndex),
              status,
              ..._statuses.sublist(endIndex),
            ];
          });

          _onBoardChanged();
        },
        header: [
          Expanded(
            child: _StatusCard(
              status: status,
              onSavePressed: (completer, name) {
                final statusOrder = _statuses.indexOf(statusId);
                widget.viewModel.onSaveStatusPressed(
                    completer, statusId, name, statusOrder);
              },
              onCancelPressed: () {
                if (status.isNew) {
                  _statuses.remove(status.id);
                }
              },
            ),
          ),
        ],
        footer: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: TextButton(
              child: Text(AppLocalization.of(context).newTask),
              onPressed: () {
                final task = TaskEntity(state: widget.viewModel.state)
                    .rebuild((b) => b..statusId = status.id);
                setState(() {
                  if (!_tasks.containsKey(status.id)) {
                    _tasks[status.id] = [];
                  }
                  _tasks[status.id].add(task.id);
                });
              },
            ),
          ),
        ),
        items: (_tasks[status.id] ?? [])
            .map((taskId) => widget.viewModel.state.taskState.get(taskId))
            .map(
          (task) {
            final isVisible =
                widget.viewModel.filteredTaskList.contains(task.id) ||
                    task.isNew;
            return BoardItem(
              draggable: task.isOld,
              item: !isVisible
                  ? SizedBox()
                  : _TaskCard(
                      task: task,
                      onSavePressed: (completer, description) {
                        final statusOrder = _tasks[status.id].indexOf(task.id);
                        widget.viewModel.onSaveTaskPressed(
                          completer,
                          task.id,
                          status.id,
                          description,
                          statusOrder,
                        );
                      },
                      onCancelPressed: () {
                        if (task.isNew) {
                          setState(() {
                            _tasks[status.id].remove(task.id);
                          });
                        }
                      },
                    ),
              onDropItem: (
                int listIndex,
                int itemIndex,
                int oldListIndex,
                int oldItemIndex,
                BoardItemState state,
              ) {
                if (listIndex == oldListIndex && itemIndex == oldItemIndex) {
                  return;
                }

                final oldStatusId = _statuses[oldListIndex];
                final newStatusId = _statuses[listIndex];
                final taskId = _tasks[status.id][oldItemIndex];

                setState(() {
                  if (_tasks.containsKey(oldStatusId) &&
                      _tasks[oldStatusId].contains(taskId)) {
                    _tasks[oldStatusId].remove(taskId);
                  }

                  if (!_tasks.containsKey(newStatusId)) {
                    _tasks[newStatusId] = [];
                  }

                  _tasks[newStatusId] = [
                    ..._tasks[newStatusId].sublist(0, itemIndex),
                    taskId,
                    ..._tasks[newStatusId].sublist(itemIndex),
                  ];
                });

                _onBoardChanged();
              },
            );
          },
        ).toList(),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          BoardView(
            boardViewController: _boardViewController,
            lists: boardList,
            dragDelay: 1,
          ),
          if (state.isLoading || state.isSaving) LinearProgressIndicator(),
        ],
      ),
    );
  }
}

class _TaskCard extends StatefulWidget {
  const _TaskCard({
    @required this.task,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });
  final TaskEntity task;
  final Function(Completer<TaskEntity>, String) onSavePressed;
  final Function() onCancelPressed;

  @override
  __TaskCardState createState() => __TaskCardState();
}

class __TaskCardState extends State<_TaskCard> {
  bool _isEditing = false;
  String _description = '';

  @override
  void initState() {
    super.initState();

    final task = widget.task;
    _description = task.description;
    _isEditing = task.isNew;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    if (_isEditing) {
      return Card(
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              DecoratedFormField(
                autofocus: true,
                initialValue: _description,
                minLines: 4,
                maxLines: 4,
                onChanged: (value) => _description = value,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppTextButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                        if (widget.task.isNew) {
                          widget.onCancelPressed();
                        }
                      });
                    },
                    label: localization.cancel,
                  ),
                  if (widget.task.isOld)
                    AppTextButton(
                      onPressed: () {
                        viewEntity(
                            appContext: context.getAppContext(),
                            entity: widget.task);
                      },
                      label: localization.view,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        final completer = snackBarCompleter<TaskEntity>(
                            context, localization.updatedTask);
                        completer.future.then((value) {
                          setState(() {
                            _isEditing = false;
                          });
                        });
                        widget.onSavePressed(completer, _description.trim());
                      },
                      child: Text(localization.save),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

    return InkWell(
      child: Card(
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
              '${widget.task.statusOrder} - ${widget.task.id} - ${timeago.format(DateTime.fromMillisecondsSinceEpoch(widget.task.updatedAt * 1000))}'),
        ),
      ),
      onTap: () {
        setState(() {
          _isEditing = true;
        });
      },
    );
  }
}

class _StatusCard extends StatefulWidget {
  const _StatusCard({
    @required this.status,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });
  final TaskStatusEntity status;
  final Function(Completer<TaskStatusEntity>, String) onSavePressed;
  final Function() onCancelPressed;

  @override
  __StatusCardState createState() => __StatusCardState();
}

class __StatusCardState extends State<_StatusCard> {
  bool _isEditing = false;
  String _name = '';

  @override
  void initState() {
    super.initState();

    final status = widget.status;
    _name = status.name;
    _isEditing = status.isNew;
  }

  void _onSavePressed() {
    final localization = AppLocalization.of(context);
    final completer = snackBarCompleter<TaskStatusEntity>(
        context, localization.updatedTaskStatus);
    completer.future.then((value) {
      setState(() {
        _isEditing = false;
      });
    });

    widget.onSavePressed(completer, _name.trim());
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final status = widget.status;

    if (_isEditing) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            DecoratedFormField(
              autofocus: true,
              initialValue: _name,
              minLines: 1,
              maxLines: 1,
              onChanged: (value) => _name = value,
              onSavePressed: (context) => _onSavePressed(),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppTextButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = false;
                      if (widget.status.isNew) {
                        widget.onCancelPressed();
                      }
                    });
                  },
                  label: localization.cancel,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: ElevatedButton(
                    child: Text(localization.save),
                    onPressed: _onSavePressed,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
              '${status.statusOrder} - ${status.name} - ${timeago.format(DateTime.fromMillisecondsSinceEpoch(status.updatedAt * 1000))}'),
        ),
      ),
      onTap: () {
        setState(() {
          _isEditing = true;
        });
      },
    );
  }
}
