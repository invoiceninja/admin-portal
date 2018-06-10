import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/actions_menu_button.dart';
import 'package:invoiceninja/ui/app/progress_button.dart';
import 'package:invoiceninja/ui/client/edit/client_details.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja/ui/client/view/client_details.dart';
import 'package:invoiceninja/ui/client/view/client_overview.dart';
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
    _controller = new TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.viewModel.client.id == null
            ? localization.newClient
            : widget.viewModel.client
            .displayName), // Text(localizations.clientDetails),
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: [
            Tab(
              text: localization.details,
            ),
            Tab(
              text: localization.contacts,
            ),
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
        children: <Widget>[
          ClientEditDetails(client: widget.viewModel.client),
          Container(),
          Container(),
          Container(),
        ],
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

