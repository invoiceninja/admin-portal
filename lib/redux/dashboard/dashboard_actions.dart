import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_actions.dart';

class ViewDashboard implements PersistUI {
  final BuildContext context;
  ViewDashboard([this.context]);
}

class LoadDashboard {
  final Completer completer;
  final bool force;

  LoadDashboard([this.completer, this.force = false]);
}

class LoadDashboardRequest implements StartLoading {}

class LoadDashboardFailure implements StopLoading {
  final dynamic error;

  LoadDashboardFailure(this.error);

  @override
  String toString() {
    return 'LoadDashboardFailure{error: $error}';
  }
}

class LoadDashboardSuccess implements StopLoading, PersistData {
  final DashboardEntity data;

  LoadDashboardSuccess(this.data);

  @override
  String toString() {
    return 'DashboardEntity{data: $data}';
  }
}
