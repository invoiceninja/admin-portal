import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class UpdateCurrentRoute implements PersistUI {
  UpdateCurrentRoute(this.route);

  final String route;
}
