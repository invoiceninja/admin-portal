import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewDashboard extends AbstractNavigatorAction implements PersistUI {
  ViewDashboard({
    @required NavigatorState navigator,
    this.force = false,
    this.filter,
  }) : super(navigator: navigator);

  final bool force;
  final String filter;
}

class UpdateDashboardSettings implements PersistUI {
  UpdateDashboardSettings({
    this.settings,
    this.offset,
    this.currencyId,
    this.includeTaxes,
  });

  DashboardSettings settings;
  int offset;
  String currencyId;
  bool includeTaxes;
}

class UpdateDashboardSelection implements PersistUI {
  UpdateDashboardSelection({
    this.entityType,
    this.entityIds,
  });

  EntityType entityType;
  List<String> entityIds;
}

class UpdateDashboardEntityType implements PersistUI {
  UpdateDashboardEntityType({this.entityType});

  EntityType entityType;
}

class UpdateDashboardSidebar implements PersistUI {
  UpdateDashboardSidebar({this.showSidebar});

  bool showSidebar;
}
