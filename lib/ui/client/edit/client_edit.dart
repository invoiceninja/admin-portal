import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/edit/client_billing_address.dart';
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
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = new TabController(vsync: this, length: 2);
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
      ClientEditDetails(client),
      ClientEditBillingAddress(client),
      //ClientEditShippingAddress(client),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(client.id == null
            ? localization.newClient
            : client.displayName), // Text(localizations.clientDetails),
        actions: <Widget>[
          SaveButton(
            viewModel: widget.viewModel,
            editors: editors,
            formKey: _formKey,
          )
        ],
        bottom: TabBar(
          controller: _controller,
          //isScrollable: true,
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
            /*
              Tab(
                text: localization.shippingAddress,
              ),
              */
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: TabBarView(
          controller: _controller,
          children: editors,
        ),
      ),
    );
  }
}

abstract class EntityEditor extends StatefulWidget {
  onSaveClicked(ClientEntity client);
}

class SaveButton extends StatelessWidget {
  final ClientEditVM viewModel;
  final List<EntityEditor> editors;
  final GlobalKey<FormState> formKey;

  SaveButton({
    this.viewModel, 
    this.editors, 
    this.formKey,});

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var client = viewModel.client;

    if (viewModel.isLoading) {
      return IconButton(
        onPressed: null,
        icon: SizedBox(
          //width: 28.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            //strokeWidth: 2.0,
          ),
        ),
      );
    }
    
    return IconButton(
      onPressed: () {
        if (!formKey.currentState.validate()) {
          return;
        }
        editors.forEach((editor) {
          client = editor.onSaveClicked(client);
        });
        if (client != null) {
          viewModel.onSaveClicked(context, client);
        }
      },
      tooltip: localization.save,
      icon: Icon(
        Icons.cloud_upload,
        color: Colors.white,
      ),
    );
  }
}
