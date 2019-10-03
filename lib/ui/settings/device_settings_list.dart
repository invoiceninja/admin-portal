import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/settings/device_settings_list_vm.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    //final viewModel = widget.viewModel;

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
              SwitchListTile(
                title: Text(AppLocalization.of(context).darkMode),
                value: widget.viewModel.enableDarkMode,
                onChanged: (value) =>
                    widget.viewModel.onDarkModeChanged(context, value),
                secondary: Icon(FontAwesomeIcons.moon),
                activeColor: Theme.of(context).accentColor,
              ),
              FutureBuilder(
                future: widget.viewModel.authenticationSupported,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot.data == true) {
                    return SwitchListTile(
                      title: Text(
                          AppLocalization.of(context).biometricAuthentication),
                      value: widget.viewModel.requireAuthentication,
                      onChanged: (value) => widget.viewModel
                          .onRequireAuthenticationChanged(context, value),
                      secondary: Icon(widget.viewModel.requireAuthentication
                          ? FontAwesomeIcons.lock
                          : FontAwesomeIcons.unlockAlt),
                      activeColor: Theme.of(context).accentColor,
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              widget.viewModel.state.selectedCompany
                      .isModuleEnabled(EntityType.task)
                  ? SwitchListTile(
                      title: Text(AppLocalization.of(context).autoStartTasks),
                      value: widget.viewModel.autoStartTasks,
                      onChanged: (value) => widget.viewModel
                          .onAutoStartTasksChanged(context, value),
                      secondary: Icon(FontAwesomeIcons.clock),
                      activeColor: Theme.of(context).accentColor,
                    )
                  : SizedBox(),
              ListTile(
                leading: Icon(FontAwesomeIcons.syncAlt),
                title: Text(AppLocalization.of(context).refreshData),
                onTap: () {
                  widget.viewModel.onRefreshTap(context);
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.powerOff),
                title: Text(AppLocalization.of(context).logout),
                onTap: () {
                  widget.viewModel.onLogoutTap(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
