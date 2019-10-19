import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class DocumentListItem extends StatefulWidget {
  const DocumentListItem({
    @required this.userCompany,
    @required this.onEntityAction,
    @required this.onTap,
    @required this.onLongPress,
    //@required this.onCheckboxChanged,
    @required this.document,
    @required this.filter,
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
  final DocumentEntity document;
  final String filter;

  static final documentItemKey = (int id) => Key('__document_item_${id}__');

  @override
  _DocumentListItemState createState() => _DocumentListItemState();
}

class _DocumentListItemState extends State<DocumentListItem>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final uiState = store.state.uiState;
    final documentUIState = uiState.documentUIState;
    final filterMatch = widget.filter != null && widget.filter.isNotEmpty
        ? widget.document.matchesFilterValue(widget.filter)
        : null;
    final subtitle = filterMatch;
    final listUIState = documentUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = widget.onCheckboxChanged != null || isInMultiselect;

    if (isInMultiselect) {
      _multiselectCheckboxAnimController.forward();
    } else {
      _multiselectCheckboxAnimController.animateBack(0.0);
    }

    return DismissibleEntity(
      isSelected: widget.document.id ==
          (uiState.isEditing
              ? documentUIState.editing.id
              : documentUIState.selectedId),
      userCompany: widget.userCompany,
      entity: widget.document,
      onEntityAction: widget.onEntityAction,
      child: ListTile(
        onTap: isInMultiselect
            ? () => widget.onEntityAction(EntityAction.toggleMultiselect)
            : widget.onTap,
        onLongPress: widget.onLongPress,
        /*
        leading: Checkbox(
          //key: NinjaKeys.documentItemCheckbox(document.id),
          value: true,
          //onChanged: onCheckboxChanged,
          onChanged: (value) {
            return true;
          },
        ),
        */
        leading: showCheckbox
            ? FadeTransition(
                opacity: _multiselectCheckboxAnim,
                child: IgnorePointer(
                  ignoring: listUIState.isInMultiselect(),
                  child: Checkbox(
                    //key: NinjaKeys.documentItemCheckbox(task.id),
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
                  widget.document.name,
                  //key: NinjaKeys.clientItemClientKey(client.id),
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Text(formatNumber(widget.document.listDisplayAmount, context),
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
            EntityStateLabel(widget.document),
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
