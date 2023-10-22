// Flutter imports:

// Package imports:
import 'package:built_collection/built_collection.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewReports implements PersistUI {
  ViewReports({
    this.report,
    this.force = false,
  });

  final bool force;
  final String? report;
}

class UpdateReportSettings implements PersistUI {
  UpdateReportSettings({
    required this.report,
    this.filters,
    this.chart,
    this.group,
    this.selectedGroup,
    this.subgroup,
    this.sortColumn,
    this.sortTotalsIndex,
    this.customStartDate,
    this.customEndDate,
  });

  final String report;
  final BuiltMap<String?, String?>? filters;
  final String? group;
  final String? selectedGroup;
  final String? chart;
  final String? subgroup;
  final String? sortColumn;
  final int? sortTotalsIndex;
  final String? customStartDate;
  final String? customEndDate;
}
