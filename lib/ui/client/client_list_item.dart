import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class ClientListItem extends StatefulWidget {
  const ClientListItem({
    @required this.user,
    @required this.onEntityAction,
    @required this.onTap,
    @required this.onLongPress,
    //@required this.onCheckboxChanged,
    @required this.client,
    @required this.filter,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity user;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;

  //final ValueChanged<bool> onCheckboxChanged;
  final ClientEntity client;
  final String filter;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  static final clientItemKey = (int id) => Key('__client_item_${id}__');

  @override
  _ClientListItemState createState() => _ClientListItemState();
}

class _ClientListItemState extends State<ClientListItem>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    //var localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final uiState = store.state.uiState;
    final clientUIState = uiState.clientUIState;
    final filterMatch = widget.filter != null && widget.filter.isNotEmpty
        ? widget.client.matchesFilterValue(widget.filter)
        : null;
    final listUIState = clientUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = widget.onCheckboxChanged != null || isInMultiselect;

    if (isInMultiselect) {
      _multiselectCheckboxAnimController.forward();
    } else {
      _multiselectCheckboxAnimController.animateBack(0.0);
    }

    return DismissibleEntity(
      isSelected: widget.client.id ==
          (uiState.isEditing
              ? clientUIState.editing.id
              : clientUIState.selectedId),
      userCompany: store.state.userCompany,
      onEntityAction: widget.onEntityAction,
      entity: widget.client,
      //entityKey: clientItemKey,
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
                  widget.client.displayName,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Text(
                  formatNumber(widget.client.balance, context,
                      clientId: widget.client.id),
                  style: Theme.of(context).textTheme.title),
            ],
          ),
        ),
        subtitle: (filterMatch == null && widget.client.isActive)
            ? null
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  filterMatch != null
                      ? Text(
                          filterMatch,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      : SizedBox(),
                  EntityStateLabel(widget.client),
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
