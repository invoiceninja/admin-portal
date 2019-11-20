
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class LockScreen extends StatelessWidget {
  const LockScreen({@required this.onAuthenticatePressed});

  final Function onAuthenticatePressed;

  @override
  Widget build(BuildContext context) {
    //final localization = AppLocalization(Locale(Intl.defaultLocale));
    final localization = AppLocalization.of(context);

    return Material(
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.lock,
                size: 24.0,
                color: Colors.grey[400],
              ),
              SizedBox(
                width: 12.0,
              ),
              Text(
                localization.locked,
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
          RaisedButton(
            onPressed: onAuthenticatePressed,
            child: Text(localization.authenticate),
          )
        ],
      ),
    );
  }
}
