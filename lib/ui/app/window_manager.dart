import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

class WindowManager extends StatefulWidget {
  const WindowManager({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  State<WindowManager> createState() => _WindowManagerState();
}

class _WindowManagerState extends State<WindowManager> with WindowListener {
  @override
  void initState() {
    if (isDesktopOS()) {
      windowManager.addListener(this);
      _initManager();
    }

    super.initState();
  }

  void _initManager() async {
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void onWindowResize() async {
    if (!isDesktopOS()) {
      return;
    }

    final size = await windowManager.getSize();
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(kSharedPrefWidth, size.width);
    prefs.setDouble(kSharedPrefHeight, size.height);
  }

  @override
  void onWindowClose() async {
    if (!isDesktopOS()) {
      return;
    }

    final store = StoreProvider.of<AppState>(navigatorKey.currentContext!);

    if (await windowManager.isPreventClose()) {
      checkForChanges(
        store: store,
        callback: () async {
          await windowManager.destroy();
        },
      );
    }
  }

  @override
  void onWindowMaximize() async {
    if (!isDesktopOS()) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(kSharedPrefMaximized, true);
  }

  @override
  void onWindowUnmaximize() async {
    if (!isDesktopOS()) {
      return;
    }

    // This method is auto called when the app starts, we skip it
    // if the app state hasn't been loaded yet
    final store = StoreProvider.of<AppState>(navigatorKey.currentContext!);
    if (!store.state.isLoaded) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(kSharedPrefMaximized, false);
  }

  @override
  void dispose() {
    if (isDesktopOS()) {
      windowManager.removeListener(this);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child!;
}
