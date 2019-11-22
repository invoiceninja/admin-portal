import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    @required this.controller,
    @required this.field,
    this.value,
  });

  final TextEditingController controller;
  final String field;
  final String value;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final CompanyEntity company = state.company;
    final localization = AppLocalization.of(context);

    final fieldLabel = company.getCustomFieldLabel(field);

    if (fieldLabel.isEmpty) {
      return SizedBox();
    }

    final fieldType = company.getCustomFieldType(field);
    final fieldOptions = company.getCustomFieldValues(field);

    switch (fieldType) {
      case kFieldTypeSingleLineText:
      case kFieldTypeMultiLineText:
        return TextFormField(
          autocorrect: false,
          controller: controller,
          keyboardType: TextInputType.text,
          maxLines: fieldType == kFieldTypeSingleLineText ? 1 : 3,
          decoration: InputDecoration(
            labelText: fieldLabel,
          ),
        );
      case kFieldTypeSwitch:
        return BoolDropdownButton(
          onChanged: (value) =>
              controller.text = value ? kSwitchValueYes : kSwitchValueNo,
          value: value == null ? null : value == kSwitchValueYes,
          label: fieldLabel,
          enabledLabel: localization.yes,
          disabledLabel: localization.no,
        );
      case kFieldTypeDate:
        return DatePicker(
          labelText: fieldLabel,
          onSelected: (date) => controller.text = date,
          selectedDate: value,
        );
      case kFieldTypeDropdown:
        return AppDropdownButton<String>(
          value: value,
          items: fieldOptions
              .map((option) => DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  ))
              .toList(),
          onChanged: (dynamic value) => controller.text = value,
          labelText: fieldLabel,
        );
      default:
        return SizedBox();
    }
  }
}
