import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/loading_indicator.dart';
import 'package:invoiceninja/ui/client/client_item.dart';
import 'package:invoiceninja/ui/client/client_list_vm.dart';

class ClientList extends StatelessWidget {
  final ClientListVM viewModel;

  ClientList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (! viewModel.isLoaded) {
      return LoadingIndicator();
    }

    return _buildListView(context);
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
              ClientItem(
                filter: viewModel.filter,
                state: viewModel.state,
                client: client,
                onDismissed: (DismissDirection direction) =>
                    viewModel.onDismissed(context, client, direction),
                onTap: () => viewModel.onClientTap(context, client),
              ),
              Divider(
                height: 1.0,
              ),
            ]);
          }),
    );
  }
}
