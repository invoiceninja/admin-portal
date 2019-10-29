import 'dart:async';

import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewSettings implements PersistUI {
  ViewSettings({
    @required this.context,
    this.userCompany,
    this.group,
    this.client,
    this.force = false,
    this.section,
  });

  final UserCompanyEntity userCompany;
  final GroupEntity group;
  final ClientEntity client;
  final BuildContext context;
  final bool force;
  final String section;
}

class ClearSettingsFilter {}

class ResetSettings {}

class UpdateCompany implements PersistUI {
  UpdateCompany({@required this.company});
  final CompanyEntity company;
}

class UpdateSettings implements PersistUI {
  UpdateSettings({@required this.settings});
  final SettingsEntity settings;
}

class UpdateUser implements PersistUI {
  UpdateUser({@required this.user});
  final UserEntity user;
}

class SaveCompanyRequest implements StartSaving {
  SaveCompanyRequest({this.completer, this.company});

  final Completer completer;
  final CompanyEntity company;
}

class SaveCompanySuccess implements StopSaving, PersistData, PersistUI {
  SaveCompanySuccess(this.company);

  final CompanyEntity company;
}

class SaveCompanyFailure implements StopSaving {
  SaveCompanyFailure(this.error);

  final Object error;
}

class UploadLogoRequest implements StartSaving {
  UploadLogoRequest({this.completer, this.path});

  final Completer completer;
  final String path;
}

class UploadLogoSuccess implements StopSaving, PersistData, PersistUI {
  UploadLogoSuccess(this.company);

  final CompanyEntity company;
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
