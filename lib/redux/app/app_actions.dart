import 'dart:async';
import 'package:invoiceninja_flutter/data/models/entities.dart';

class PersistUI {}

class PersistData {}

class RefreshClient {
  RefreshClient(this.clientId);

  final int clientId;
}

class StartLoading {}

class StopLoading {}

class StartSaving {}

class StopSaving {}

class LoadStaticSuccess {
  LoadStaticSuccess(this.data);

  final StaticData data;
}

class UserSettingsChanged implements PersistUI {
  UserSettingsChanged(
      {this.enableDarkMode,
      this.emailPayment,
      this.requireAuthentication,
      this.manualTimer});

  final bool enableDarkMode;
  final bool emailPayment;
  final bool requireAuthentication;
  final bool manualTimer;
}

class LoadDataSuccess {
  LoadDataSuccess({this.loginResponse, this.completer});

  final Completer completer;
  final dynamic loginResponse;
}

class RefreshData {
  RefreshData({this.platform, this.completer});

  final String platform;
  final Completer completer;
}

class FilterCompany {
  FilterCompany(this.filter);

  final String filter;
}
