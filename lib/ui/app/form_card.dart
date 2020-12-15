import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';

class FormCard extends StatelessWidget {
  const FormCard({
    Key key,
    this.forceNarrow = false,
    this.children,
    this.child,
    this.crossAxisAlignment,
    this.padding,
  }) : super(key: key);

  final Widget child;
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final bool forceNarrow;
  final EdgeInsets padding;

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
                  horizontal: (MediaQuery.of(context).size.width - 400) / 2,
                )
              : const EdgeInsets.only(
                  left: kMobileDialogPadding,
                  top: kMobileDialogPadding,
                  right: kMobileDialogPadding,
                )),
      child: Card(
        elevation: 4.0,
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
