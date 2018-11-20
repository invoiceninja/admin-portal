import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewDashboard implements PersistUI {
  ViewDashboard([this.context]);

  final BuildContext context;
}

class UpdateDashboardSettings implements PersistUI {
  UpdateDashboardSettings({this.settings, this.offset, this.currencyId});

  DashboardSettings settings;
  int offset;
  int currencyId;
}

class LoadDashboard {
  LoadDashboard([this.completer, this.force = false]);

  final Completer completer;
  final bool force;
}

class LoadDashboardRequest implements StartLoading {}

class LoadDashboardFailure implements StopLoading {
  LoadDashboardFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadDashboardFailure{error: $error}';
  }
}

class LoadDashboardSuccess implements StopLoading, PersistData {
  LoadDashboardSuccess(this.data);

  final DashboardEntity data;

  @override
  String toString() {
    return 'DashboardEntity{data: $data}';
  }
}
