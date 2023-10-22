// Flutter imports:
import 'dart:math';

import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class FormCard extends StatelessWidget {
  const FormCard({
    Key? key,
    this.children,
    this.child,
    this.crossAxisAlignment,
    this.padding,
    this.internalPadding,
    this.isLast = false,
    this.forceNarrow = false,
    this.elevation = 5,
    this.constraints,
  }) : super(key: key);

  final Widget? child;
  final List<Widget>? children;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool forceNarrow;
  final EdgeInsets? padding;
  final EdgeInsets? internalPadding;
  final bool isLast;
  final double elevation;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    if (child == null && (children == null || children!.isEmpty)) {
      return SizedBox();
    }

    return Padding(
      padding: padding ??
          (forceNarrow
              ? EdgeInsets.symmetric(
                  horizontal:
                      max((MediaQuery.of(context).size.width - 510) / 2, 16),
                )
              : EdgeInsets.only(
                  left: kMobileDialogPadding,
                  top: kMobileDialogPadding,
                  right: kMobileDialogPadding,
                  bottom: isLast ? kMobileDialogPadding : 0,
                )),
      child: FocusTraversalGroup(
        child: Card(
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          child: AppBorder(
            hideBorder: !isDarkMode(context),
            child: Padding(
              padding: internalPadding ?? const EdgeInsets.all(16),
              child: child != null
                  ? child
                  : Container(
                      width: double.infinity,
                      constraints: constraints,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment:
                            crossAxisAlignment ?? CrossAxisAlignment.center,
                        children: children!,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
