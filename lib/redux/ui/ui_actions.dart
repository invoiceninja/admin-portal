import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_actions.dart';

class UpdateCurrentRoute implements PersistUI {
  final String route;
  UpdateCurrentRoute(this.route);
}