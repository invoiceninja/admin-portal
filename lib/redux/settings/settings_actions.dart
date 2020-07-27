import 'dart:async';

import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewSettings extends AbstractNavigatorAction
    implements PersistUI {
  ViewSettings({
    @required NavigatorState navigator,
    this.company,
    this.group,
    this.client,
    this.user,
    this.force = false,
    this.section,
  }) : super(navigator: navigator);

  final CompanyEntity company;
  final GroupEntity group;
  final ClientEntity client;
  final UserEntity user;
  final bool force;
  final String section;
}

class ClearSettingsFilter implements PersistUI {}

class ResetSettings {}

class UpdateSettings implements PersistUI {
  UpdateSettings({@required this.settings});

  final SettingsEntity settings;
}

class UpdateUserSettings implements PersistUI {
  UpdateUserSettings({@required this.user});

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

class SaveUserSettingsRequest implements StartSaving {
  SaveUserSettingsRequest({
    @required this.completer,
    @required this.user,
  });

  final Completer completer;
  final UserEntity user;
}

class SaveUserSettingsSuccess implements StopSaving, PersistData, PersistUI {
  SaveUserSettingsSuccess(this.userCompany);

  final UserCompanyEntity userCompany;
}

class SaveUserSettingsFailure implements StopSaving {
  SaveUserSettingsFailure(this.error);

  final Object error;
}

class SaveAuthUserRequest implements StartSaving {
  SaveAuthUserRequest({
    @required this.completer,
    @required this.user,
    this.password,
  });

  final Completer completer;
  final UserEntity user;
  final String password;
}

class SaveAuthUserSuccess implements StopSaving, PersistData, PersistUI {
  SaveAuthUserSuccess(this.user);

  final UserEntity user;
}

class SaveAuthUserFailure implements StopSaving {
  SaveAuthUserFailure(this.error);

  final Object error;
}

class FilterSettings implements PersistUI {
  FilterSettings(this.filter);

  final String filter;
}
