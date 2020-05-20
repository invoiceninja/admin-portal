import 'dart:async';

import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class SelectCompany {
  SelectCompany(this.companyIndex);

  final int companyIndex;
}

class LoadCompanySuccess {
  LoadCompanySuccess(this.userCompany);

  final UserCompanyEntity userCompany;
}

class UpdateCompany implements PersistUI {
  UpdateCompany({@required this.company});

  final CompanyEntity company;
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

class AddCompany {
  AddCompany(this.context);
  final BuildContext context;
}

class DeleteCompanyRequest implements StartSaving {
  DeleteCompanyRequest({@required this.completer, @required this.password});

  final Completer completer;
  final String password;
}

class DeleteCompanySuccess implements StopSaving, PersistData {
  DeleteCompanySuccess();
}

class DeleteCompanyFailure implements StopSaving {
  DeleteCompanyFailure(this.error);

  final Object error;
}

class PurgeDataRequest implements StartSaving {
  PurgeDataRequest({@required this.completer, @required this.password});

  final Completer completer;
  final String password;
}

class PurgeDataSuccess implements StopSaving, PersistData {
  PurgeDataSuccess();
}

class PurgeDataFailure implements StopSaving {
  PurgeDataFailure(this.error);

  final Object error;
}
