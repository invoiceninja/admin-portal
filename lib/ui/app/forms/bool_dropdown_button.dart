import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class BoolDropdownButton extends StatelessWidget {
  const BoolDropdownButton({
    @required this.label,
    @required this.value,
    @required this.onChanged,
    @required this.showBlank,
    this.enabledLabel,
    this.disabledLabel,
  });

  final String label;
  final bool value;
  final Function(bool) onChanged;
  final bool showBlank;
  final String enabledLabel;
  final String disabledLabel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final trueLabel = enabledLabel ?? localization.enabled;
    final falseLabel = disabledLabel ?? localization.disabled;

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
                      child: Text(trueLabel),
                      value: false,
                    ),
                    DropdownMenuItem(
                      child: Text(falseLabel),
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
                    child: Text(falseLabel),
                    onTap: () => onChanged(false),
                  ),
                  Radio<bool>(
                    value: true,
                    onChanged: (value) => onChanged(value),
                    groupValue: value,
                    activeColor: Theme.of(context).accentColor,
                  ),
                  GestureDetector(
                    child: Text(trueLabel),
                    onTap: () => onChanged(true),
                  ),
                ],
              ));
  }
}
