import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/client/client_list_vm.dart';
import 'package:invoiceninja_flutter/ui/client/client_list_item.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientList extends StatelessWidget {
  const ClientList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientListVM viewModel;

  @override
  Widget build(BuildContext context) {
    if (!viewModel.isLoaded) {
      return viewModel.isLoading ? LoadingIndicator() : SizedBox();
    } else if (viewModel.clientList.isEmpty) {
      return HelpText(AppLocalization.of(context).noRecordsFound);
    }

    return _buildListView(context);
  }

  Widget _buildListView(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ListView.separated(
          separatorBuilder: (context, index) => ListDivider(),
          itemCount: viewModel.clientList.length,
          itemBuilder: (BuildContext context, index) {
            final clientId = viewModel.clientList[index];
            final client = viewModel.clientMap[clientId];
            final userCompany = viewModel.state.userCompany;

            void showDialog() => showEntityActionsDialog(
                entity: client,
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
                  viewModel.onEntityAction(context, client, action);
                }
              },
              onTap: () => viewModel.onClientTap(context, client),
              onLongPress: () => viewModel.onEntityAction(
                  context, client, EntityAction.toggleMultiselect),
            );
          }),
    );
  }
}
