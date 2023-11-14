// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:local_auth/local_auth.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/settings/device_settings.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DeviceSettingsScreen extends StatelessWidget {
  const DeviceSettingsScreen({Key? key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsDeviceSettings';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DeviceSettingsVM>(
      converter: DeviceSettingsVM.fromStore,
      builder: (context, viewModel) {
        return DeviceSettings(viewModel: viewModel);
      },
    );
  }
}

class DeviceSettingsVM {
  DeviceSettingsVM({
    required this.state,
    required this.onRefreshTap,
    required this.onLogoutTap,
    required this.onDarkModeChanged,
    required this.onLayoutChanged,
    required this.onRequireAuthenticationChanged,
    required this.onLongPressSelectionIsDefault,
    required this.authenticationSupported,
    required this.onMenuModeChanged,
    required this.onHistoryModeChanged,
    required this.onColorThemeChanged,
    required this.onCustomColorsChanged,
    required this.onPersistDataChanged,
    required this.onShowPdfChanged,
    required this.onEnableNativeBrowserChanged,
    required this.onShowPdfSideBySideChanged,
    required this.onTapSelectedChanged,
    required this.onTextScaleFactorChanged,
    required this.onEditAfterSavingChanged,
    required this.onEnableTouchEventsChanged,
    required this.onEnableTooltipsChanged,
    required this.onEnableFlexibleSearchChanged,
    required this.onDownloadsFolderChanged,
  });

  static DeviceSettingsVM fromStore(Store<AppState> store) {
    return DeviceSettingsVM(
      state: store.state,
      onRefreshTap: (BuildContext context) =>
          showRefreshDataDialog(context: context, includeStatic: true),
      onLogoutTap: (BuildContext context) {
        final completer = snackBarCompleter<Null>(
            AppLocalization.of(context)!.endedAllSessions);
        store.dispatch(UserLogoutAll(completer: completer));
      },
      onDarkModeChanged: (BuildContext context, String value) async {
        store.dispatch(UpdateUserPreferences(darkModeType: value));
        AppBuilder.of(context)!.rebuild();
      },
      onLongPressSelectionIsDefault: (BuildContext context, bool value) async {
        store.dispatch(
            UpdateUserPreferences(longPressSelectionIsDefault: value));
      },
      onMenuModeChanged: (context, value) async {
        if (store.state.prefState.menuSidebarMode == value) {
          return;
        }

        store.dispatch(UpdateUserPreferences(menuMode: value));
      },
      onHistoryModeChanged: (context, value) async {
        if (store.state.prefState.historySidebarMode == value) {
          return;
        }

        store.dispatch(UpdateUserPreferences(historyMode: value));
      },
      onTapSelectedChanged: (context, value) async {
        store.dispatch(UpdateUserPreferences(tapSelectedToEdit: value));
      },
      onDownloadsFolderChanged: (context, value) async {
        store.dispatch(UpdateUserPreferences(downloadsFolder: value));
      },
      onEnableTouchEventsChanged: (context, value) async {
        store.dispatch(UpdateUserPreferences(enableTouchEvents: value));
        store.dispatch(UpdatedSetting());
        AppBuilder.of(context)!.rebuild();
      },
      onShowPdfChanged: (context, value) {
        store.dispatch(UpdateUserPreferences(showPdfPreview: value));
      },
      onEnableNativeBrowserChanged: (context, value) {
        store.dispatch(UpdateUserPreferences(enableNativeBrowser: value));
      },
      onShowPdfSideBySideChanged: (context, value) {
        store.dispatch(UpdateUserPreferences(showPdfPreviewSideBySide: value));
      },
      onTextScaleFactorChanged: (context, value) {
        store.dispatch(UpdateUserPreferences(textScaleFactor: value));
      },
      onEnableTooltipsChanged: (context, value) {
        store.dispatch(UpdateUserPreferences(enableTooltips: value));
      },
      onEnableFlexibleSearchChanged: (context, value) {
        store.dispatch(UpdateUserPreferences(flexibleSearch: value));
      },
      onColorThemeChanged: (context, value) async {
        final prefState = store.state.prefState;
        if (prefState.enableDarkMode) {
          if (prefState.darkColorTheme != value) {
            store.dispatch(UpdateUserPreferences(darkColorTheme: value));
          }
        } else {
          if (prefState.colorTheme != value) {
            store.dispatch(UpdateUserPreferences(colorTheme: value));
          }
        }
      },
      onEditAfterSavingChanged: (context, value) async {
        store.dispatch(UpdateUserPreferences(editAfterSaving: value));
      },
      onLayoutChanged: (BuildContext context, AppLayout value) async {
        if (store.state.prefState.appLayout == value) {
          return;
        }
        store.dispatch(UpdateUserPreferences(appLayout: value));
        AppBuilder.of(context)!.rebuild();
        WidgetsBinding.instance.addPostFrameCallback((duration) {
          if (value == AppLayout.mobile) {
            store.dispatch(ViewDashboard());
          } else {
            store.dispatch(ViewMainScreen(addDelay: true));
          }
        });
      },
      onRequireAuthenticationChanged: (BuildContext context, bool value) async {
        bool authenticated = false;
        try {
          authenticated = await LocalAuthentication().authenticate(
              localizedReason:
                  AppLocalization.of(context)!.authenticateToChangeSetting,
              options: const AuthenticationOptions(
                  biometricOnly: true,
                  useErrorDialogs: true,
                  stickyAuth: false));
        } catch (e) {
          print(e);
        }
        if (authenticated) {
          store.dispatch(UpdateUserPreferences(requireAuthentication: value));
        } else {}
      },
      //authenticationSupported: LocalAuthentication().canCheckBiometrics,
      // TODO remove this once issue is resolved:
      // https://github.com/flutter/flutter/issues/24339
      authenticationSupported: Future<bool>(
        () async {
          bool enable = false;
          try {
            enable = await LocalAuthentication().canCheckBiometrics;
          } catch (e) {
            // do nothing
          }
          return enable;
        },
      ),
      onCustomColorsChanged: (context, customColors) {
        if (store.state.prefState.enableDarkMode) {
          store.dispatch(UpdateUserPreferences(darkCustomColors: customColors));
        } else {
          store.dispatch(UpdateUserPreferences(customColors: customColors));
        }
        store.dispatch(UpdatedSettingUI());
      },
      onPersistDataChanged: (context, value) {
        store.dispatch(UpdateUserPreferences(persistData: value));
        if (value) {
          store.dispatch(UserLoginSuccess());
        } else {
          store.dispatch(ClearPersistedData());
        }
      },
    );
  }

  final AppState state;
  final Function(BuildContext) onRefreshTap;
  final Function(BuildContext) onLogoutTap;
  final Function(BuildContext, String) onDarkModeChanged;
  final Function(BuildContext, BuiltMap<String, String>) onCustomColorsChanged;
  final Function(BuildContext, AppLayout) onLayoutChanged;
  final Function(BuildContext, AppSidebarMode) onMenuModeChanged;
  final Function(BuildContext, AppSidebarMode) onHistoryModeChanged;
  final Function(BuildContext, String) onColorThemeChanged;
  final Function(BuildContext, bool) onLongPressSelectionIsDefault;
  final Function(BuildContext, bool) onTapSelectedChanged;
  final Function(BuildContext, bool) onEditAfterSavingChanged;
  final Function(BuildContext, bool) onRequireAuthenticationChanged;
  final Function(BuildContext, bool) onPersistDataChanged;
  final Function(BuildContext, bool) onShowPdfChanged;
  final Function(BuildContext, bool) onEnableNativeBrowserChanged;
  final Function(BuildContext, bool) onShowPdfSideBySideChanged;
  final Function(BuildContext, bool) onEnableTouchEventsChanged;
  final Function(BuildContext, bool) onEnableTooltipsChanged;
  final Function(BuildContext, bool) onEnableFlexibleSearchChanged;
  final Function(BuildContext, double) onTextScaleFactorChanged;
  final Function(BuildContext, String) onDownloadsFolderChanged;
  final Future<bool> authenticationSupported;
}
