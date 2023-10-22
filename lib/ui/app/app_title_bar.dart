import 'package:flutter/material.dart';

/*
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
*/

class AppTitleBar extends StatelessWidget {
  const AppTitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox();

    /*
    if (!isWindows()) {
      return SizedBox();
    }

    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final prefState = state.prefState;

    final buttonColors = WindowButtonColors(
      iconNormal: state.headerTextColor,
      iconMouseOver: state.headerTextColor,
      iconMouseDown: state.headerTextColor,
      mouseOver: Color(prefState.enableDarkMode ? 0xFF222222 : 0xFFDDDDDD),
      mouseDown: Color(prefState.enableDarkMode ? 0xFF333333 : 0xFFCCCCCC),
    );

    final closeButtonColors = WindowButtonColors(
      iconNormal: state.headerTextColor,
      iconMouseOver: Colors.white,
      mouseOver: Color(0xFFD32F2F),
      mouseDown: Color(0xFFB71C1C),
    );

    return Material(
      color: !prefState.enableDarkMode && state.hasAccentColor
          ? state.accentColor
          : null,
      child: WindowTitleBarBox(
        child: Row(
          children: [
            Expanded(
                child: MoveWindow(
              child: isMacOS()
                  ? SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 6),
                        Image.asset('assets/images/icon.png', width: 16),
                        SizedBox(width: 6),
                        Text(
                          'Invoice Ninja',
                          style: TextStyle(color: state.headerTextColor),
                        ),
                      ],
                    ),
            )),
            MinimizeWindowButton(colors: buttonColors),
            MaximizeWindowButton(colors: buttonColors),
            CloseWindowButton(
                colors: closeButtonColors,
                onPressed: () {
                  checkForChanges(
                    store: store,
                    callback: () {
                      appWindow.close();
                    },
                  );
                }),
          ],
        ),
      ),
    );
    */
  }
}
