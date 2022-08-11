// Project imports:
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewDashboard implements PersistUI {
  ViewDashboard({
    this.force = false,
    this.filter,
  });

  final bool force;
  final String filter;
}

class UpdateDashboardSettings implements PersistUI {
  UpdateDashboardSettings({
    this.settings,
    this.offset,
    this.currencyId,
    this.includeTaxes,
    this.groupBy,
    this.showCurrentPeriod,
    this.showPreviousPeriod,
    this.showTotal,
    this.totalFields,
  });

  DashboardSettings settings;
  int offset;
  String currencyId;
  bool includeTaxes;
  String groupBy;
  bool showCurrentPeriod;
  bool showPreviousPeriod;
  bool showTotal;
  BuiltList<String> totalFields;
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
