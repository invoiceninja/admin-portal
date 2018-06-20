import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_actions.dart';

class UpdateEntityDropdownFilter {
  final String filter;
  final EntityType entityType;
  UpdateEntityDropdownFilter({this.filter, this.entityType});
}

class UpdateCurrentRoute implements PersistUI {
  final String route;
  UpdateCurrentRoute(this.route);
}