// Flutter imports:
import 'package:flutter/material.dart';

class AppDropdownButton<T> extends StatelessWidget {
  const AppDropdownButton({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.items,
    this.selectedItemBuilder,
    this.labelText,
    this.showBlank = false,
    this.blankValue = '',
    this.blankLabel,
    this.enabled = true,
  }) : super(key: key);

  final String? labelText;
  final dynamic value;
  final Function(dynamic)? onChanged;
  final List<DropdownMenuItem<T>> items;
  final bool showBlank;
  final bool enabled;
  final dynamic blankValue;
  final String? blankLabel;
  final DropdownButtonBuilder? selectedItemBuilder;

  @override
  Widget build(BuildContext context) {
    dynamic checkedValue = value;
    final values = items.toList().map((option) => option.value).toList();
    if (!values.contains(value)) {
      checkedValue = blankValue;
    }
    final bool isEmpty = checkedValue == null || checkedValue == '';

    Widget dropDownButton = DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: checkedValue,
        isExpanded: true,
        isDense: labelText != null,
        onChanged: enabled ? onChanged : null,
        selectedItemBuilder: selectedItemBuilder,
        items: [
          if (showBlank || isEmpty)
            DropdownMenuItem<T>(
              value: blankValue,
              child: blankLabel == null ? SizedBox() : Text(blankLabel!),
            ),
          ...items
        ],
      ),
    );

    if (labelText != null) {
      dropDownButton = InputDecorator(
          decoration: InputDecoration(
            labelText: labelText!.isEmpty ? null : labelText,
          ),
          isEmpty: isEmpty && blankLabel == null,
          child: dropDownButton);
    }

    return dropDownButton;
  }
}
