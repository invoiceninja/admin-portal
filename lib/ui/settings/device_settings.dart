import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/static/color_theme_model.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/live_text.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/device_settings_vm.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

class DeviceSettings extends StatefulWidget {
  const DeviceSettings({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DeviceSettingsVM viewModel;

  @override
  _DeviceSettingsState createState() => _DeviceSettingsState();
}

class _DeviceSettingsState extends State<DeviceSettings> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_deviceSettings');

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final prefState = state.prefState;
    /*
    final countSessions = state.tokenState.list
        .map((tokenId) => state.tokenState.map[tokenId])
        .where(
            (token) => token.isSystem && token.createdUserId == state.user.id)
        .length;
    */

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: isMobile(context),
        title: Text(localization.deviceSettings),
      ),
      body: Form(
        key: _formKey,
        child: ScrollableListView(
          children: <Widget>[
            FormCard(
              children: <Widget>[
                BoolDropdownButton(
                  label: localization.layout,
                  value: prefState.appLayout == AppLayout.mobile,
                  onChanged: (value) {
                    viewModel.onLayoutChanged(
                        context, value ? AppLayout.mobile : AppLayout.desktop);
                  },
                  enabledLabel: localization.mobile,
                  disabledLabel: localization.desktop,
                ),
                if (state.prefState.isDesktop) ...[
                  BoolDropdownButton(
                    label: localization.menuSidebar,
                    value: prefState.menuSidebarMode == AppSidebarMode.float,
                    onChanged: (value) {
                      viewModel.onMenuModeChanged(
                        context,
                        value ? AppSidebarMode.float : AppSidebarMode.collapse,
                      );
                    },
                    enabledLabel: localization.float,
                    disabledLabel: localization.collapse,
                  ),
                  BoolDropdownButton(
                    label: localization.historySidebar,
                    value: prefState.historySidebarMode == AppSidebarMode.float,
                    onChanged: (value) {
                      viewModel.onHistoryModeChanged(
                        context,
                        value ? AppSidebarMode.float : AppSidebarMode.visible,
                      );
                    },
                    enabledLabel: localization.float,
                    disabledLabel: localization.showOrHide,
                  ),
                  BoolDropdownButton(
                    label: localization.previewSidebar,
                    value: prefState.isPreviewEnabled,
                    onChanged: (value) {
                      viewModel.onPreviewSidebarChanged(context, value);
                    },
                    enabledLabel: localization.enabled,
                    disabledLabel: localization.disabled,
                  ),
                ],
              ],
            ),
            FormCard(
              children: <Widget>[
                BoolDropdownButton(
                  label: localization.listLongPress,
                  value: !prefState.longPressSelectionIsDefault,
                  onChanged: (value) {
                    viewModel.onLongPressSelectionIsDefault(context, !value);
                  },
                  enabledLabel: localization.showActions,
                  disabledLabel: localization.startMultiselect,
                ),
                AppDropdownButton<int>(
                  blankValue: null,
                  labelText: localization.rowsPerPage,
                  value: prefState.rowsPerPage,
                  onChanged: (dynamic value) =>
                      viewModel.onRowsPerPageChanged(context, value),
                  items: [
                    10,
                    25,
                    50,
                    // 100, // TODO optimize datatables to support this
                  ]
                      .map(
                        (value) => DropdownMenuItem(
                          child: Text('$value'),
                          value: value,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            FormCard(
              children: <Widget>[
                SwitchListTile(
                  title: Text(localization.darkMode),
                  value: prefState.enableDarkMode,
                  onChanged: (value) =>
                      viewModel.onDarkModeChanged(context, value),
                  secondary: Icon(kIsWeb
                      ? Icons.lightbulb_outline
                      : MdiIcons.themeLightDark),
                  activeColor: Theme.of(context).accentColor,
                ),
                SizedBox(height: 8),
                AppDropdownButton<String>(
                  showUseDefault: true,
                  labelText: localization.colorTheme,
                  value: state.prefState.colorTheme,
                  items: [
                    ...colorThemesMap.keys
                        .map((key) => DropdownMenuItem(
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: Text(toTitleCase(key)),
                                    width: 120,
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: colorThemesMap[key].colorInfo,
                                      height: 50,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: colorThemesMap[key].colorPrimary,
                                      height: 50,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: colorThemesMap[key].colorSuccess,
                                      height: 50,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: colorThemesMap[key].colorWarning,
                                      height: 50,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: colorThemesMap[key].colorDanger,
                                      height: 50,
                                    ),
                                  ),
                                ],
                              ),
                              value: key,
                            ))
                        .toList()
                  ],
                  onChanged: (dynamic value) =>
                      viewModel.onColorThemeChanged(context, value),
                ),
                FutureBuilder(
                  future: viewModel.authenticationSupported,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData && snapshot.data == true) {
                      return SwitchListTile(
                        title: Text(localization.biometricAuthentication),
                        value: prefState.requireAuthentication,
                        onChanged: (value) => viewModel
                            .onRequireAuthenticationChanged(context, value),
                        secondary: Icon(prefState.requireAuthentication
                            ? MdiIcons.lock
                            : MdiIcons.lockOpen),
                        activeColor: Theme.of(context).accentColor,
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                /*
                SwitchListTile(
                  title: Text(localization.fullWidthEditor),
                  value: prefState.fullWidthEditor,
                  onChanged: (value) =>
                      viewModel.onFullWidthEditorChanged(context, value),
                  secondary: Icon(getEntityIcon(EntityType.invoice)),
                  activeColor: Theme.of(context).accentColor,
                ),
                 */
              ],
            ),
            FormCard(
              children: <Widget>[
                Builder(builder: (BuildContext context) {
                  return ListTile(
                    leading: Icon(Icons.refresh),
                    title: Text(localization.refreshData),
                    subtitle: LiveText(() {
                      return localization.lastUpdated +
                          ': ' +
                          timeago.format(convertTimestampToDate(
                              (state.userCompanyState.lastUpdated / 1000)
                                  .round()));
                    }),
                    onTap: () {
                      viewModel.onRefreshTap(context);
                    },
                  );
                }),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(localization.endAllSessions),
                  /*
                  subtitle: Text(countSessions == 1
                      ? localization.countSession
                      : localization.countSession
                          .replaceFirst(':count', '$countSessions')),
                          */
                  onTap: () {
                    confirmCallback(
                        context: context,
                        callback: () {
                          viewModel.onLogoutTap(context);
                        });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
