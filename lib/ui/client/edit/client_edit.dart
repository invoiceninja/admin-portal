import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_details.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/app/save_icon_button.dart';
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
    var viewModel = widget.viewModel;
    var client = viewModel.client;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackClicked();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(client.isNew()
              ? localization.newClient
              : client.displayName), // Text(localizations.clientDetails),
          actions: <Widget>[
            SaveIconButton(
              isLoading: viewModel.isLoading,
              onPressed: () {
                if (! _formKey.currentState.validate()) {
                  return;
                }

                /*
                ClientEntity client = widget.viewModel.client.rebuild((b) => b
                  ..name = detailsState.name
                  ..idNumber = detailsState.idNumber
                  ..vatNumber = detailsState.vatNumber
                  ..website = detailsState.website
                  ..workPhone = detailsState.phone
                  /*
            ..address1 = billingAddressState.address1
            ..address2 = billingAddressState.address2
            ..city = billingAddressState.city
            ..state = billingAddressState.state
            ..postalCode = billingAddressState.postalCode
            ..shippingAddress1 = shippingAddressState.shippingAddress1
            ..shippingAddress2 = shippingAddressState.shippingAddress2
            ..shippingCity = shippingAddressState.shippingCity
            ..shippingState = shippingAddressState.shippingState
            ..shippingPostalCode = shippingAddressState.shippingPostalCode
            */
                  ..contacts.replace(
                      contactState?.getContacts() ?? widget.viewModel.client.contacts));
                */

                viewModel.onSaveClicked(context);
              },
            )
          ],
          bottom: TabBar(
            controller: _controller,
            //isScrollable: true,
            tabs: [
              Tab(
                text: localization.details,
              ),
              Tab(
                text: localization.contacts,
              ),
              /*
              Tab(
                text: localization.billingAddress,
              ),
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
            children: <Widget>[
              ClientEditDetails(
                viewModel: widget.viewModel,
              ),
              ClientEditContacts(
                viewModel: widget.viewModel,
              ),
              /*
              ClientEditBillingAddress(
                client: client,
              ),
              ClientEditShippingAddress(
                client: client,
              ),
              */
            ],
          ),
        ),
      ),
    );
  }
}