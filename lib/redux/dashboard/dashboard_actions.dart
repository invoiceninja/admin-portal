import 'package:invoiceninja/data/models/models.dart';

class LoadDashboardAction {}

class DashboardNotLoadedAction {
  final dynamic error;

  DashboardNotLoadedAction(this.error);

  @override
  String toString() {
    return 'DashboardNotLoadedAction{error: $error}';
  }
}

class DashboardLoadedAction {
  final DashboardEntity data;

  DashboardLoadedAction(this.data);

  @override
  String toString() {
    return 'DashboardLoadedAction{data: $data}';
  }
}