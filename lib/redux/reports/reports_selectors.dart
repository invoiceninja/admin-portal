import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';

dynamic presentCustomField(
    {String? value, String? customFieldType, required CompanyEntity company}) {
  if (company.getCustomFieldType(customFieldType) == kFieldTypeSwitch)
    return value == 'yes';
  else
    return value;
}
