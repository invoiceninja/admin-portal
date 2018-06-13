import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_details.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

import '../../app/save_icon_button.dart';
import 'client_edit_billing_address.dart';
import 'client_edit_contacts.dart';
import 'client_edit_shipping_address.dart';

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
  static final GlobalKey<ClientEditDetailsState> _detailsKey =
      GlobalKey<ClientEditDetailsState>();
  static final GlobalKey<ClientEditBillingAddressState> _billingAddressKey =
      GlobalKey<ClientEditBillingAddressState>();
  static final GlobalKey<ClientEditShippingAddressState> _shippingAddressKey =
      GlobalKey<ClientEditShippingAddressState>();
  static final GlobalKey<ClientEditContactsState> _contactsKey =
      GlobalKey<ClientEditContactsState>();

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

    List<Widget> editors = [
      ClientEditDetails(
        client: client,
        key: _detailsKey,
      ),
      ClientEditContacts(
        client: client,
        key: _contactsKey,
      ),
      /*
      ClientEditBillingAddress(
        client: client,
        key: _billingAddressKey,
      ),
      ClientEditShippingAddress(
        client: client,
        key: _shippingAddressKey,
      ),
      */
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(client.id == null
            ? localization.newClient
            : client.displayName), // Text(localizations.clientDetails),
        actions: <Widget>[
          SaveIconButton(
            isLoading: widget.viewModel.isLoading,
            onPressed: () {
              if (! _formKey.currentState.validate()) {
                return;
              }

              _formKey.currentState.save();

              var detailsState = _detailsKey.currentState;
              var billingAddressState = _billingAddressKey.currentState;
              //var shippingAddressState = _shippingAddressKey.currentState;
              var contactState = _contactsKey.currentState;

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

              widget.viewModel.onSaveClicked(context, client);
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
          children: editors,
        ),
      ),
    );
  }
}