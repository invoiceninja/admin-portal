import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/alert_dialog.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

class WindowManager extends StatefulWidget {
  const WindowManager({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  State<WindowManager> createState() => _WindowManagerState();
}

class _WindowManagerState extends State<WindowManager> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    _init();

    super.initState();
  }

  void _init() async {
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void onWindowResize() async {
    final size = await windowManager.getSize();
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(kSharedPrefWidth, size.width);
    prefs.setDouble(kSharedPrefHeight, size.height);
  }

  @override
  void onWindowClose() async {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(navigatorKey.currentContext);
    final state = store.state;

    if (await windowManager.isPreventClose()) {
      if (state.hasChanges()) {
        showDialog<void>(
            context: context,
            builder: (context) => MessageDialog(
                  localization.errorUnsavedChanges,
                  dismissLabel: localization.continueEditing,
                  onDiscard: () async {
                    await windowManager.destroy();
                  },
                ));
      } else {
        await windowManager.destroy();
      }
    }
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
