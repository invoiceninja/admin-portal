import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/utils/formatting.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/utils/platforms.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientEditAddress extends StatefulWidget {
  ClientEditAddress({this.client});

  final ClientEntity client;

  @override
  _ClientEditAddressState createState() => new _ClientEditAddressState();
}

class _ClientEditAddressState extends State<ClientEditAddress> {

  static final GlobalKey<FormFieldState<String>> _address1Key = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _address2Key = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _cityKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _stateKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _postalCodeKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _countyKey = GlobalKey<FormFieldState<String>>();

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
                key: _address1Key,
                initialValue: client.address1,
                decoration: InputDecoration(
                  labelText: AppLocalization.of(context).address1,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: _address2Key,
                initialValue: client.address2,
                decoration: InputDecoration(
                  labelText: AppLocalization.of(context).address2,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: _cityKey,
                initialValue: client.city,
                decoration: InputDecoration(
                  labelText: AppLocalization.of(context).city,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: _stateKey,
                initialValue: client.state,
                decoration: InputDecoration(
                  labelText: AppLocalization.of(context).state,
                ),
                keyboardType: TextInputType.url,
              ),
              TextFormField(
                autocorrect: false,
                key: _postalCodeKey,
                initialValue: client.postalCode,
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

