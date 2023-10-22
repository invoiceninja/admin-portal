// Project imports:
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewDashboard implements PersistUI {
  ViewDashboard({
    this.force = false,
    this.filter,
  });

  final bool force;
  final String? filter;
}

class UpdateDashboardSettings implements PersistUI {
  UpdateDashboardSettings({
    this.settings,
    this.offset,
    this.currencyId,
    this.includeTaxes,
    this.groupBy,
  });

  DashboardSettings? settings;
  int? offset;
  String? currencyId;
  bool? includeTaxes;
  String? groupBy;
}

class UpdateDashboardFields implements PersistUI {
  UpdateDashboardFields({
    this.dashboardFields,
  });

  BuiltList<DashboardField>? dashboardFields;
}

class UpdateDashboardFieldSettingss implements PersistUI {
  UpdateDashboardFieldSettingss({
    this.numberFieldsPerRowMobile,
    this.numberFieldsPerRowDesktop,
  });

  final int? numberFieldsPerRowMobile;
  final int? numberFieldsPerRowDesktop;
}

class UpdateDashboardSelection implements PersistUI {
  UpdateDashboardSelection({
    this.entityType,
    this.entityIds,
  });

  EntityType? entityType;
  List<String>? entityIds;
}

class UpdateDashboardEntityType implements PersistUI {
  UpdateDashboardEntityType({this.entityType});

  EntityType? entityType;
}

class UpdateDashboardSidebar implements PersistUI {
  UpdateDashboardSidebar({this.showSidebar});

  bool? showSidebar;
}
