import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/app_text_button.dart';
import 'package:invoiceninja_flutter/ui/app/live_text.dart';
import 'package:invoiceninja_flutter/ui/task/kanban/kanban_view.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class KanbanTaskCard extends StatefulWidget {
  const KanbanTaskCard({
    @required this.task,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.isCorrectOrder,
    @required this.isDragging,
    @required this.isSaving,
  });
  final TaskEntity task;
  final Function(Completer<TaskEntity>, String) onSavePressed;
  final Function() onCancelPressed;
  final bool isCorrectOrder;
  final bool isDragging;
  final bool isSaving;

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

    final task = widget.task;
    _description = task.description;
    _isEditing = task.isNew;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final task = widget.task;
    final project = state.projectState.get(task.projectId);
    final client = state.clientState.get(task.clientId);

    var color = Colors.grey;
    if (task.projectId.isNotEmpty) {
      final projectIndex = state.projectState.list.indexOf(task.projectId);
      color = getColorByIndex(projectIndex);
    }

    final isDragging =
        context.findAncestorStateOfType<KanbanViewState>().isDragging;

    if (_isEditing && !isDragging) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              DecoratedFormField(
                autofocus: true,
                initialValue: _description,
                minLines: 3,
                maxLines: 10,
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
                        if (task.isNew) {
                          widget.onCancelPressed();
                        }
                      });
                    },
                    label: localization.cancel,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ElevatedButton(
                      onPressed: widget.isSaving
                          ? null
                          : () {
                              final completer = snackBarCompleter<TaskEntity>(
                                  context, localization.updatedTask);
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

    return MouseRegion(
      onHover: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),
      child: InkWell(
        child: Opacity(
          opacity: widget.isCorrectOrder ? 1 : .5,
          child: Card(
            color: Theme.of(context).backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(task.description, maxLines: 3)),
                      if (task.isRunning)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
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
                                  if (state.taskUIState.selectedId == task.id) {
                                    viewEntityById(
                                        appContext: context.getAppContext(),
                                        entityId: '',
                                        entityType: EntityType.task,
                                        showError: false);
                                  } else {
                                    viewEntity(
                                        appContext: context.getAppContext(),
                                        entity: task);
                                  }
                                },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
                            height: 24,
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
                                  editEntity(context: context, entity: task);
                                },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            handleEntityAction(
                                context.getAppContext(),
                                task,
                                task.isRunning
                                    ? EntityAction.stop
                                    : EntityAction.start);
                          },
                          child: Container(
                            height: 24,
                            child: Center(
                              child: Text(
                                  task.isRunning
                                      ? localization.stop
                                      : task.getTaskTimes().isEmpty
                                          ? localization.start
                                          : localization.resume,
                                  style: TextStyle(fontSize: 12)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                    child: Row(
                      children: [
                        LiveText(
                          () {
                            return formatDuration(task.calculateDuration()) +
                                (client.isOld
                                    ? ' • ' + client.displayName
                                    : '') +
                                (project.isOld ? ' • ' + project.name : '');
                          },
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Spacer(),
                        if (task.documents.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Icon(
                              MdiIcons.paperclip,
                              size: 16,
                            ),
                          ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          MdiIcons.briefcaseOutline,
                          color: color,
                          size: 16,
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
