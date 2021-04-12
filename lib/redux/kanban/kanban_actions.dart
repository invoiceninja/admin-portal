import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewKanban extends AbstractNavigatorAction implements PersistUI {
  ViewKanban({
    @required NavigatorState navigator,
    this.force = false,
  }) : super(navigator: navigator);

  final bool force;
}
