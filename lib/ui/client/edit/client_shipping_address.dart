import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/edit/client_edit.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientEditShippingAddress extends EntityEditor {
  ClientEditShippingAddress(this.client);

  final ClientEntity client;

  static final GlobalKey<FormFieldState<String>> _address1Key = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _address2Key = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _cityKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _stateKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _postalCodeKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _countyKey = GlobalKey<FormFieldState<String>>();

  onSaveClicked(ClientEntity client) {
    /*
    if (_formKey.currentState == null) {
      return client;
    }

    if (client == null || !_formKey.currentState.validate()) {
      return null;
    }
    */
    return client.rebuild((b) => b
      ..shippingAddress1 = _address1Key.currentState.value
      ..shippingAddress2 = _address2Key.currentState.value.trim()
      ..shippingCity = _cityKey.currentState.value.trim()
      ..shippingState = _stateKey.currentState.value.trim()
      ..shippingPostalCode = _postalCodeKey.currentState.value.trim()
    );
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

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
                key: _address1Key,
                initialValue: client.shippingAddress1,
                decoration: InputDecoration(
                  labelText: AppLocalization.of(context).address1,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: _address2Key,
                initialValue: client.shippingAddress2,
                decoration: InputDecoration(
                  labelText: AppLocalization.of(context).address2,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: _cityKey,
                initialValue: client.shippingCity,
                decoration: InputDecoration(
                  labelText: AppLocalization.of(context).city,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: _stateKey,
                initialValue: client.shippingState,
                decoration: InputDecoration(
                  labelText: AppLocalization.of(context).state,
                ),
                keyboardType: TextInputType.url,
              ),
              TextFormField(
                autocorrect: false,
                key: _postalCodeKey,
                initialValue: client.shippingPostalCode,
                decoration: InputDecoration(
                  labelText: AppLocalization.of(context).postalCode,
                ),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

