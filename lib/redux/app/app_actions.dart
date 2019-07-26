import 'dart:async';
import 'package:invoiceninja_flutter/data/models/entities.dart';

class PersistUI {}

class PersistData {}

class PersistStatic {}

class RefreshClient {
  RefreshClient(this.clientId);

  final int clientId;
}

class StartLoading {}

class StopLoading {}

class StartSaving {}

class StopSaving {}

class LoadStaticSuccess implements PersistStatic {
  LoadStaticSuccess({this.data, this.version});

  final String version;
  final StaticData data;
}

class UserSettingsChanged implements PersistUI {
  UserSettingsChanged(
      {this.enableDarkMode,
      this.emailPayment,
      this.requireAuthentication,
      this.autoStartTasks,
      this.addDocumentsToInvoice});

  final bool enableDarkMode;
  final bool emailPayment;
  final bool requireAuthentication;
  final bool autoStartTasks;
  final bool addDocumentsToInvoice;
}

class LoadAccountSuccess {
  LoadAccountSuccess(
      {this.loginResponse, this.completer, this.loadCompanies = true});

  final Completer completer;
  final dynamic loginResponse;
  final bool loadCompanies;
}

class RefreshData {
  RefreshData({this.platform, this.completer, this.loadCompanies = true});

  final String platform;
  final Completer completer;
  final bool loadCompanies;
}

class FilterCompany {
  FilterCompany(this.filter);

  final String filter;
}
