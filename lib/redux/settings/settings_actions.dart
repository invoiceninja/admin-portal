import 'dart:async';

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

class UpdateSettings {
  UpdateSettings({@required this.company});
  final CompanyEntity company;
}

class SaveSettingsRequest implements StartSaving {
  SaveSettingsRequest({this.completer, this.settings});

  final Completer completer;
  final CompanyEntity settings;
}

class SaveSettingsSuccess implements StopSaving, PersistData, PersistUI {
  SaveSettingsSuccess(this.settings);

  final SettingsEntity settings;
}

class SaveSettingsFailure implements StopSaving {
  SaveSettingsFailure(this.error);

  final Object error;
}
