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
          ? const EdgeInsets.all(kMobileDialogPadding)
          : const EdgeInsets.symmetric(
              vertical: kMobileDialogPadding,
              horizontal: kTabletDialogPadding,
            ),
      child: child,
    );
  }
}
