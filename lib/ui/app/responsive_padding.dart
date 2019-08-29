import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ResponsivePadding extends StatelessWidget {
  const ResponsivePadding({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMobile(context)
          ? EdgeInsets.only(
              left: kMobileDialogPadding,
              top: kMobileDialogPadding,
              right: kMobileDialogPadding,
              bottom: kMobileDialogPadding +
                  MediaQuery.of(context).viewInsets.bottom)
          : EdgeInsets.only(
              top: kMobileDialogPadding * 2,
              bottom: (kMobileDialogPadding * 2) +
                  MediaQuery.of(context).viewInsets.bottom,
              left: kTabletDialogPadding,
              right: kTabletDialogPadding,
            ),
      child: child,
    );
  }
}
