// Dart imports:
//import 'dart:convert';
//import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
//import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
//import 'package:invoiceninja_flutter/data/web_client.dart';
//import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
//import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class WebSocketRefresh extends StatefulWidget {
  const WebSocketRefresh({
    Key? key,
    this.child,
    this.companyId,
  }) : super(key: key);

  final Widget? child;
  final String? companyId;

  @override
  _WebSocketRefreshState createState() => _WebSocketRefreshState();
}

class _WebSocketRefreshState extends State<WebSocketRefresh> {
  //WebSocket _socket;

  @override
  void didUpdateWidget(WebSocketRefresh oldWidget) {
    super.didUpdateWidget(oldWidget);

    return;

    /*
    if (kReleaseMode) {
      return;
    }

    if ((widget.companyId ?? '').isEmpty) {
      return;
    }

    if (_socket != null) {
      _socket.close();
    }

    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    if (!state.isHosted) {
      //return;
    }

    final webClient = WebClient();
    final credentials = state.credentials;
    final url = '${credentials.url}/broadcasting/auth';

    print('## REQUEST: ${widget.companyId}, ${state.company.companyKey}');

    webClient
        .post(url, credentials.token,
            data: json.encode(
              {'channel_name': 'private-company.${state.company.companyKey}'},
            ))
        .then((dynamic value) {
      print('## RESPONSE: $value');
      print('## ${value['auth']}');

      WebSocket.connect('wss://ws.invoicing.co/app/ninja',
          headers: <String, String>{
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${value['auth']}',
          }).then((socket) {
        print('## CONNECTED');
        _socket = socket;
        socket.listen((dynamic event) {
          print('## EVENT: $event');
          store.dispatch(RefreshData());
        });
      }).catchError((dynamic error) {
        print('## ERROR: $error');
      });
    });
    */
  }

  @override
  Widget build(BuildContext context) => widget.child!;
}
