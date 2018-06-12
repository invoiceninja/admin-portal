import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_details.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

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
          SaveButton(
            viewModel: widget.viewModel,
            editors: editors,
            formKey: _formKey,
            detailsKey: _detailsKey,
            billingAddressKey: _billingAddressKey,
            shippingAddressKey: _shippingAddressKey,
            contactsKey: _contactsKey,
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

class SaveButton extends StatelessWidget {
  final ClientEditVM viewModel;
  final List<Widget> editors;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ClientEditDetailsState> detailsKey;
  final GlobalKey<ClientEditContactsState> contactsKey;
  final GlobalKey<ClientEditBillingAddressState> billingAddressKey;
  final GlobalKey<ClientEditShippingAddressState> shippingAddressKey;

  SaveButton({
    this.viewModel,
    this.editors,
    this.formKey,
    this.detailsKey,
    this.contactsKey,
    this.billingAddressKey,
    this.shippingAddressKey,
  });

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

        formKey.currentState.save();

        var detailsState = detailsKey.currentState;
        var billingAddressState = billingAddressKey.currentState;
        //var shippingAddressState = shippingAddressKey.currentState;
        var contactState = contactsKey.currentState;

        ClientEntity client = viewModel.client.rebuild((b) => b
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
          ..contacts.replace(contactState.getContacts()));

        viewModel.onSaveClicked(context, client);
      },
      tooltip: localization.save,
      icon: Icon(
        Icons.cloud_upload,
        color: Colors.white,
      ),
    );
  }
}
