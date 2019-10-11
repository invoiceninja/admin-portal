import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ResponsivePadding extends StatelessWidget {
  const ResponsivePadding({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (isMobile(context)) {
      return Padding(
        padding: EdgeInsets.only(
            left: kMobileDialogPadding,
            top: kMobileDialogPadding,
            right: kMobileDialogPadding,
            bottom: kMobileDialogPadding +
                MediaQuery.of(context).viewInsets.bottom),
        child: child,
      );
    } else {
      return FractionallySizedBox(
        child: Padding(
            child: child,
            padding: EdgeInsets.only(top: kMobileDialogPadding * 2)),
        //bottom: (kMobileDialogPadding * 2) +
        //MediaQuery.of(context).viewInsets.bottom)),
        widthFactor: .7,
      );
    }
  }
}
