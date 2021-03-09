import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/static/color_theme_model.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/device_settings_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
                AppDropdownButton<AppLayout>(
                  showUseDefault: true,
                  labelText: localization.layout,
                  value: viewModel.state.prefState.appLayout,
                  onChanged: (dynamic value) =>
                      viewModel.onLayoutChanged(context, value),
                  items: [
                    DropdownMenuItem(
                      child: Text(localization.desktop),
                      value: AppLayout.desktop,
                    ),
                    DropdownMenuItem(
                      child: Text(localization.mobile),
                      value: AppLayout.mobile,
                    ),
                  ],
                ),
                if (state.prefState.isNotMobile) ...[
                  AppDropdownButton<AppSidebarMode>(
                    showUseDefault: true,
                    labelText: localization.menuSidebar,
                    value: state.prefState.menuSidebarMode,
                    items: [
                      DropdownMenuItem(
                        child: Text(localization.collapse),
                        value: AppSidebarMode.collapse,
                      ),
                      DropdownMenuItem(
                        child: Text(localization.float),
                        value: AppSidebarMode.float,
                      ),
                    ],
                    onChanged: (dynamic value) =>
                        viewModel.onMenuModeChanged(context, value),
                  ),
                  AppDropdownButton<AppSidebarMode>(
                    showUseDefault: true,
                    labelText: localization.historySidebar,
                    value: state.prefState.historySidebarMode,
                    items: [
                      DropdownMenuItem(
                        child: Text(localization.showOrHide),
                        value: AppSidebarMode.visible,
                      ),
                      DropdownMenuItem(
                        child: Text(localization.float),
                        value: AppSidebarMode.float,
                      ),
                    ],
                    onChanged: (dynamic value) =>
                        viewModel.onHistoryModeChanged(context, value),
                  ),
                ],
                AppDropdownButton<int>(
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
                BoolDropdownButton(
                  label: localization.listLongPress,
                  value: !prefState.longPressSelectionIsDefault,
                  onChanged: (value) {
                    viewModel.onLongPressSelectionIsDefault(context, !value);
                  },
                  enabledLabel: localization.showActions,
                  disabledLabel: localization.startMultiselect,
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
                        title: Text(AppLocalization.of(context)
                            .biometricAuthentication),
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
                    title: Text(AppLocalization.of(context).refreshData),
                    onTap: state.isSaving || state.isLoading
                        ? null
                        : () {
                            viewModel.onRefreshTap(context);
                          },
                  );
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
