import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/keyboard_aware_padding.dart';
import 'package:invoiceninja/ui/client/edit/client_edit.dart';
import 'package:invoiceninja/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientEditDetails extends StatefulWidget {
  ClientEditDetails({
    Key key,
    @required this.client,
  }) : super(key: key);

  final ClientEntity client;

  @override
  ClientEditDetailsState createState() => new ClientEditDetailsState();
}

class ClientEditDetailsState extends State<ClientEditDetails>
    with AutomaticKeepAliveClientMixin {
  String name;
  String idNumber;
  String vatNumber;
  String website;
  String phone;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var client = widget.client;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Card(
          elevation: 2.0,
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autocorrect: false,
                    onSaved: (value) => name = value.trim(),
                    initialValue: client.name,
                    decoration: InputDecoration(
                      labelText: localization.name,
                    ),
                  ),
                  TextFormField(
                    autocorrect: false,
                    onSaved: (value) => idNumber = value.trim(),
                    initialValue: client.idNumber,
                    decoration: InputDecoration(
                      labelText: localization.idNumber,
                    ),
                  ),
                  TextFormField(
                    autocorrect: false,
                    onSaved: (value) => vatNumber = value.trim(),
                    initialValue: client.vatNumber,
                    decoration: InputDecoration(
                      labelText: localization.vatNumber,
                    ),
                  ),
                  TextFormField(
                    autocorrect: false,
                    onSaved: (value) => website = value.trim(),
                    initialValue: client.website,
                    decoration: InputDecoration(
                      labelText: localization.website,
                    ),
                    keyboardType: TextInputType.url,
                  ),
                  TextFormField(
                    autocorrect: false,
                    onSaved: (value) => phone = value.trim(),
                    initialValue: client.workPhone,
                    decoration: InputDecoration(
                      labelText: localization.phone,
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
