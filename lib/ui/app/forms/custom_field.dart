import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CustomField extends StatefulWidget {
  const CustomField({
    @required this.field,
    this.controller,
    this.onChanged,
    this.value,
    this.hideFieldLabel = false,
  });

  final TextEditingController controller;
  final Function(String) onChanged;
  final String field;
  final String value;
  final bool hideFieldLabel;

  @override
  _CustomFieldState createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final CompanyEntity company = state.company;
    final localization = AppLocalization.of(context);

    final fieldLabel = company.getCustomFieldLabel(widget.field);

    if (fieldLabel.isEmpty) {
      return SizedBox();
    }

    final fieldType = company.getCustomFieldType(widget.field);
    final fieldOptions = company.getCustomFieldValues(widget.field);

    switch (fieldType) {
      case kFieldTypeSingleLineText:
      case kFieldTypeMultiLineText:
        return DecoratedFormField(
          controller: _controller,
          maxLines: fieldType == kFieldTypeSingleLineText ? 1 : 3,
          label: widget.hideFieldLabel ? null : fieldLabel,
          onChanged: widget.onChanged,
        );
      case kFieldTypeSwitch:
        return BoolDropdownButton(
          onChanged: (value) {
            _controller.text = value ? kSwitchValueYes : kSwitchValueNo;
            if (widget.onChanged != null) {
              widget.onChanged(value ? kSwitchValueYes : kSwitchValueNo);
            }
          },
          value: widget.value == null ? null : widget.value == kSwitchValueYes,
          label: widget.hideFieldLabel ? '' : fieldLabel,
          enabledLabel: localization.yes,
          disabledLabel: localization.no,
        );
      case kFieldTypeDate:
        return DatePicker(
          labelText: widget.hideFieldLabel ? null : fieldLabel,
          onSelected: (date) {
            _controller.text = date;
            if (widget.onChanged != null) {
              widget.onChanged(date);
            }
          },
          selectedDate: widget.value,
        );
      case kFieldTypeDropdown:
        return AppDropdownButton<String>(
          value: widget.value,
          items: fieldOptions
              .map((option) => DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  ))
              .toList(),
          onChanged: (dynamic value) {
            _controller.text = value;
            if (widget.onChanged != null) {
              widget.onChanged(value);
            }
          },
          labelText: widget.hideFieldLabel ? null : fieldLabel,
        );
      default:
        return SizedBox();
    }
  }
}
