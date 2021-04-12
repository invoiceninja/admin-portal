import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class AppContext {
  AppContext(
      {@required this.buildContext,
      @required this.store,
      @required this.navigator,
      @required this.localization});

  BuildContext buildContext;
  Store<AppState> store;
  NavigatorState navigator;
  AppLocalization localization;
}

extension AppContextExtension on BuildContext {
  AppContext getAppContext() {
    return AppContext(
        buildContext: this,
        store: StoreProvider.of<AppState>(this),
        navigator: Navigator.of(this),
        localization: AppLocalization.of(this));
  }
}
