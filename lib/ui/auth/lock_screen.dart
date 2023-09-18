// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:invoiceninja_flutter/utils/localization.dart';

class LockScreen extends StatelessWidget {
  const LockScreen({required this.onAuthenticatePressed});

  final Function onAuthenticatePressed;

  @override
  Widget build(BuildContext context) {
    //final localization = AppLocalization(Locale(Intl.defaultLocale));
    final localization = AppLocalization.of(context)!;

    return Material(
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                MdiIcons.lock,
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
          ElevatedButton(
            onPressed: onAuthenticatePressed as void Function()?,
            child: Text(localization.authenticate),
          )
        ],
      ),
    );
  }
}
