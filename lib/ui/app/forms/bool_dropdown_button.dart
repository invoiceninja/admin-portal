import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class BoolDropdownButton extends StatelessWidget {
  const BoolDropdownButton({
    @required this.label,
    @required this.value,
    @required this.onChanged,
    @required this.showBlank,
    this.trueLabel,
    this.falseLabel,
  });

  final String label;
  final bool value;
  final Function(bool) onChanged;
  final bool showBlank;
  final String trueLabel;
  final String falseLabel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return InputDecorator(
        decoration: InputDecoration(
          border: showBlank ? null : InputBorder.none,
          labelText: label,
        ),
        isEmpty: value == null,
        child: showBlank
            ? DropdownButtonHideUnderline(
                child: DropdownButton<bool>(
                  value: value,
                  isExpanded: true,
                  isDense: true,
                  onChanged: (value) => onChanged(value),
                  items: [
                    DropdownMenuItem(
                      child: Text(''),
                      value: null,
                    ),
                    DropdownMenuItem(
                      child: Text(falseLabel ?? localization.disabled),
                      value: false,
                    ),
                    DropdownMenuItem(
                      child: Text(trueLabel ?? localization.enabled),
                      value: true,
                    ),
                  ].toList(),
                ),
              )
            : Row(
                children: <Widget>[
                  Radio<bool>(
                    value: false,
                    onChanged: (value) => onChanged(value),
                    groupValue: value,
                    activeColor: Theme.of(context).accentColor,
                  ),
                  GestureDetector(
                    child: Text(falseLabel ?? localization.disabled),
                    onTap: () => onChanged(false),
                  ),
                  Radio<bool>(
                    value: true,
                    onChanged: (value) => onChanged(value),
                    groupValue: value,
                    activeColor: Theme.of(context).accentColor,
                  ),
                  GestureDetector(
                    child: Text(trueLabel ?? localization.enabled),
                    onTap: () => onChanged(true),
                  ),
                ],
              ));
  }
}
