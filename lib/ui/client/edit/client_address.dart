import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/edit/client_edit.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientEditAddress extends EntityEditor {
  ClientEditAddress({this.client, this.isShipping = false});

  final ClientEntity client;
  final bool isShipping;

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> _address1Key = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _address2Key = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _cityKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _stateKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _postalCodeKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _countyKey = GlobalKey<FormFieldState<String>>();

  onSaveClicked(ClientEntity client) {
    if (_formKey.currentState == null) {
      return client;
    }

    if (client == null || !_formKey.currentState.validate()) {
      return null;
    }

    if (isShipping) {
      return client.rebuild((b) => b
        ..shippingAddress1 = _address1Key.currentState.value
      );
    } else {
      return client.rebuild((b) => b
        ..address1 = _address1Key.currentState.value
      );
    }
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
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  autocorrect: false,
                  key: _address1Key,
                  initialValue: isShipping ? client.shippingAddress1 : client.address1,
                  decoration: InputDecoration(
                    labelText: AppLocalization.of(context).address1,
                  ),
                ),
                TextFormField(
                  autocorrect: false,
                  key: _address2Key,
                  initialValue: isShipping ? client.shippingAddress2 : client.address2,
                  decoration: InputDecoration(
                    labelText: AppLocalization.of(context).address2,
                  ),
                ),
                TextFormField(
                  autocorrect: false,
                  key: _cityKey,
                  initialValue: isShipping ? client.shippingCity : client.city,
                  decoration: InputDecoration(
                    labelText: AppLocalization.of(context).city,
                  ),
                ),
                TextFormField(
                  autocorrect: false,
                  key: _stateKey,
                  initialValue: isShipping ? client.shippingState : client.state,
                  decoration: InputDecoration(
                    labelText: AppLocalization.of(context).state,
                  ),
                  keyboardType: TextInputType.url,
                ),
                TextFormField(
                  autocorrect: false,
                  key: _postalCodeKey,
                  initialValue: isShipping ? client.shippingPostalCode : client.postalCode,
                  decoration: InputDecoration(
                    labelText: AppLocalization.of(context).postalCode,
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

