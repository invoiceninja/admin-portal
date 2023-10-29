// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:http/http.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';

class SelectCompany implements ClearClientMultiselect {
  SelectCompany({
    required this.companyIndex,
    this.clearSelection = true,
  });

  final int companyIndex;
  final bool clearSelection;
}

class LoadCompanySuccess {
  LoadCompanySuccess(this.userCompany);

  final UserCompanyEntity userCompany;
}

class UpdateCompany implements PersistUI {
  UpdateCompany({required this.company});

  final CompanyEntity company;
}

class SaveCompanyRequest implements StartSaving {
  SaveCompanyRequest({
    this.completer,
    this.company,
  });

  final Completer? completer;
  final CompanyEntity? company;
}

class SaveCompanySuccess implements StopSaving, PersistData, PersistUI {
  SaveCompanySuccess(this.company);

  final CompanyEntity company;
}

class SaveCompanyFailure implements StopSaving {
  SaveCompanyFailure(this.error);

  final Object error;
}

class SaveEInvoiceCertificateRequest implements StartSaving {
  SaveEInvoiceCertificateRequest({
    required this.completer,
    required this.company,
    required this.eInvoiceCertificate,
  });

  final Completer completer;
  final CompanyEntity company;
  final MultipartFile eInvoiceCertificate;
}

class SaveEInvoiceCertificateSuccess
    implements StopSaving, PersistData, PersistUI {
  SaveEInvoiceCertificateSuccess(this.company);

  final CompanyEntity company;
}

class SaveEInvoiceCertificateFailure implements StopSaving {
  SaveEInvoiceCertificateFailure(this.error);

  final Object error;
}

class AddCompany implements StartSaving {
  AddCompany({this.context, this.completer});

  final BuildContext? context;
  final Completer? completer;
}

class AddCompanySuccess implements StopSaving {}

class DeleteCompanyRequest implements StartSaving {
  DeleteCompanyRequest({
    required this.completer,
    required this.password,
    required this.idToken,
    required this.reason,
  });

  final Completer completer;
  final String password;
  final String idToken;
  final String reason;
}

class DeleteCompanySuccess implements StopSaving, PersistData {}

class DeleteCompanyFailure implements StopSaving {
  DeleteCompanyFailure(this.error);

  final Object error;
}

class PurgeDataRequest implements StartSaving {
  PurgeDataRequest({
    required this.completer,
    required this.password,
    required this.idToken,
  });

  final Completer completer;
  final String password;
  final String idToken;
}

class PurgeDataSuccess implements StopSaving, PersistData {
  PurgeDataSuccess();
}

class PurgeDataFailure implements StopSaving {
  PurgeDataFailure(this.error);

  final Object error;
}

class UpdateCompanyLanguage {
  UpdateCompanyLanguage({this.languageId});

  final String? languageId;
}

class SaveCompanyDocumentRequest implements StartSaving {
  SaveCompanyDocumentRequest({
    required this.isPrivate,
    required this.completer,
    required this.multipartFiles,
  });

  final bool isPrivate;
  final Completer completer;
  final List<MultipartFile> multipartFiles;
}

class SaveCompanyDocumentSuccess implements StopSaving, PersistData, PersistUI {
  SaveCompanyDocumentSuccess(this.document);

  final DocumentEntity document;
}

class SaveCompanyDocumentFailure implements StopSaving {
  SaveCompanyDocumentFailure(this.error);

  final Object error;
}

class SetDefaultCompanyRequest implements StartSaving {
  SetDefaultCompanyRequest({
    required this.completer,
  });

  final Completer completer;
}

class SetDefaultCompanySuccess implements StopSaving {}

class SetDefaultCompanyFailure implements StopSaving {
  SetDefaultCompanyFailure(this.error);

  final Object error;
}
