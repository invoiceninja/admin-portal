import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/client/client_list_vm.dart';
import 'package:invoiceninja_flutter/ui/client/client_list_item.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientList extends StatelessWidget {
  final ClientListVM viewModel;

  const ClientList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (! viewModel.isLoaded) {
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

  void _showMenu(BuildContext context, ClientEntity client) async {
    final message = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(children: <Widget>[
          client.isActive ? ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text(AppLocalization.of(context).newInvoice),
            onTap: () => viewModel.onEntityAction(
                context, client, EntityAction.invoice),
          ) : Container(),
          Divider(),
          ! client.isActive ? ListTile(
            leading: Icon(Icons.restore),
            title: Text(AppLocalization.of(context).restore),
            onTap: () => viewModel.onEntityAction(
                context, client, EntityAction.restore),
          ) : Container(),
          client.isActive ? ListTile(
            leading: Icon(Icons.archive),
            title: Text(AppLocalization.of(context).archive),
            onTap: () => viewModel.onEntityAction(
                context, client, EntityAction.archive),
          ) : Container(),
          ! client.isDeleted ? ListTile(
            leading: Icon(Icons.delete),
            title: Text(AppLocalization.of(context).delete),
            onTap: () => viewModel.onEntityAction(
                context, client, EntityAction.delete),
          ) : Container(),
        ]));
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
                filter: viewModel.filter,
                client: client,
                onDismissed: (DismissDirection direction) =>
                    viewModel.onDismissed(context, client, direction),
                onTap: () => viewModel.onClientTap(context, client),
                onLongPress: () => _showMenu(context, client),
              ),
              Divider(
                height: 1.0,
              ),
            ]);
          }),
    );
  }
}
