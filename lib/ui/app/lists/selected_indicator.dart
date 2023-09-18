// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';

class SelectedIndicator extends StatelessWidget {
  const SelectedIndicator({this.child, this.isSelected, this.isMenu = false});

  final Widget? child;
  final bool? isSelected;
  final bool isMenu;

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final enableDarkMode = state.prefState.enableDarkMode;

    return Material(
      color: isSelected!
          ? convertHexStringToColor(enableDarkMode
              ? (isMenu
                  ? kDefaultDarkSelectedColorMenu
                  : kDefaultDarkSelectedColor)
              : (isMenu
                  ? kDefaultLightSelectedColorMenu
                  : kDefaultLightSelectedColor))
          : Theme.of(context).cardColor,
      child: child,
    );
  }
}
