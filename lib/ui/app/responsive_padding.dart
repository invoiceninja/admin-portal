// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ResponsivePadding extends StatelessWidget {
  const ResponsivePadding({this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    /*
    final double sidePadding = isMobile(context)
        ? kMobileDialogPadding
        : (MediaQuery.of(context).size.width - 500) / 2;

    return Padding(
      padding: EdgeInsets.only(
          left: sidePadding,
          top: kMobileDialogPadding,
          right: sidePadding,
          bottom:
              kMobileDialogPadding + MediaQuery.of(context).viewInsets.bottom),
      child: child,
    );

     */

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
        widthFactor: .4,
      );
    }
  }
}
