import 'package:invoiceninja_flutter/data/models/models.dart';

class SelectCompany {
  SelectCompany(this.companyIndex);

  final int companyIndex;
}

class LoadCompanySuccess {
  LoadCompanySuccess(this.company);

  final CompanyEntity company;
}
