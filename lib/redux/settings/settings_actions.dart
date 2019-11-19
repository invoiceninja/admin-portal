import 'dart:async';

import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewSettings extends AbstractNavigatorAction implements PersistUI {
  ViewSettings({
    @required NavigatorState navigator,
    this.userCompany,
    this.group,
    this.client,
    this.force = false,
    this.section,
  }) : super(navigator: navigator);

  final UserCompanyEntity userCompany;
  final GroupEntity group;
  final ClientEntity client;
  final bool force;
  final String section;
}

class ClearSettingsFilter {}

class ResetSettings {}

class UpdateSettings implements PersistUI {
  UpdateSettings({@required this.settings});

  final SettingsEntity settings;
}

class UpdateSettingsUser implements PersistUI {
  UpdateSettingsUser({@required this.user});

  final UserEntity user;
}

class UploadLogoRequest implements StartSaving {
  UploadLogoRequest({this.completer, this.path, this.type});

  final Completer completer;
  final String path;
  final EntityType type;
}

class UploadLogoFailure implements StopSaving {
  UploadLogoFailure(this.error);

  final Object error;
}

class SaveUserRequest implements StartSaving {
  SaveUserRequest({this.completer, this.user});

  final Completer completer;
  final UserEntity user;
}

class SaveUserSuccess implements StopSaving, PersistData, PersistUI {
  SaveUserSuccess(this.user);

  final UserEntity user;
}

class SaveUserFailure implements StopSaving {
  SaveUserFailure(this.error);

  final Object error;
}

class FilterSettings implements PersistUI {
  FilterSettings(this.filter);

  final String filter;
}
