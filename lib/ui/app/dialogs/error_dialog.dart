import 'package:flutter/material.dart';
import 'package:invoiceninja/utils/localization.dart';

class ErrorDialog extends StatelessWidget {

  ErrorDialog(this.error);
  final Object error;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Material(
            child: Column(
              children: <Widget>[
                Text(localization.anErrorOccurred),
                Text(error.toString()),
              ],
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
