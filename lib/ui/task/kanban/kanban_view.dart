// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_selectors.dart';
import 'package:invoiceninja_flutter/ui/task/kanban/kanban_card.dart';
import 'package:invoiceninja_flutter/ui/task/kanban/kanban_status.dart';
import 'package:invoiceninja_flutter/ui/task/kanban/kanban_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class KanbanView extends StatefulWidget {
  const KanbanView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final KanbanVM viewModel;

  @override
  KanbanViewState createState() => KanbanViewState();
}

class KanbanViewState extends State<KanbanView> {
  final _boardViewController = new BoardViewController();

  List<String>? _statuses;
  TaskEntity? _newTask;
  Map<String, List<String>>? _tasks;
  bool isDragging = false;

  @override
  void initState() {
    super.initState();

    _initBoard();

    /*
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      _checkBoard();
    });
    */
  }

  void _initBoard() {
    final viewModel = widget.viewModel;
    final state = viewModel.state;

    _statuses = memoizedSortedActiveTaskStatusIds(
        state.taskStatusState.list, state.taskStatusState.map);

    _tasks = {};

    viewModel.taskList.forEach((taskId) {
      final task = state.taskState.map[taskId]!;
      final status = state.taskStatusState.get(task.statusId);
      final statusId = status.isNew ? '' : status.id;
      if (!_tasks!.containsKey(statusId)) {
        _tasks![statusId] = [];
      }
      _tasks![statusId]!.add(task.id);
    });

    _tasks!.forEach((key, value) {
      _tasks![key]!.sort((taskIdA, taskIdB) {
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

  /*
  void _checkBoard() {
    final viewModel = widget.viewModel;
    final state = viewModel.state;

    final filteredStatusIds = _statuses.where((statusId) {
      return statusId.isNotEmpty || _tasks.containsKey(statusId);
    }).toList();

    bool isCorrect = true;

    filteredStatusIds.forEach((statusId) {
      final status = state.taskStatusState.get(statusId);

      if (status.statusOrder != filteredStatusIds.indexOf(status.id)) {
        isCorrect = false;
      }

      (_tasks[status.id] ?? []).forEach((taskId) {
        final task = state.taskState.get(taskId);

        if (task.statusOrder != _tasks[status.id].indexOf(task.id) ||
            task.statusId != statusId) {
          isCorrect = false;
        }
      });
    });

    if (!isCorrect) {
      _onBoardChanged();
    }
  }
  */

  void _onBoardChanged() {
    final localization = AppLocalization.of(context)!;
    final completer = snackBarCompleter<Null>(localization.updatedTaskStatus);
    completer.future.catchError((Object error) {
      _initBoard();
    });

    widget.viewModel.onBoardChanged(completer, _statuses, _tasks);
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.viewModel.state;
    final color = state.prefState.enableDarkMode
        ? Theme.of(context).cardColor
        : Colors.grey.shade300;

    final filteredStatusIds = _statuses!.where((statusId) {
      return statusId.isNotEmpty || _tasks!.containsKey(statusId);
    }).toList();

    final boardList = filteredStatusIds.map((statusId) {
      final status = state.taskStatusState.get(statusId);
      final hasCorectOrder = statusId.isEmpty ||
          status.statusOrder == filteredStatusIds.indexOf(status.id);

      return BoardList(
        draggable: status.isOld,
        backgroundColor: color,
        headerBackgroundColor: color,
        onDropList: (endIndex, startIndex) {
          if (endIndex == startIndex) {
            return;
          }

          setState(() {
            final status = _statuses![startIndex!];
            _statuses!.removeAt(startIndex);
            _statuses = [
              ..._statuses!.sublist(0, endIndex),
              status,
              ..._statuses!.sublist(endIndex!),
            ];
          });

          _onBoardChanged();
        },
        header: [
          Expanded(
            child: KanbanStatusCard(
              status: status,
              isSaving: state.isSaving,
              isCorrectOrder: hasCorectOrder,
              onSavePressed: (completer, name) {
                final statusOrder = _statuses!.indexOf(statusId);
                widget.viewModel.onSaveStatusPressed(
                    completer, statusId, name, statusOrder);
              },
            ),
          ),
        ],
        footer: Align(
          alignment: Alignment.centerLeft,
          child: _newTask?.statusId == status.id
              ? KanbanTaskCard(
                  task: _newTask,
                  isSaving: state.isSaving,
                  isDragging: isDragging,
                  onSavePressed: (completer, description) {
                    final statusOrder = _tasks![status.id]?.length ?? 0;
                    widget.viewModel.onSaveTaskPressed(
                      completer,
                      _newTask!.id,
                      status.id,
                      description,
                      statusOrder,
                    );
                  },
                  onCancelPressed: () {
                    setState(() {
                      _newTask = null;
                    });
                  },
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 8, top: 2, bottom: 4),
                  child: TextButton(
                    child: Text(AppLocalization.of(context)!.newTask),
                    onPressed: () {
                      setState(() {
                        _newTask = TaskEntity(state: widget.viewModel.state)
                            .rebuild((b) => b..statusId = status.id);
                      });
                    },
                  ),
                ),
        ),
        items: (_tasks![status.id] ?? [])
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
                  : KanbanTaskCard(
                      task: task,
                      isSaving: state.isSaving,
                      isDragging: isDragging,
                      isSelected: (state.uiState.isEditing
                              ? state.taskUIState.editingId
                              : state.taskUIState.selectedId) ==
                          task.id,
                      isCorrectOrder: (task.statusOrder ==
                              _tasks![status.id]!.indexOf(task.id)) &&
                          task.statusId == statusId,
                      onSavePressed: (completer, description) {
                        final statusOrder =
                            _tasks![status.id]!.indexOf(task.id);
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
                            _newTask = null;
                          });
                        }
                      },
                    ),
              onStartDragItem: (listIndex, itemIndex, state) {
                setState(() => isDragging = true);
              },
              /*
              onDragItem: (oldListIndex, oldItemIndex, newListIndex,
                  newItemIndex, state) {
                setState(() => _isDragging = true);
              },
              */
              onDropItem: (
                int? listIndex,
                int? itemIndex,
                int? oldListIndex,
                int? oldItemIndex,
                BoardItemState state,
              ) {
                setState(() => isDragging = false);

                if (listIndex == oldListIndex && itemIndex == oldItemIndex) {
                  return;
                }

                final oldStatusId = _statuses![oldListIndex!];
                final newStatusId = _statuses![listIndex!];
                final taskId = _tasks![status.id]![oldItemIndex!];

                setState(() {
                  if (_tasks!.containsKey(oldStatusId) &&
                      _tasks![oldStatusId]!.contains(taskId)) {
                    _tasks![oldStatusId]!.remove(taskId);
                  }

                  if (!_tasks!.containsKey(newStatusId)) {
                    _tasks![newStatusId] = [];
                  }

                  _tasks![newStatusId] = [
                    ..._tasks![newStatusId]!.sublist(0, itemIndex),
                    taskId,
                    ..._tasks![newStatusId]!.sublist(itemIndex!),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: BoardView(
              boardViewController: _boardViewController,
              lists: boardList,
              dragDelay: 0,
              scrollbar: isDesktop(context),
              bottomPadding: 16,
            ),
          ),
          if (state.isLoading || state.isSaving) LinearProgressIndicator(),
        ],
      ),
    );
  }
}
