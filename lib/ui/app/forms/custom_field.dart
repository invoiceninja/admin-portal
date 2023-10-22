// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CustomField extends StatefulWidget {
  const CustomField({
    required this.field,
    this.onSavePressed,
    this.controller,
    this.onChanged,
    this.value,
    this.hideFieldLabel = false,
  });

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(BuildContext)? onSavePressed;
  final String field;
  final String? value;
  final bool hideFieldLabel;

  @override
  _CustomFieldState createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  TextEditingController? _controller;
  String? _value;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
    _controller!.text = widget.value ?? '';
    _value = widget.value;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller!.dispose();
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
        return DecoratedFormField(
          keyboardType: TextInputType.text,
          controller: _controller,
          maxLines: 1,
          label: widget.hideFieldLabel ? null : fieldLabel,
          onChanged: widget.onChanged,
          onSavePressed: widget.onSavePressed,
        );
      case kFieldTypeMultiLineText:
        return DecoratedFormField(
          controller: _controller,
          maxLines: 3,
          keyboardType: TextInputType.multiline,
          label: widget.hideFieldLabel ? null : fieldLabel,
          onChanged: widget.onChanged,
          onSavePressed: widget.onSavePressed,
        );
      case kFieldTypeSwitch:
        return BoolDropdownButton(
          onChanged: (value) {
            _controller!.text =
                value == true ? kSwitchValueYes : kSwitchValueNo;
            Debouncer.complete();
            if (widget.onChanged != null) {
              widget
                  .onChanged!(value == true ? kSwitchValueYes : kSwitchValueNo);
            }
          },
          value: widget.value == null ? null : widget.value == kSwitchValueYes,
          label: widget.hideFieldLabel ? '' : fieldLabel,
          enabledLabel: localization!.yes,
          disabledLabel: localization.no,
        );
      case kFieldTypeDate:
        return DatePicker(
          labelText: widget.hideFieldLabel ? null : fieldLabel,
          onSelected: (date, _) {
            _controller!.text = date;
            Debouncer.complete();
            if (widget.onChanged != null) {
              widget.onChanged!(date);
            }
          },
          selectedDate: widget.value,
        );
      case kFieldTypeDropdown:
        return AppDropdownButton<String>(
          value: _value,
          items: fieldOptions
              .map((option) => DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  ))
              .toList(),
          onChanged: (dynamic value) {
            setState(() {
              _controller!.text = _value = value;
            });
            Debouncer.complete();
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          labelText: widget.hideFieldLabel ? null : fieldLabel,
        );
      default:
        return SizedBox();
    }
  }
}
