import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/constants.dart';

class AppBorder extends StatelessWidget {
  const AppBorder({
    @required this.child,
    this.isTop = false,
  });

  final Widget child;
  final bool isTop;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: isTop
              ? Border(
                  top: isTop
                      ? BorderSide(
                          width: 1,
                          color: convertHexStringToColor(kDefaultBorderColor),
                        )
                      : null)
              : Border.all(
                  width: 1.5,
                  color: convertHexStringToColor(kDefaultBorderColor),
                ),
        ),
        child: child);
  }
}
