import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/constants.dart';

class AppBorder extends StatelessWidget {
  const AppBorder({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: convertHexStringToColor(kDefaultBorderColor),
          ),
        ),
        child: child);
  }
}
