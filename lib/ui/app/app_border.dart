import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/constants.dart';

class AppBorder extends StatelessWidget {
  const AppBorder({
    @required this.child,
    this.isTop = false,
    this.isLeft = false,
  });

  final Widget child;
  final bool isTop;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    const borderWidth = 1.5;

    return Container(
        decoration: BoxDecoration(
          border: isTop || isLeft
              ? Border(
                  top: isTop
                      ? BorderSide(
                          width: borderWidth,
                          color: convertHexStringToColor(kDefaultBorderColor),
                        )
                      : BorderSide.none,
                  right: false
                      ? BorderSide(
                          width: borderWidth,
                          color: convertHexStringToColor(kDefaultBorderColor),
                        )
                      : BorderSide.none,
                  bottom: false
                      ? BorderSide(
                          width: borderWidth,
                          color: convertHexStringToColor(kDefaultBorderColor),
                        )
                      : BorderSide.none,
                  left: isLeft
                      ? BorderSide(
                          width: borderWidth,
                          color: convertHexStringToColor(kDefaultBorderColor),
                        )
                      : BorderSide.none,
                )
              : Border.all(
                  width: borderWidth,
                  color: convertHexStringToColor(kDefaultBorderColor),
                ),
        ),
        child: child);
  }
}
