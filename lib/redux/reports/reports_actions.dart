import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewReports extends AbstractNavigatorAction implements PersistUI {
  ViewReports({
    @required NavigatorState navigator,
    this.report,
    this.force = false,
  }) : super(navigator: navigator);

  final bool force;
  final String report;
}

class UpdateReportSettings implements PersistUI {
  UpdateReportSettings({
    this.report,
    this.dateRange,
    this.customStartDate,
    this.customEndDate,
    this.currencyId,
  });

  final String report;
  final DateRange dateRange;
  final String customStartDate;
  final String customEndDate;
  final String currencyId;
}
