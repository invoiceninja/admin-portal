import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/.env.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/color_picker.dart';
import 'package:invoiceninja_flutter/ui/settings/device_settings_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

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
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_deviceSettings');

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final prefState = state.prefState;

    return WillPopScope(
      onWillPop: () async {
        //viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: isMobile(context),
          title: Text(localization.deviceSettings),
          actions: <Widget>[],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  AppDropdownButton<AppLayout>(
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
                        child: Text(localization.tablet),
                        value: AppLayout.tablet,
                      ),
                      DropdownMenuItem(
                        child: Text(localization.mobile),
                        value: AppLayout.mobile,
                      ),
                    ],
                  ),
                  if (state.prefState.isNotMobile) ...[
                    AppDropdownButton<AppSidebarMode>(
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
                  FormColorPicker(
                    labelText: localization.accentColor,
                    initialValue: state.accentColor,
                    showClear: false,
                    onSelected: (value) {
                      print('onSelected..');
                      viewModel.onAccentColorChanged(context, value);
                    },
                  ),
                ],
              ),
              FormCard(
                children: <Widget>[
                  SwitchListTile(
                    title: Text(AppLocalization.of(context).darkMode),
                    value: prefState.enableDarkMode,
                    onChanged: (value) =>
                        viewModel.onDarkModeChanged(context, value),
                    secondary: Icon(kIsWeb
                        ? Icons.lightbulb_outline
                        : FontAwesomeIcons.moon),
                    activeColor: Theme.of(context).accentColor,
                  ),
                  SwitchListTile(
                    title: Text(AppLocalization.of(context)
                        .longPressSelectionIsDefault),
                    value: prefState.longPressSelectionIsDefault,
                    onChanged: (value) =>
                        viewModel.onLongPressSelectionIsDefault(context, value),
                    secondary: Icon(kIsWeb
                        ? Icons.check_box
                        : FontAwesomeIcons.solidCheckSquare),
                    activeColor: Theme.of(context).accentColor,
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
                              ? FontAwesomeIcons.lock
                              : FontAwesomeIcons.unlockAlt),
                          activeColor: Theme.of(context).accentColor,
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                  viewModel.state.company.isModuleEnabled(EntityType.task)
                      ? SwitchListTile(
                          title:
                              Text(AppLocalization.of(context).autoStartTasks),
                          value: prefState.autoStartTasks,
                          onChanged: (value) =>
                              viewModel.onAutoStartTasksChanged(context, value),
                          secondary: Icon(
                              kIsWeb ? Icons.timer : FontAwesomeIcons.clock),
                          activeColor: Theme.of(context).accentColor,
                        )
                      : SizedBox(),
                ],
              ),
              if (!Config.DEMO_MODE)
                FormCard(
                  children: <Widget>[
                    Builder(builder: (BuildContext context) {
                      return ListTile(
                        leading: Icon(
                            kIsWeb ? Icons.refresh : FontAwesomeIcons.syncAlt),
                        title: Text(AppLocalization.of(context).refreshData),
                        onTap: () {
                          viewModel.onRefreshTap(context);
                        },
                      );
                    }),
                    ListTile(
                      leading: Icon(kIsWeb
                          ? Icons.power_settings_new
                          : FontAwesomeIcons.powerOff),
                      title: Text(AppLocalization.of(context).logout),
                      onTap: () {
                        viewModel.onLogoutTap(context);
                      },
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
