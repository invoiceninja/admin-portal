import 'package:invoiceninja/data/models/models.dart';

class SelectCompany {
  final int companyId;

  SelectCompany(this.companyId);
}

class LoadCompanySuccess {
  final CompanyEntity company;

  LoadCompanySuccess(this.company);
}