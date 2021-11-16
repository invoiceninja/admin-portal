// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';

class ListDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final enableDarkMode = state.prefState.enableDarkMode;
    final color = convertHexStringToColor(
        enableDarkMode ? kDefaultDarkBorderColor : kDefaultLightBorderColor);

    // https://github.com/flutter/flutter/issues/46339#issuecomment-562859241
    return Container(
      color: color,
      child: Divider(
        color: color,
        thickness: 1.5,
        height: 1.5,
      ),
    );
  }
}
