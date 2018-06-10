import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/edit/client_edit.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientEditDetails extends EntityEditor {
  ClientEditDetails({this.client});

  final ClientEntity client;

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> _nameKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _idNumberKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _vatNumberKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _websiteKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _phoneKey = GlobalKey<FormFieldState<String>>();


  onSaveClicked(ClientEntity client) {
    if (_formKey.currentState == null) {
      return client;
    }

    if (client == null || !_formKey.currentState.validate()) {
      return null;
    }

    return client.rebuild((b) => b
      ..name = _nameKey.currentState.value
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
          child: Form(
            key: _formKey,
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
      ),
    );
  }
}
