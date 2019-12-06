import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewDashboard extends AbstractNavigatorAction implements PersistUI {
  ViewDashboard({
    @required NavigatorState navigator,
    this.force = false,
  }) : super(navigator: navigator);

  final bool force;
}

class UpdateDashboardSettings implements PersistUI {
  UpdateDashboardSettings({this.settings, this.offset, this.currencyId});

  DashboardSettings settings;
  int offset;
  String currencyId;
}
