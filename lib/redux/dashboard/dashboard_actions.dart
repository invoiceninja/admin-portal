import 'dart:async';

import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_actions.dart';

class LoadDashboardAction {
  final Completer completer;
  final bool force;

  LoadDashboardAction([this.completer, this.force = false]);

}
class LoadDashboardRequest {}

class LoadDashboardFailure {
  final dynamic error;

  LoadDashboardFailure(this.error);

  @override
  String toString() {
    return 'LoadDashboardFailure{error: $error}';
  }
}

class LoadDashboardSuccess extends PersistData {
  final DashboardEntity data;

  LoadDashboardSuccess(this.data);

  @override
  String toString() {
    return 'DashboardEntity{data: $data}';
  }
}