import 'package:invoiceninja/redux/app/app_actions.dart';

class UpdateEntityDropdownFilter {
  final String filter;
  UpdateEntityDropdownFilter(this.filter);
}

class UpdateCurrentRoute implements PersistUI {
  final String route;
  UpdateCurrentRoute(this.route);
}