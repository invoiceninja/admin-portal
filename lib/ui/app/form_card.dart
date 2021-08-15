import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';

class FormCard extends StatelessWidget {
  const FormCard({
    Key key,
    this.children,
    this.child,
    this.crossAxisAlignment,
    this.padding,
    this.isLast = false,
    this.forceNarrow = false,
    this.elevation = 4,
  }) : super(key: key);

  final Widget child;
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final bool forceNarrow;
  final EdgeInsets padding;
  final bool isLast;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    if (child == null && (children == null || children.isEmpty)) {
      return SizedBox();
    }

    return Padding(
      padding: padding ??
          (forceNarrow
              ? EdgeInsets.symmetric(
                  vertical: kMobileDialogPadding,
                  horizontal: (MediaQuery.of(context).size.width - 500) / 2,
                )
              : EdgeInsets.only(
                  left: kMobileDialogPadding,
                  top: kMobileDialogPadding,
                  right: kMobileDialogPadding,
                  bottom: isLast ? kMobileDialogPadding : 0,
                )),
      child: Card(
        elevation: elevation,
        child: AppBorder(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child != null
                ? child
                : Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment:
                          crossAxisAlignment ?? CrossAxisAlignment.center,
                      children: children,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
