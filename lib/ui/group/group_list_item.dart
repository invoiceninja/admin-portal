import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class GroupListItem extends StatelessWidget {
  const GroupListItem({
    @required this.user,
    @required this.onEntityAction,
    @required this.onTap,
    @required this.onLongPress,
    @required this.group,
    @required this.filter,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity user;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final GroupEntity group;
  final String filter;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  static final groupItemKey = (int id) => Key('__group_item_${id}__');

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final filterMatch = filter != null && filter.isNotEmpty
        ? group.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch;
    final uiState = store.state.uiState;
    final groupUIState = uiState.groupUIState;
    final listUIState = groupUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;

    return DismissibleEntity(
      userCompany: state.userCompany,
      entity: group,
      isSelected: false,
      onEntityAction: onEntityAction,
      child: ListTile(
        onTap: isInMultiselect
            ? () => onEntityAction(EntityAction.toggleMultiselect)
            : onTap,
        onLongPress: onLongPress,
        leading: showCheckbox
            ? IgnorePointer(
                ignoring: listUIState.isInMultiselect(),
                child: Checkbox(
                  value: isChecked,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (value) => onCheckboxChanged(value),
                  activeColor: Theme.of(context).accentColor,
                ),
              )
            : null,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  group.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Text(formatNumber(group.listDisplayAmount, context),
                  style: Theme.of(context).textTheme.headline6),
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
            EntityStateLabel(group),
          ],
        ),
      ),
    );
  }
}
