import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/client/client_list_item.dart';
import 'package:invoiceninja_flutter/ui/client/client_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientList extends StatelessWidget {
  const ClientList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientListVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = viewModel.state;
    final listState = viewModel.state.clientListState;

    return Column(
      children: <Widget>[
        if (listState.filterEntityId != null)
          ListFilterMessage(
            filterEntityId: listState.filterEntityId,
            filterEntityType: listState.filterEntityType,
            onPressed: viewModel.onViewEntityFilterPressed,
            onClearPressed: viewModel.onClearEntityFilterPressed,
          ),
        Expanded(
          child: !viewModel.isLoaded
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.clientList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: viewModel.clientList.length,
                          itemBuilder: (BuildContext context, index) {
                            final clientId = viewModel.clientList[index];
                            final client =
                                viewModel.clientMap[clientId] ?? ClientEntity();

                            final isInMultiselect =
                                state.clientListState.isInMultiselect();

                            void showDialog() => showEntityActionsDialog(
                                  entities: [client],
                                  context: context,
                                );

                            return ClientListItem(
                              user: viewModel.state.user,
                              filter: viewModel.filter,
                              client: client,
                              onEntityAction: (EntityAction action) {
                                if (action == EntityAction.more) {
                                  showDialog();
                                } else {
                                  viewModel.onEntityAction(
                                      context, [client], action);
                                }
                              },
                              onTap: () =>
                                  viewModel.onClientTap(context, client),
                              onLongPress: () async {
                                final longPressIsSelection = store.state.uiState
                                        .longPressSelectionIsDefault ??
                                    true;
                                if (longPressIsSelection && !isInMultiselect) {
                                  viewModel.onEntityAction(context, [client],
                                      EntityAction.toggleMultiselect);
                                } else {
                                  showDialog();
                                }
                              },
                              isChecked: isInMultiselect &&
                                  listState.isSelected(client.id),
                            );
                          }),
                ),
        ),
      ],
    );
  }
}
