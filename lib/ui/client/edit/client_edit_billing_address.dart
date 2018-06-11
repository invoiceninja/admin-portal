import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/keyboard_aware_padding.dart';
import 'package:invoiceninja/ui/client/edit/client_edit.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientEditBillingAddress extends EntityEditor {
  ClientEditBillingAddress(this.client);

  final ClientEntity client;

  static final GlobalKey<FormFieldState<String>> address1Key =
  GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> address2Key =
  GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> cityKey =
  GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> stateKey =
  GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> postalCodeKey =
  GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> countyKey =
  GlobalKey<FormFieldState<String>>();

  onSaveClicked(ClientEntity client) {
    if (address1Key.currentState == null) {
      return client;
    }

    if (client == null) {
      return null;
    }

    return client.rebuild((b) => b
      ..address1 = address1Key.currentState.value.trim()
      ..address2 = address2Key.currentState.value.trim()
      ..city = cityKey.currentState.value.trim()
      ..state = stateKey.currentState.value.trim()
      ..postalCode = postalCodeKey.currentState.value.trim());
  }



  @override
  _ClientEditBillingAddressState createState() => new _ClientEditBillingAddressState();
}

class _ClientEditBillingAddressState extends State<ClientEditBillingAddress> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var client = widget.client;

    return KeyboardAwarePadding(
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                autocorrect: false,
                key: ClientEditBillingAddress.address1Key,
                initialValue: client.address1,
                decoration: InputDecoration(
                  labelText: localization.address1,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: ClientEditBillingAddress.address2Key,
                initialValue: client.address2,
                decoration: InputDecoration(
                  labelText: localization.address2,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: ClientEditBillingAddress.cityKey,
                initialValue: client.city,
                decoration: InputDecoration(
                  labelText: localization.city,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: ClientEditBillingAddress.stateKey,
                initialValue: client.state,
                decoration: InputDecoration(
                  labelText: localization.state,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: ClientEditBillingAddress.postalCodeKey,
                initialValue: client.postalCode,
                decoration: InputDecoration(
                  labelText: localization.postalCode,
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
