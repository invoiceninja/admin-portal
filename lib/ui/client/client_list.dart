import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/client/client_list_vm.dart';
import 'package:invoiceninja_flutter/ui/client/client_list_item.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/src/store.dart';

import 'client_list_vm.dart';

class ClientList extends StatelessWidget {
  const ClientList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientListVM viewModel;

  @override
  Widget build(BuildContext context) {
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

                            void showDialog() => showEntityActionsDialog(
                                entity: client,
                                context: context,
                                userCompany: state.userCompany,
                                client: client,
                                onEntityAction: viewModel.onEntityAction);

                            return ClientListItem(
                              user: state.user,
                              filter: viewModel.filter,
                              client: client,
                              onTap: () =>
                                  viewModel.onClientTap(context, client),
                              onEntityAction: (EntityAction action) {
                                if (action == EntityAction.more) {
                                  showDialog();
                                } else {
                                  viewModel.onEntityAction(
                                      context, client, action);
                                }
                              },
                              onLongPress: () => _onLongPress(context, store),
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }

  void _onLongPress(BuildContext context, Store<AppState> store) {
    if (!store.state.clientListState.isInMultiselect()) {
      store.dispatch(StartMultiselect(context: context));
    }
  }
}
