import 'package:flutter/material.dart';
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
