import 'package:flutter/material.dart';

import 'package:invoiceninja_flutter/utils/connection_status.dart';

class ConnStatusBannerState extends State<ConnStatusBanner> {
  bool isOffline = false;
  bool shouldShowOnlineBanner = false;

  @override
  void initState() {
    super.initState();

    final ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);

    setState(() {
      isOffline = !connectionStatus.hasConnection;
      shouldShowOnlineBanner = false;
    });
  }

  void connectionChanged(dynamic hasConnection) {
    if (isOffline && hasConnection) {
      setState(() {
        shouldShowOnlineBanner = true;
      });

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          shouldShowOnlineBanner = false;
        });
      });
    }
    setState(() {
      isOffline = !hasConnection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return shouldShowOnlineBanner
        ? Container(
            color: Colors.green,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        'Back online!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Roboto'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : isOffline
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
                                fontFamily: 'Roboto'),
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
