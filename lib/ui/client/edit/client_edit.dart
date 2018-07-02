import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_billing_address.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_details.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_shipping_address.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/app/buttons/save_icon_button.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_contacts.dart';

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
    var viewModel = widget.viewModel;
    var client = viewModel.client;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(client.isNew
              ? localization.newClient
              : viewModel.origClient.displayName), // Text(localizations.clientDetails),
          actions: <Widget>[
            SaveIconButton(
              isVisible: !client.isDeleted,
              isDirty: client.isNew || client != viewModel.origClient,
              isLoading: viewModel.isLoading,
              onPressed: () {
                if (! _formKey.currentState.validate()) {
                  return;
                }
                viewModel.onSavePressed(context);
              },
            )
          ],
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
        body: Form(
          key: _formKey,
          child: TabBarView(
            controller: _controller,
            children: <Widget>[
              ClientEditDetails(
                viewModel: widget.viewModel,
              ),
              ClientEditContacts(
                viewModel: widget.viewModel,
              ),
              ClientEditBillingAddress(
                viewModel: widget.viewModel,
              ),
              ClientEditShippingAddress(
                viewModel: widget.viewModel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}