import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/client/client_list_vm.dart';
import 'package:invoiceninja_flutter/ui/client/client_list_item.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
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
      return LoadingIndicator();
    } else if (viewModel.clientList.isEmpty) {
      return Opacity(
        opacity: 0.5,
        child: Center(
          child: Text(
            AppLocalization.of(context).noRecordsFound,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }

    return _buildListView(context);
  }

  void _showMenu(
      BuildContext context, ClientEntity client, UserEntity user) async {
    if (client == null) {
      return;
    }
    final user = viewModel.user;
    final message = await showDialog<String>(
        context: context,
        builder: (BuildContext dialogContext) {
          final actions = <Widget>[];
          if (user.canCreate(EntityType.invoice)) {
            actions.add(EntityActionListTile(
              client: client,
              entityAction: EntityAction.newInvoice,
              mainContext: context,
              viewModel: viewModel,
            ));
          }
          if (user.canCreate(EntityType.payment)) {
            actions.add(EntityActionListTile(
              client: client,
              entityAction: EntityAction.enterPayment,
              mainContext: context,
              viewModel: viewModel,
            ));
          }

          if (actions.isNotEmpty) {
            actions.add(Divider());
          }

          actions.addAll(client
              .getEntityActions(user: user, includeEdit: true)
              .map((entityAction) {
            if (entityAction == null) {
              return Divider();
            } else {
              return EntityActionListTile(
                client: client,
                entityAction: entityAction,
                mainContext: context,
                viewModel: viewModel,
              );
            }
          }).toList());

          return SimpleDialog(children: actions);
        });

    if (message != null) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: SnackBarRow(
        message: message,
      )));
    }
  }

  Widget _buildListView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ListView.builder(
          itemCount: viewModel.clientList.length,
          itemBuilder: (BuildContext context, index) {
            final clientId = viewModel.clientList[index];
            final client = viewModel.clientMap[clientId];
            return Column(children: <Widget>[
              ClientListItem(
                user: viewModel.user,
                filter: viewModel.filter,
                client: client,
                onEntityAction: (EntityAction action) {
                  if (action == EntityAction.more) {
                    _showMenu(context, client, viewModel.user);
                  } else {
                    viewModel.onEntityAction(context, client, action);
                  }
                },
                onTap: () => viewModel.onClientTap(context, client),
                onLongPress: () => _showMenu(context, client, viewModel.user),
              ),
              Divider(
                height: 1.0,
              ),
            ]);
          }),
    );
  }
}

class EntityActionListTile extends StatelessWidget {
  const EntityActionListTile(
      {this.client, this.entityAction, this.viewModel, this.mainContext});

  final ClientEntity client;
  final EntityAction entityAction;
  final ClientListVM viewModel;
  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return ListTile(
      leading: Icon(getEntityActionIcon(entityAction)),
      title: Text(localization.lookup(entityAction.toString())),
      onTap: () {
        Navigator.of(context).pop();
        viewModel.onEntityAction(mainContext, client, entityAction);
      },
    );
  }
}
