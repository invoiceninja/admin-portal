import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class AppDropdownButton<T> extends StatelessWidget {
  const AppDropdownButton({
    @required this.labelText,
    @required this.value,
    @required this.onChanged,
    @required this.items,
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

    return InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: EdgeInsets.only(right: 12, top: 12, bottom: 12),
        ),
        isEmpty: value == null || value == '',
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            isExpanded: true,
            isDense: true,
            onChanged: enabled ? onChanged : null,
            items: [
              if (_showBlank || value == '')
                DropdownMenuItem(
                  value: blankValue,
                  child: SizedBox(),
                ),
              ...items
            ],
          ),
        ));
  }
}
