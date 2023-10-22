// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/app_text_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/live_text.dart';
import 'package:invoiceninja_flutter/ui/task/kanban/kanban_view.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class KanbanTaskCard extends StatefulWidget {
  const KanbanTaskCard({
    required this.task,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.isDragging,
    required this.isSaving,
    this.isCorrectOrder = true,
    this.isSelected = false,
  });

  final TaskEntity? task;
  final Function(Completer<TaskEntity>, String) onSavePressed;
  final Function() onCancelPressed;
  final bool isCorrectOrder;
  final bool isDragging;
  final bool isSaving;
  final bool isSelected;

  @override
  _KanbanTaskCardState createState() => _KanbanTaskCardState();
}

class _KanbanTaskCardState extends State<KanbanTaskCard> {
  bool _isEditing = false;
  bool _isHovered = false;
  String _description = '';

  @override
  void initState() {
    super.initState();

    final task = widget.task!;
    _description = task.description;
    _isEditing = task.isNew;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final task = widget.task!;
    final project = state.projectState.get(task.projectId);
    final client = state.clientState.get(task.clientId);
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;

    var color = Colors.grey;
    if (task.projectId.isNotEmpty) {
      final projectIndex = state.projectState.list.indexOf(task.projectId);
      color = getColorByIndex(projectIndex) as MaterialColor;
    }

    final isDragging =
        context.findAncestorStateOfType<KanbanViewState>()!.isDragging;

    if (_isEditing && !isDragging) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
          child: Column(
            children: [
              DecoratedFormField(
                autofocus: true,
                initialValue: _description,
                minLines: 2,
                maxLines: 10,
                onChanged: (value) => _description = value,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppTextButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                        if (task.isNew) {
                          widget.onCancelPressed();
                        }
                      });
                    },
                    label: localization!.cancel,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ElevatedButton(
                      onPressed: widget.isSaving
                          ? null
                          : () {
                              final completer = snackBarCompleter<TaskEntity>(
                                  localization.updatedTask);
                              completer.future.then((value) {
                                setState(() {
                                  _isEditing = false;
                                });
                              });
                              widget.onSavePressed(
                                  completer, _description.trim());
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

    final startLabel = task.isRunning
        ? localization!.stop
        : task.getTaskTimes().isEmpty
            ? localization!.start
            : localization!.resume;

    return MouseRegion(
      onHover: (event) {
        if (state.prefState.isDesktop) {
          setState(() => _isHovered = true);
        }
      },
      onExit: (event) => setState(() => _isHovered = false),
      child: InkWell(
        borderRadius: BorderRadius.circular(kBorderRadius),
        child: Opacity(
          opacity: widget.isCorrectOrder ? 1 : .7,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: widget.isSelected && state.prefState.isDesktop
                      ? state.accentColor!
                      : Colors.transparent,
                  width: 1),
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
            color: Theme.of(context).colorScheme.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    top: 8,
                    right: 8,
                    bottom: 4,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(task.description, maxLines: 3)),
                      if (task.isRunning)
                        Padding(
                          padding: state.prefState.isDesktop
                              ? EdgeInsets.only(left: 4, right: 1)
                              : EdgeInsets.only(left: 8, right: 10, top: 4),
                          child: Icon(
                            Icons.play_arrow,
                            size: 16,
                            color: state.accentColor,
                          ),
                        ),
                    ],
                  ),
                ),
                if (_isHovered && !isDragging)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Container(
                            height: 24,
                            child: Center(
                              child: Text(
                                localization.view,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          onTap: task.isNew
                              ? null
                              : () {
                                  if (state.taskUIState.selectedId == task.id &&
                                      !state.uiState.isEditing) {
                                    viewEntityById(
                                        entityId: '',
                                        entityType: EntityType.task,
                                        showError: false);
                                  } else {
                                    viewEntity(entity: task);
                                  }
                                },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
                            height: 28,
                            child: Center(
                              child: Text(
                                localization.edit,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          onTap: task.isNew
                              ? null
                              : () {
                                  editEntity(entity: task, fullScreen: false);
                                },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            handleEntityAction(
                                task,
                                task.isRunning
                                    ? EntityAction.stop
                                    : EntityAction.start);
                          },
                          child: Container(
                            height: 24,
                            child: Center(
                              child: Text(
                                startLabel,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, bottom: 12, right: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: LiveText(
                            () {
                              return formatDuration(task.calculateDuration()) +
                                  (client.isOld
                                      ? ' • ' + client.displayName
                                      : '') +
                                  (project.isOld ? ' • ' + project.name : '');
                            },
                            style: TextStyle(
                              fontSize: 12,
                              color: textColor!.withOpacity(kLighterOpacity),
                            ),
                          ),
                        ),
                        if (task.documents.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Icon(
                              MdiIcons.paperclip,
                              size: 16,
                            ),
                          ),
                        if (state.prefState.isMobile)
                          PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) {
                              return [
                                localization.view,
                                localization.edit,
                                startLabel,
                              ]
                                  .map((value) => PopupMenuItem<String>(
                                        child: Text(localization.lookup(value)),
                                        value: value,
                                      ))
                                  .toList();
                            },
                            onSelected: (value) {
                              if (value == startLabel) {
                                handleEntityAction(
                                    task,
                                    task.isRunning
                                        ? EntityAction.stop
                                        : EntityAction.start);
                              } else if (value == localization.view) {
                                viewEntity(entity: task);
                              } else if (value == localization.edit) {
                                editEntity(entity: task, fullScreen: false);
                              }
                            },
                          )
                        else if (task.projectId.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Icon(
                              MdiIcons.briefcaseOutline,
                              color: color,
                              size: 16,
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        onTap: () {
          setState(() {
            _isEditing = true;
          });
        },
      ),
    );
  }
}
