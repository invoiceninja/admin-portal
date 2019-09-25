import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:redux/src/store.dart';

class ClientListItem extends StatelessWidget {
  const ClientListItem({
    @required this.user,
    @required this.onEntityAction,
    @required this.onTap,
    @required this.onLongPress,
    //@required this.onCheckboxChanged,
    @required this.client,
    @required this.filter,
  });

  final UserEntity user;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;

  //final ValueChanged<bool> onCheckboxChanged;
  final ClientEntity client;
  final String filter;

  static final clientItemKey = (int id) => Key('__client_item_${id}__');

  @override
  Widget build(BuildContext context) {
    //var localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final uiState = store.state.uiState;
    final clientUIState = uiState.clientUIState;
    final filterMatch = filter != null && filter.isNotEmpty
        ? client.matchesFilterValue(filter)
        : null;
    final listUIState = clientUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return DismissibleEntity(
      isSelected: client.id ==
          (uiState.isEditing
              ? clientUIState.editing.id
              : clientUIState.selectedId),
      userCompany: store.state.userCompany,
      onEntityAction: onEntityAction,
      entity: client,
      //entityKey: clientItemKey,
      child: ListTile(
        onTap: isInMultiselect
            ? () => _toggleSelection(context, store, client.id)
            : onTap,
        onLongPress: onLongPress,
        title: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                client.displayName,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Text(formatNumber(client.balance, context, clientId: client.id),
                style: Theme.of(context).textTheme.title),
            if (isInMultiselect)
              IgnorePointer(
                  child: Checkbox(
                      value: listUIState.isSelected(client.id),
                      onChanged: null))
          ],
        ),
        subtitle: (filterMatch == null && client.isActive)
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
                  EntityStateLabel(client),
                ],
              ),
      ),
    );
  }

  void _toggleSelection(
      BuildContext context, Store<AppState> store, int clientId) {
    if (store.state.clientListState.isSelected(clientId)) {
      store.dispatch(
          RemoveFromMultiselect(context: context, clientId: clientId));
    } else {
      store.dispatch(AddToMultiselect(context: context, clientId: clientId));
    }
  }
}
