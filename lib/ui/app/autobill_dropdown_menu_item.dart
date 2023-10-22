import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class AutobillDropdownMenuItem extends StatelessWidget {
  const AutobillDropdownMenuItem({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(localization.lookup(type)),
        Text(
          localization.lookup('auto_bill_help_' + type),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
