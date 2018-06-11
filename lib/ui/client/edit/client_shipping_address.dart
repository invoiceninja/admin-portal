import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/edit/client_edit.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientEditShippingAddress extends EntityEditor {
  ClientEditShippingAddress(this.client);

  final ClientEntity client;

  static final GlobalKey<FormFieldState<String>> shippingAddress1Key = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> shippingAddress2Key = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> shippingCityKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> shippingStateKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> shippingPostalCodeKey = GlobalKey<FormFieldState<String>>();
  //static final GlobalKey<FormFieldState<String>> shippingCountyKey = GlobalKey<FormFieldState<String>>();

  onSaveClicked(ClientEntity client) {
    if (shippingAddress1Key.currentState == null) {
      return client;
    }

    if (client == null) {
      return null;
    }

    return client.rebuild((b) => b
      ..shippingAddress1 = shippingAddress1Key.currentState.value.trim()
      ..shippingAddress2 = shippingAddress2Key.currentState.value.trim()
      ..shippingCity = shippingCityKey.currentState.value.trim()
      ..shippingState = shippingStateKey.currentState.value.trim()
      //..shippingPostalCode = shippingPostalCodeKey.currentState.value.trim()
    );
  }


  @override
  _ClientEditShippingAddressState createState() => new _ClientEditShippingAddressState();
}

class _ClientEditShippingAddressState extends State<ClientEditShippingAddress> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var client = widget.client;

    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                autocorrect: false,
                key: ClientEditShippingAddress.shippingAddress1Key,
                initialValue: client.shippingAddress1,
                decoration: InputDecoration(
                  labelText: localization.address1,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: ClientEditShippingAddress.shippingAddress2Key,
                initialValue: client.shippingAddress2,
                decoration: InputDecoration(
                  labelText: localization.address2,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: ClientEditShippingAddress.shippingCityKey,
                initialValue: client.shippingCity,
                decoration: InputDecoration(
                  labelText: localization.city,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: ClientEditShippingAddress.shippingStateKey,
                initialValue: client.shippingState,
                decoration: InputDecoration(
                  labelText: localization.state,
                ),
                keyboardType: TextInputType.url,
              ),
              /*
              TextFormField(
                autocorrect: false,
                key: ClientEditShippingAddress.shippingPostalCodeKey,
                initialValue: client.shippingPostalCode,
                decoration: InputDecoration(
                  labelText: localization.postalCode,
                ),
                keyboardType: TextInputType.phone,
              ),
              */
            ],
          ),
        ),
      ),
    );
  }
}

