import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class AppDropdownButton<T> extends StatelessWidget {
  const AppDropdownButton({
    @required this.value,
    @required this.onChanged,
    @required this.items,
    this.labelText,
    this.showBlank,
    this.blankValue = '',
    this.enabled = true,
  });

  final String labelText;
  final dynamic value;
  final Function(dynamic) onChanged;
  final List<DropdownMenuItem<T>> items;
  final bool showBlank;
  final bool enabled;
  final dynamic blankValue;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final _showBlank = showBlank ?? state.settingsUIState.isFiltered;

    dynamic checkedValue = value;
    final values = items.toList().map((option) => option.value).toList();
    if (!values.contains(value)) {
      checkedValue = blankValue;
    }
    final bool isEmpty = checkedValue == null || checkedValue == '';

    final dropDownButton = DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: checkedValue,
        isExpanded: true,
        isDense: labelText != null,
        onChanged: enabled ? onChanged : null,
        items: [
          if (_showBlank || isEmpty)
            DropdownMenuItem(
              value: blankValue,
              child: SizedBox(),
            ),
          ...items
        ],
      ),
    );

    if (labelText != null) {
      return InputDecorator(
          decoration: InputDecoration(
            labelText: labelText,
            contentPadding: EdgeInsets.only(right: 12, top: 12, bottom: 12),
          ),
          isEmpty: isEmpty,
          child: dropDownButton);
    } else {
      return dropDownButton;
    }
  }
}
