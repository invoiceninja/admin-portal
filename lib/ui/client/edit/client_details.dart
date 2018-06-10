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

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var client = widget.client;

    return Padding(
      padding: EdgeInsets.all(12.0),
      child: ListView(

      ),
    );
  }
}

