import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewSettings implements PersistUI {
  ViewSettings({@required this.context, this.force = false});

  final BuildContext context;
  final bool force;
}
