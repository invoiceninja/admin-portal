import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';

class CustomSurcharges extends StatelessWidget {
  const CustomSurcharges({
    @required this.surcharge1Controller,
    @required this.surcharge2Controller,
    @required this.surcharge3Controller,
    @required this.surcharge4Controller,
    this.isAfterTaxes = false,
  });

  final TextEditingController surcharge1Controller;
  final TextEditingController surcharge2Controller;
  final TextEditingController surcharge3Controller;
  final TextEditingController surcharge4Controller;
  final bool isAfterTaxes;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final CompanyEntity company = state.company;

    return Column(
      children: <Widget>[
        if (company.hasCustomField(CustomFieldType.surcharge1) &&
            ((isAfterTaxes && company.enableCustomSurchargeTaxes1) ||
                (!isAfterTaxes && !company.enableCustomSurchargeTaxes1)))
          DecoratedFormField(
            label: company.getCustomFieldLabel(CustomFieldType.surcharge1),
            controller: surcharge1Controller,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        if (company.hasCustomField(CustomFieldType.surcharge2) &&
            ((isAfterTaxes && company.enableCustomSurchargeTaxes2) ||
                (!isAfterTaxes && !company.enableCustomSurchargeTaxes2)))
          DecoratedFormField(
            controller: surcharge2Controller,
            label: company.getCustomFieldLabel(CustomFieldType.surcharge2),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        if (company.hasCustomField(CustomFieldType.surcharge3) &&
            ((isAfterTaxes && company.enableCustomSurchargeTaxes3) ||
                (!isAfterTaxes && !company.enableCustomSurchargeTaxes3)))
          DecoratedFormField(
            controller: surcharge3Controller,
            label: company.getCustomFieldLabel(CustomFieldType.surcharge3),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        if (company.hasCustomField(CustomFieldType.surcharge4) &&
            ((isAfterTaxes && company.enableCustomSurchargeTaxes4) ||
                (!isAfterTaxes && !company.enableCustomSurchargeTaxes4)))
          DecoratedFormField(
            controller: surcharge4Controller,
            label: company.getCustomFieldLabel(CustomFieldType.surcharge4),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
      ],
    );
  }
}
