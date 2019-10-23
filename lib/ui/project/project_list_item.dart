import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';

class ProjectListItem extends StatefulWidget {
  const ProjectListItem({
    @required this.userCompany,
    @required this.onEntityAction,
    @required this.onTap,
    @required this.onLongPress,
    //@required this.onCheckboxChanged,
    @required this.project,
    @required this.filter,
    @required this.client,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserCompanyEntity userCompany;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  //final ValueChanged<bool> onCheckboxChanged;
  final ProjectEntity project;
  final ClientEntity client;
  final String filter;

  static final projectItemKey = (int id) => Key('__project_item_${id}__');

  @override
  _ProjectListItemState createState() => _ProjectListItemState();
}

class _ProjectListItemState extends State<ProjectListItem>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final uiState = store.state.uiState;
    final projectUIState = uiState.projectUIState;
    final listUIState = projectUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = widget.onCheckboxChanged != null || isInMultiselect;

    if (isInMultiselect) {
      _multiselectCheckboxAnimController.forward();
    } else {
      _multiselectCheckboxAnimController.animateBack(0.0);
    }

    final filterMatch = widget.filter != null && widget.filter.isNotEmpty
        ? widget.project.matchesFilterValue(widget.filter)
        : null;
    final subtitle = filterMatch ?? widget.client.displayName;

    return DismissibleEntity(
      isSelected: widget.project.id ==
          (uiState.isEditing
              ? projectUIState.editing.id
              : projectUIState.selectedId),
      userCompany: widget.userCompany,
      entity: widget.project,
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
                    //key: NinjaKeys.productItemCheckbox(task.id),
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
                  widget.project.name,
                  //key: NinjaKeys.clientItemClientKey(client.id),
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Text(formatNumber(widget.project.listDisplayAmount, context),
                  style: Theme.of(context).textTheme.title),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            subtitle != null && subtitle.isNotEmpty
                ? Text(
                    subtitle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                : Container(),
            EntityStateLabel(widget.project),
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
