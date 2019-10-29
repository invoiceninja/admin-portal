import 'package:flutter/material.dart';

class AppDropdownButton extends StatelessWidget {
  const AppDropdownButton({
    @required this.labelText,
    @required this.value,
    @required this.onChanged,
    @required this.items,
  });

  final String labelText;
  final String value;
  final Function(String) onChanged;
  final List<DropdownMenuItem<String>> items;

  @override
  Widget build(BuildContext context) {
    print('Value: $labelText $value');

    return InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            isDense: true,
            onChanged: onChanged,
            items: [
              DropdownMenuItem(
                value: '',
                child: SizedBox(),
              ),
              ...items
            ],
          ),
        ));
  }
}
