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
    final localization = AppLocalization.of(context);
    final listState = viewModel.state.clientListState;
    final filteredGroupId = listState.filterEntityId;
    final filteredGroup =
        filteredGroupId != null ? state.groupState.map[filteredGroupId] : null;

    return Column(
      children: <Widget>[
        if (filteredGroup != null)
          ListFilterMessage(
            title:
                '${localization.filteredByGroup}: ${filteredGroup.listDisplayName}',
            onPressed: viewModel.onViewEntityFilterPressed,
            onClearPressed: viewModel.onClearEntityFilterPressed,
          ),
        Expanded(
          child: !viewModel.isLoaded
              ? (viewModel.isLoading ? LoadingIndicator() : SizedBox())
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

                            // Add header
                            if (index == 0 && isInMultiselect) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Checkbox(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onChanged: (value) {
                                          final clients = viewModel.clientList
                                              .map<ClientEntity>((clientId) =>
                                                  viewModel.clientMap[clientId])
                                              .toList();

                                          viewModel.onEntityAction(
                                              context,
                                              clients,
                                              EntityAction.toggleMultiselect);
                                        },
                                        activeColor:
                                            Theme.of(context).accentColor,
                                        value: state.clientListState
                                                .selectedEntities.length ==
                                            viewModel.clientList.length),
                                  ),
                                ],
                              );
                            }

                            if (isInMultiselect) {
                              index--;
                            }
                            final userCompany = viewModel.state.userCompany;

                            void showDialog() => showEntityActionsDialog(
                                entities: [client],
                                context: context,
                                userCompany: userCompany,
                                onEntityAction: viewModel.onEntityAction);

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
                                if (longPressIsSelection) {
                                  viewModel.onEntityAction(context, [client],
                                      EntityAction.toggleMultiselect);
                                } else {
                                  showDialog();
                                }
                              },
                            );
                          }),
                ),
        ),
      ],
    );
  }
}
