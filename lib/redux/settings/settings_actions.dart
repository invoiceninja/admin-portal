import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewSettings implements PersistUI {
  ViewSettings({
    @required this.context,
    @required this.company,
    this.force = false,
    this.section,
  });

  final CompanyEntity company;
  final BuildContext context;
  final bool force;
  final String section;
}
