import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class ListDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final enableDarkMode = state.prefState.enableDarkMode;
    final color = convertHexStringToColor(
        enableDarkMode ? kDefaultDarkBorderColor : kDefaultLightBorderColor);

    return Divider(
      color: color,
      thickness: 1.5,
      height: 1.5,
    );
  }
}
