import 'dart:async';
import 'package:flutter/material.dart';

import 'package:invoiceninja_flutter/utils/connection_status.dart';

class ConnStatusBannerState extends State<ConnStatusBanner> {
  late StreamSubscription _connectionChangeStream;

  bool isOffline = false;

  @override
  void initState() {
    super.initState();

    final ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);

    setState(() {
      isOffline = !connectionStatus.hasConnection;
    });
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }

  @override
  Widget build(BuildContext ctxt) {
    return isOffline
        ? Container(
            color: Colors.red,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        'No Internet Connection - showing cached data',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: "Roboto"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}

class ConnStatusBanner extends StatefulWidget {
  @override
  ConnStatusBannerState createState() => ConnStatusBannerState();
}
