import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/progress_button.dart';
import 'package:invoiceninja/ui/client/edit/client_address.dart';
import 'package:invoiceninja/ui/client/edit/client_details.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientEdit extends StatefulWidget {
  final ClientEditVM viewModel;

  ClientEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _ClientEditState createState() => new _ClientEditState();
}

class _ClientEditState extends State<ClientEdit>
    with SingleTickerProviderStateMixin {

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var client = widget.viewModel.client;

    List<EntityEditor> editors = [
      ClientEditDetails(client: client),
      ClientEditAddress(client: client),
      ClientEditAddress(client: client, isShipping: true),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(client.id == null
            ? localization.newClient
            : client.displayName), // Text(localizations.clientDetails),
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: [
            Tab(
              text: localization.details,
            ),
            /*
            Tab(
              text: localization.contacts,
            ),
            */
            Tab(
              text: localization.billingAddress,
            ),
            Tab(
              text: localization.shippingAddress,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: editors,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: ProgressButton(
                label: localization.save.toUpperCase(),
                onPressed: () {
                  editors.forEach((editor) {
                      client = editor.onSaveClicked(client);
                  });
                  if (client != null) {

                  }
                },
                isLoading: false,
                isDirty: false,
              ),
            ),
          ),
        ],
      )
    );
  }
}

abstract class EntityEditor extends StatelessWidget {
  onSaveClicked(ClientEntity client);
}