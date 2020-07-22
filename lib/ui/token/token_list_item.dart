import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/token_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';

class TokenListItem extends StatelessWidget {
  const TokenListItem({
    @required this.user,
    @required this.token,
    @required this.filter,
    this.onTap,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity user;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final TokenEntity token;
  final String filter;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final tokenUIState = uiState.tokenUIState;
    final listUIState = tokenUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;
    final user = state.userState.get(token.createdUserId);

    final filterMatch = filter != null && filter.isNotEmpty
        ? token.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch;

    return DismissibleEntity(
      userCompany: state.userCompany,
      entity: token,
      isSelected: token.id ==
          (uiState.isEditing
              ? tokenUIState.editing.id
              : tokenUIState.selectedId),
      child: ListTile(
        onTap: () => onTap != null
            ? onTap()
            : selectEntity(entity: token, context: context),
        onLongPress: () => onLongPress != null
            ? onLongPress()
            : selectEntity(entity: token, context: context, longPress: true),
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
        title: Text(
          token.name,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(user.fullName),
            subtitle != null && subtitle.isNotEmpty
                ? Text(
                    subtitle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                : Container(),
            EntityStateLabel(token),
          ],
        ),
      ),
    );
  }
}
