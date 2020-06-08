import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class AppBorder extends StatelessWidget {
  const AppBorder({
    @required this.child,
    this.isTop,
    this.isLeft,
  });

  final Widget child;
  final bool isTop;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final enableDarkMode = state.prefState.enableDarkMode;
    const borderWidth = 1.5;

    final color = enableDarkMode
        ? convertHexStringToColor(kDefaultDarkBorderColor)
        : (isTop == true)
            ? convertHexStringToColor(kDefaultLightBorderColor)
            : Colors.white;

    return Container(
        decoration: BoxDecoration(
          border: isTop != null || isLeft != null
              ? Border(
                  top: isTop == true
                      ? BorderSide(
                          width: borderWidth,
                          color: color,
                        )
                      : BorderSide.none,
                  /*
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
                   */
                  left: isLeft == true
                      ? BorderSide(
                          width: borderWidth,
                          color: color,
                        )
                      : BorderSide.none,
                )
              : Border.all(
                  width: borderWidth,
                  color: color,
                ),
        ),
        child: child);
  }
}
