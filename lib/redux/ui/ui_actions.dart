import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class UpdateCurrentRoute implements PersistUI {
  final String route;
  UpdateCurrentRoute(this.route);
}