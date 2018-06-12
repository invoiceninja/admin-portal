import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/edit/client_edit.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientEditBillingAddress extends StatefulWidget {
  ClientEditBillingAddress({
    Key key,
    @required this.client,
  }) : super(key: key);

  final ClientEntity client;

  @override
  ClientEditBillingAddressState createState() =>
      new ClientEditBillingAddressState();
}

class ClientEditBillingAddressState extends State<ClientEditBillingAddress>
    with AutomaticKeepAliveClientMixin {
  String address1;
  String address2;
  String city;
  String state;
  String postalCode;

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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autocorrect: false,
                    onSaved: (value) => address1 = value.trim(),
                    initialValue: client.address1,
                    decoration: InputDecoration(
                      labelText: localization.address1,
                    ),
                  ),
                  TextFormField(
                    autocorrect: false,
                    onSaved: (value) => address2 = value.trim(),
                    initialValue: client.address2,
                    decoration: InputDecoration(
                      labelText: localization.address2,
                    ),
                  ),
                  TextFormField(
                    autocorrect: false,
                    onSaved: (value) => city = value.trim(),
                    initialValue: client.city,
                    decoration: InputDecoration(
                      labelText: localization.city,
                    ),
                  ),
                  TextFormField(
                    autocorrect: false,
                    onSaved: (value) => state = value.trim(),
                    initialValue: client.state,
                    decoration: InputDecoration(
                      labelText: localization.state,
                    ),
                  ),
                  TextFormField(
                    autocorrect: false,
                    onSaved: (value) => postalCode = value.trim(),
                    initialValue: client.postalCode,
                    decoration: InputDecoration(
                      labelText: localization.postalCode,
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
