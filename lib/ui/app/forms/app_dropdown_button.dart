import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class AppDropdownButton extends StatelessWidget {
  const AppDropdownButton({
    @required this.labelText,
    @required this.value,
    @required this.onChanged,
    @required this.items,
    this.showBlank,
    this.enabled = true,
  });

  final String labelText;
  final String value;
  final Function(String) onChanged;
  final List<DropdownMenuItem<String>> items;
  final bool showBlank;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final _showBlank = showBlank ?? state.settingsUIState.isFiltered;

    return InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        isEmpty: value == null && value != '',
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            isDense: true,
            onChanged: enabled ? onChanged : null,
            items: [
              if (_showBlank || value == '')
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
