import 'package:invoiceninja_flutter/data/models/models.dart';

class SelectCompany {
  final int companyIndex;

  SelectCompany(this.companyIndex);
}

class LoadCompanySuccess {
  final CompanyEntity company;

  LoadCompanySuccess(this.company);
}