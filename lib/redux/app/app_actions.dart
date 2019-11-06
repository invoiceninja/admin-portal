import 'dart:async';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/static/static_data_model.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';

class PersistUI {}

class PersistData {}

class PersistStatic {}

class RefreshClient {
  RefreshClient(this.clientId);

  final String clientId;
}

class UpdateSidebar implements PersistUI {
  UpdateSidebar(this.sidebar);

  final AppSidebar sidebar;
}

class UpdateLayout implements PersistUI {
  UpdateLayout(this.layout);

  final AppLayout layout;
}

class ViewMainScreen {
  ViewMainScreen(this.context);

  BuildContext context;
}

class StartLoading {}

class StopLoading {}

class StartSaving {}

class StopSaving {}

class LoadStaticSuccess implements PersistStatic {
  LoadStaticSuccess({this.data});

  final StaticDataEntity data;
}

class UserSettingsChanged implements PersistUI {
  UserSettingsChanged({
    this.enableDarkMode,
    this.emailPayment,
    this.requireAuthentication,
    this.autoStartTasks,
    this.longPressSelectionIsDefault,
    this.addDocumentsToInvoice,
    this.accentColor,
  });

  final bool enableDarkMode;
  final bool longPressSelectionIsDefault;
  final bool emailPayment;
  final bool requireAuthentication;
  final bool autoStartTasks;
  final bool addDocumentsToInvoice;
  final String accentColor;
}

class LoadAccountSuccess {
  LoadAccountSuccess(
      {this.loginResponse, this.completer, this.loadCompanies = true});

  final Completer completer;
  final LoginResponse loginResponse;
  final bool loadCompanies;
}

class RefreshData {
  RefreshData({this.platform, this.completer, this.loadCompanies = true});

  final String platform;
  final Completer completer;
  final bool loadCompanies;
}

class ClearLastError {}

class DiscardChanges {}

class FilterCompany {
  FilterCompany(this.filter);

  final String filter;
}
