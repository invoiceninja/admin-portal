import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/user/user_list_item.dart';
import 'package:invoiceninja_flutter/ui/user/user_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class UserList extends StatelessWidget {
  const UserList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final UserListVM viewModel;

  @override
  Widget build(BuildContext context) {
    /*
    final localization = AppLocalization.of(context);
    final listState = viewModel.listState;
    final filteredClientId = listState.filterEntityId;
    final filteredClient =
        filteredClientId != null ? viewModel.clientMap[filteredClientId] : null;
    final store = StoreProvider.of<AppState>(context);
    final listUIState = store.state.uiState.userUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    */

    return Column(
      children: <Widget>[
        Expanded(
          child: !viewModel.isLoaded
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.userList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: viewModel.userList.length,
                          itemBuilder: (BuildContext context, index) {
                            final userId = viewModel.userList[index];
                            final user = viewModel.userMap[userId];
                            final userCompany = viewModel.userCompany;

                            void showDialog() => showEntityActionsDialog(
                                userCompany: userCompany,
                                entities: [user],
                                context: context,
                                onEntityAction: viewModel.onEntityAction);

                            return UserListItem(
                              user: user,
                              filter: viewModel.filter,
                              onTap: () => viewModel.onUserTap(context, user),
                              onEntityAction: (EntityAction action) {
                                if (action == EntityAction.more) {
                                  showDialog();
                                } else {
                                  viewModel.onEntityAction(
                                      context, [user], action);
                                }
                              },
                              onLongPress: () => showDialog(),
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }
}
