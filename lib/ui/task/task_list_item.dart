import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/ui/app/live_text.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskListItem extends StatefulWidget {
  const TaskListItem({
    @required this.userCompany,
    @required this.client,
    @required this.project,
    @required this.onTap,
    @required this.task,
    @required this.filter,
    this.onEntityAction,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserCompanyEntity userCompany;
  final ClientEntity client;
  final ProjectEntity project;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;
  final TaskEntity task;
  final String filter;

  static final taskItemKey = (int id) => Key('__task_item_${id}__');

  @override
  _TaskListItemState createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final uiState = state.uiState;
    final taskUIState = uiState.taskUIState;

    final CompanyEntity company = state.selectedCompany;
    final taskStatus = company.taskStatusMap[widget.task.taskStatusId];

    final localization = AppLocalization.of(context);
    final filterMatch = widget.filter != null && widget.filter.isNotEmpty
        ? widget.task.matchesFilterValue(widget.filter)
        : null;
    final listUIState = taskUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = widget.onCheckboxChanged != null || isInMultiselect;

    if (isInMultiselect) {
      _multiselectCheckboxAnimController.forward();
    } else {
      _multiselectCheckboxAnimController.animateBack(0.0);
    }

    //final subtitle = filterMatch ?? client?.displayName ?? task.description;
    String subtitle;
    if (filterMatch != null) {
      subtitle = filterMatch;
    } else if (widget.client != null) {
      subtitle = widget.client.displayName;
      if (widget.project != null) {
        subtitle += ' • ' + widget.project.name;
      }
    }

    return DismissibleEntity(
      isSelected: widget.task.id ==
          (uiState.isEditing ? taskUIState.editing.id : taskUIState.selectedId),
      userCompany: widget.userCompany,
      entity: widget.task,
      onEntityAction: widget.onEntityAction,
      child: ListTile(
        onTap: isInMultiselect
            ? () => widget.onEntityAction(EntityAction.toggleMultiselect)
            : widget.onTap,
        onLongPress: widget.onLongPress,
        leading: showCheckbox
            ? FadeTransition(
                opacity: _multiselectCheckboxAnim,
                child: IgnorePointer(
                  ignoring: listUIState.isInMultiselect(),
                  child: Checkbox(
                    //key: NinjaKeys.taskItemCheckbox(task.id),
                    value: widget.isChecked,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (value) => widget.onCheckboxChanged(value),
                    activeColor: Theme.of(context).accentColor,
                  ),
                ),
              )
            : null,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.task.description.isNotEmpty
                      ? widget.task.description
                      : formatDate(
                          convertTimestampToDateString(widget.task.updatedAt),
                          context),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              LiveText(() {
                return formatNumber(widget.task.listDisplayAmount, context,
                    formatNumberType: FormatNumberType.duration);
              }, style: Theme.of(context).textTheme.title),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: subtitle != null && subtitle.isNotEmpty
                      ? Text(
                          subtitle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      : Container(),
                ),
                Text(
                    widget.task.isInvoiced
                        ? localization.invoiced
                        : widget.task.isRunning
                            ? localization.running
                            : taskStatus != null
                                ? taskStatus.name
                                : localization.logged,
                    style: TextStyle(
                      color: widget.task.isInvoiced
                          ? Colors.green
                          : widget.task.isRunning ? Colors.blue : Colors.grey,
                    )),
              ],
            ),
            EntityStateLabel(widget.task),
          ],
        ),
      ),
    );
  }

  Animation _multiselectCheckboxAnim;
  AnimationController _multiselectCheckboxAnimController;

  @override
  void initState() {
    super.initState();
    _multiselectCheckboxAnimController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _multiselectCheckboxAnim = Tween<double>(begin: 0.0, end: 1.0)
        .animate(_multiselectCheckboxAnimController);
  }

  @override
  void dispose() {
    _multiselectCheckboxAnimController.dispose();
    super.dispose();
  }
}
