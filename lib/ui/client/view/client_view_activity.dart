import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';

class ClientViewActivity extends StatelessWidget {
  const ClientViewActivity({Key key, ClientEntity client}) : super(key: key);

  final ClientEntity client;

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator();

    //return Container();
  }
}
