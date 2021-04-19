import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SubscriptionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return AlertDialog(
      title: Text(localization.upgrade),
    );
  }
}
