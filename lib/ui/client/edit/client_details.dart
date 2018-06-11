import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/edit/client_edit.dart';
import 'package:invoiceninja/utils/localization.dart';


class ClientEditDetails extends EntityEditor {
  ClientEditDetails(this.client);

  final ClientEntity client;

  static final GlobalKey<FormFieldState<String>> nameKey =
  GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> idNumberKey =
  GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> vatNumberKey =
  GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> websiteKey =
  GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> phoneKey =
  GlobalKey<FormFieldState<String>>();


  onSaveClicked(ClientEntity client) {
    if (client == null) {
      return null;
    }

    return client.rebuild((b) => b
      ..name = nameKey.currentState.value.trim()
      ..idNumber = idNumberKey.currentState.value.trim()
      ..vatNumber = vatNumberKey.currentState.value.trim()
      ..website = websiteKey.currentState.value.trim()
      ..workPhone = phoneKey.currentState.value.trim());
  }


  @override
  _ClientEditDetailsState createState() => new _ClientEditDetailsState();
}

class _ClientEditDetailsState extends State<ClientEditDetails> with AutomaticKeepAliveClientMixin{

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
            shrinkWrap: true,
            children: <Widget>[
              TextFormField(
                autocorrect: false,
                key: ClientEditDetails.nameKey,
                initialValue: client.name,
                decoration: InputDecoration(
                  labelText: localization.name,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: ClientEditDetails.idNumberKey,
                initialValue: client.idNumber,
                decoration: InputDecoration(
                  labelText: localization.idNumber,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: ClientEditDetails.vatNumberKey,
                initialValue: client.vatNumber,
                decoration: InputDecoration(
                  labelText: localization.vatNumber,
                ),
              ),
              TextFormField(
                autocorrect: false,
                key: ClientEditDetails.websiteKey,
                initialValue: client.website,
                decoration: InputDecoration(
                  labelText: localization.website,
                ),
                keyboardType: TextInputType.url,
              ),
              TextFormField(
                autocorrect: false,
                key: ClientEditDetails.phoneKey,
                initialValue: client.workPhone,
                decoration: InputDecoration(
                  labelText: localization.phone,
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
