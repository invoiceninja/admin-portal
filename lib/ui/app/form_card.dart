import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';

class FormCard extends StatelessWidget {
  const FormCard({
    Key key,
    this.isResponsive = false,
    this.children,
    this.child,
    this.crossAxisAlignment,
  }) : super(key: key);

  final Widget child;
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final bool isResponsive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isResponsive
          ? const EdgeInsets.symmetric(
              vertical: kMobileDialogPadding,
              horizontal: kTabletDialogPadding,
            )
          : const EdgeInsets.all(kMobileDialogPadding),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, top: 16.0, right: 16.0, bottom: 20.0),
          child: child != null ? child : Container(
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
    );
  }
}
