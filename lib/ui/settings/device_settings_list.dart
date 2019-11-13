import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
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
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final uiState = viewModel.state.uiState;

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
                  FormColorPicker(
                    labelText: localization.accentColor,
                    initialValue: uiState.accentColor,
                    showClear: false,
                    onSelected: (value) =>
                        viewModel.onAccentColorChanged(context, value),
                  ),
                ],
              ),
              FormCard(
                children: <Widget>[
                  SwitchListTile(
                    title: Text(AppLocalization.of(context).darkMode),
                    value: uiState.enableDarkMode,
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
                    value: uiState.longPressSelectionIsDefault,
                    onChanged: (value) =>
                        viewModel.onLongPressSelectionIsDefault(context, value),
                    secondary: Icon(kIsWeb
                        ? Icons.check_box
                        : FontAwesomeIcons.checkSquare),
                    activeColor: Theme.of(context).accentColor,
                  ),
                  FutureBuilder(
                    future: viewModel.authenticationSupported,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData && snapshot.data == true) {
                        return SwitchListTile(
                          title: Text(AppLocalization.of(context)
                              .biometricAuthentication),
                          value: uiState.requireAuthentication,
                          onChanged: (value) => viewModel
                              .onRequireAuthenticationChanged(context, value),
                          secondary: Icon(uiState.requireAuthentication
                              ? FontAwesomeIcons.lock
                              : FontAwesomeIcons.unlockAlt),
                          activeColor: Theme.of(context).accentColor,
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                  viewModel.state.selectedCompany
                          .isModuleEnabled(EntityType.task)
                      ? SwitchListTile(
                          title:
                              Text(AppLocalization.of(context).autoStartTasks),
                          value: uiState.autoStartTasks,
                          onChanged: (value) =>
                              viewModel.onAutoStartTasksChanged(context, value),
                          secondary: Icon(
                              kIsWeb ? Icons.timer : FontAwesomeIcons.clock),
                          activeColor: Theme.of(context).accentColor,
                        )
                      : SizedBox(),
                ],
              ),
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
