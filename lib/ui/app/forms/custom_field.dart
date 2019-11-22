import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    @required this.controller,
    @required this.label,
    this.initialValue,
  });

  final TextEditingController controller;
  final String label;
  final String initialValue;

  String get _fieldType {
    if (label.contains('|')) {
      final value = label.split('|').last;
      if ([kFieldTypeSingleLineText, kFieldTypeDate, kFieldTypeSwitch]
          .contains(value)) {
        return value;
      } else {
        return kFieldTypeDropdown;
      }
    } else {
      return kFieldTypeMultiLineText;
    }
  }

  String get _fieldLabel {
    if (label.contains('|')) {
      return label.split('|').first;
    } else {
      return label;
    }
  }

  List<String> get _fieldOptions {
    final data = label.split('|').last.split(',');
    return data.where((data) => data.isNotEmpty).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (label == null) {
      return SizedBox();
    }

    print(
        '## BUILD: $initialValue = $label: $_fieldType $_fieldLabel $_fieldOptions');

    switch (_fieldType) {
      case kFieldTypeSingleLineText:
      case kFieldTypeMultiLineText:
        return TextFormField(
          autocorrect: false,
          controller: controller,
          keyboardType: TextInputType.text,
          maxLines: _fieldType == kFieldTypeSingleLineText ? 1 : 3,
          decoration: InputDecoration(
            labelText: _fieldLabel,
          ),
        );
      case kFieldTypeSwitch:
        return SwitchListTile(
          title: Text(_fieldLabel),
          value: initialValue == kSwitchValueYes,
          onChanged: (value) =>
              controller.text = value ? kSwitchValueYes : kSwitchValueNo,
          activeColor: Theme.of(context).accentColor,
        );
      case kFieldTypeDate:
        return DatePicker(
          labelText: _fieldLabel,
          onSelected: (date) => controller.text = date,
          selectedDate: initialValue,
        );
      case kFieldTypeDropdown:
        return PopupMenuButton<String>(
          padding: EdgeInsets.zero,
          initialValue: initialValue,
          itemBuilder: (BuildContext context) => _fieldOptions
              .map((option) => PopupMenuItem<String>(
                    value: option,
                    child: Text(option),
                  ))
              .toList(),
          onSelected: (value) => controller.text = value,
          child: InkWell(
            child: IgnorePointer(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: _fieldLabel,
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                ),
              ),
            ),
          ),
        );
      default:
        return SizedBox();
    }
  }
}
