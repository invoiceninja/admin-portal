// Dart imports:
import 'dart:async';

// Flutter imports:

// Package imports:
import 'package:http/http.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/settings_model.dart';
import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';

class ViewSettings implements PersistUI {
  ViewSettings({
    this.company,
    this.group,
    this.client,
    this.user,
    this.force = false,
    this.clearFilter = false,
    this.section,
    this.tabIndex,
  });

  final CompanyEntity? company;
  final GroupEntity? group;
  final ClientEntity? client;
  final UserEntity? user;
  final bool force;
  final String? section;
  final bool clearFilter;
  final int? tabIndex;
}

class ClearSettingsFilter implements PersistUI {}

class ResetSettings {}

class UpdateSettings implements PersistUI {
  UpdateSettings({required this.settings});

  final SettingsEntity settings;
}

class UpdateSettingsTab implements PersistUI {
  UpdateSettingsTab({required this.tabIndex});

  final int tabIndex;
}

class UpdatedSetting implements PersistUI {}

class UpdatedSettingUI implements PersistUI {}

class UpdateSettingsTemplate implements PersistUI {
  UpdateSettingsTemplate({required this.selectedTemplate});

  final EmailTemplate selectedTemplate;
}

class UpdateUserSettings implements PersistUI {
  UpdateUserSettings({required this.user});

  final UserEntity user;
}

class UploadLogoRequest implements StartSaving {
  UploadLogoRequest({this.completer, required this.multipartFile, this.type});

  final Completer? completer;
  final MultipartFile multipartFile;
  final EntityType? type;
}

class UploadLogoFailure implements StopSaving {
  UploadLogoFailure(this.error);

  final Object error;
}

class SaveUserSettingsRequest implements StartSaving {
  SaveUserSettingsRequest({
    required this.completer,
    required this.user,
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
    required this.user,
    this.completer,
    this.password,
    this.idToken,
  });

  final Completer? completer;
  final UserEntity user;
  final String? password;
  final String? idToken;
}

class SaveAuthUserSuccess
    implements StopSaving, PersistData, PersistUI, UserVerifiedPassword {
  SaveAuthUserSuccess(this.user);

  final UserEntity user;
}

class SaveAuthUserFailure implements StopSaving {
  SaveAuthUserFailure(this.error);

  final Object error;
}

class ConnecOAuthUserRequest implements StartSaving {
  ConnecOAuthUserRequest({
    required this.provider,
    required this.idToken,
    required this.accessToken,
    this.completer,
    this.password,
  });

  final Completer? completer;
  final String provider;
  final String? password;
  final String idToken;
  final String accessToken;
}

class ConnectOAuthUserSuccess
    implements StopSaving, PersistData, PersistUI, UserVerifiedPassword {
  ConnectOAuthUserSuccess(this.user);

  final UserEntity user;
}

class ConnecOAuthUserFailure implements StopSaving {
  ConnecOAuthUserFailure(this.error);

  final Object error;
}

class DisconnecOAuthUserRequest implements StartSaving {
  DisconnecOAuthUserRequest({
    required this.user,
    required this.idToken,
    required this.completer,
    required this.password,
  });

  final UserEntity? user;
  final Completer completer;
  final String? password;
  final String? idToken;
}

class DisconnectOAuthUserSuccess
    implements StopSaving, PersistData, PersistUI, UserVerifiedPassword {
  DisconnectOAuthUserSuccess(this.user);

  final UserEntity user;
}

class DisconnecOAuthUserFailure implements StopSaving {
  DisconnecOAuthUserFailure(this.error);

  final Object error;
}

class DisconnectOAuthMailerRequest implements StartSaving {
  DisconnectOAuthMailerRequest({
    required this.completer,
    required this.idToken,
    required this.password,
    required this.user,
  });
  final Completer completer;
  final String? password;
  final String? idToken;
  final UserEntity? user;
}

class DisconnectOAuthMailerSuccess
    implements StopSaving, PersistData, PersistUI, UserVerifiedPassword {
  DisconnectOAuthMailerSuccess(this.user);

  final UserEntity user;
}

class DisconnectOAuthMailerFailure implements StopSaving {
  DisconnectOAuthMailerFailure(this.error);

  final Object error;
}

class DisableTwoFactorRequest implements StartSaving {
  DisableTwoFactorRequest({
    required this.completer,
    required this.idToken,
    required this.password,
  });

  final Completer completer;
  final String? password;
  final String? idToken;
}

class DisableTwoFactorSuccess
    implements StopSaving, PersistData, UserVerifiedPassword {}

class DisableTwoFactorFailure implements StopSaving {
  DisableTwoFactorFailure(this.error);

  final Object error;
}

class ConnecGmailUserRequest implements StartSaving {
  ConnecGmailUserRequest({
    required this.serverAuthCode,
    required this.idToken,
    this.completer,
    this.password,
  });

  final Completer? completer;
  final String idToken;
  final String? password;
  final String serverAuthCode;
}

class ConnecGmailUserSuccess
    implements StopSaving, PersistData, PersistUI, UserVerifiedPassword {
  ConnecGmailUserSuccess(this.user);

  final UserEntity user;
}

class ConnecGmailUserFailure implements StopSaving {
  ConnecGmailUserFailure(this.error);

  final Object error;
}

class FilterSettings implements PersistUI {
  FilterSettings(this.filter);

  final String? filter;
}

class ToggleShowNewSettings {}

class ToggleShowPdfPreview {}
