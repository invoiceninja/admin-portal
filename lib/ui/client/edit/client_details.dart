import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/utils/formatting.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/utils/platforms.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientEditDetails extends StatefulWidget {
  ClientEditDetails({this.client});

  final ClientEntity client;

  @override
  _ClientEditDetailsState createState() => new _ClientEditDetailsState();
}

class _ClientEditDetailsState extends State<ClientEditDetails> {

  static final GlobalKey<FormFieldState<String>> _nameKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _idNumberKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _vatNumberKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _websiteKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _phoneKey = GlobalKey<FormFieldState<String>>();

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
                key: _nameKey,
                initialValue: client.name,
                decoration: InputDecoration(
                  labelText: AppLocalization.of(context).name,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: _idNumberKey,
                initialValue: client.idNumber,
                decoration: InputDecoration(
                  labelText: AppLocalization.of(context).idNumber,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: _vatNumberKey,
                initialValue: client.vatNumber,
                decoration: InputDecoration(
                  labelText: AppLocalization.of(context).vatNumber,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: _websiteKey,
                initialValue: client.website,
                decoration: InputDecoration(
                  labelText: AppLocalization.of(context).website,
                ),
                keyboardType: TextInputType.url,
              ),
              TextFormField(
                autocorrect: false,
                key: _phoneKey,
                initialValue: client.workPhone,
                decoration: InputDecoration(
                  labelText: AppLocalization.of(context).phone,
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

