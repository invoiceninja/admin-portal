import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/group/group_list_item.dart';
import 'package:invoiceninja_flutter/ui/group/group_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class GroupList extends StatelessWidget {
  const GroupList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final GroupListVM viewModel;

  @override
  Widget build(BuildContext context) {
    /*
    final localization = AppLocalization.of(context);
    final listState = viewModel.listState;
    final filteredClientId = listState.filterEntityId;
    final filteredClient =
        filteredClientId != null ? viewModel.clientMap[filteredClientId] : null;
    */
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final listUIState = state.uiState.groupUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return Column(
      children: <Widget>[
        Expanded(
          child: !viewModel.isLoaded
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.groupList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: viewModel.groupList.length,
                          itemBuilder: (BuildContext context, index) {
                            final groupId = viewModel.groupList[index];
                            final group = viewModel.groupMap[groupId];

                            void showDialog() => showEntityActionsDialog(
                                  entities: [group],
                                  context: context,
                                );

                            return GroupListItem(
                              user: viewModel.userCompany.user,
                              filter: viewModel.filter,
                              group: group,
                              onTap: () => viewModel.onGroupTap(context, group),
                              onEntityAction: (EntityAction action) {
                                if (action == EntityAction.more) {
                                  showDialog();
                                } else {
                                  handleGroupAction(context, [group], action);
                                }
                              },
                              onLongPress: () async {
                                final longPressIsSelection = store
                                        .state
                                        .prefState
                                        .longPressSelectionIsDefault ??
                                    true;
                                if (longPressIsSelection && !isInMultiselect) {
                                  handleGroupAction(context, [group],
                                      EntityAction.toggleMultiselect);
                                } else {
                                  showDialog();
                                }
                              },
                              isChecked: isInMultiselect &&
                                  listUIState.isSelected(group.id),
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }
}
