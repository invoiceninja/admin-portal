import 'package:flutter/foundation.dart';
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
    final isAllSides = isTop == null && isLeft == null;
    const borderWidth = kIsWeb ? 2 : 1.5;

    final color = enableDarkMode
        ? convertHexStringToColor(kDefaultDarkBorderColor)
        : convertHexStringToColor(kDefaultLightBorderColor);

    return Container(
        decoration: BoxDecoration(
          borderRadius: isAllSides ? BorderRadius.circular(5) : null,
          border: isAllSides
              ? Border.all(
                  width: borderWidth,
                  color: color,
                )
              : Border(
                  top: isTop == true
                      ? BorderSide(
                          width: borderWidth,
                          color: color,
                        )
                      : BorderSide.none,
                  left: isLeft == true
                      ? BorderSide(
                          width: borderWidth,
                          color: color,
                        )
                      : BorderSide.none,
                ),
        ),
        child: child);
  }
}
