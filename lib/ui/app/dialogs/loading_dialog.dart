import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('${localization.loading}...'),
        ),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 4.0,
              child: LinearProgressIndicator(),
            ))
      ],
    );
  }
}
