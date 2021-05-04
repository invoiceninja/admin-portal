import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class BoolDropdownButton extends StatelessWidget {
  const BoolDropdownButton({
    @required this.label,
    @required this.value,
    @required this.onChanged,
    this.showBlank,
    this.enabledLabel,
    this.helpLabel,
    this.disabledLabel,
    this.iconData,
  });

  final String label;
  final String helpLabel;
  final bool value;
  final Function(bool) onChanged;
  final IconData iconData;
  final bool showBlank;
  final String enabledLabel;
  final String disabledLabel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final trueLabel = enabledLabel ?? localization.enabled;
    final falseLabel = disabledLabel ?? localization.disabled;

    final state = StoreProvider.of<AppState>(context).state;
    final _showBlank = showBlank ?? state.settingsUIState.isFiltered;

    if (!_showBlank &&
        (enabledLabel == null || enabledLabel == localization.yes)) {
      return Padding(
        padding: const EdgeInsets.only(top: 12),
        child: SwitchListTile(
          title: Text(label),
          value: value ?? false,
          secondary:
              iconData != null && isDesktop(context) ? Icon(iconData) : null,
          onChanged: (value) => onChanged(value),
          activeColor: Theme.of(context).accentColor,
          subtitle: helpLabel != null ? Text(helpLabel) : null,
        ),
      );
    }

    return InputDecorator(
        decoration: InputDecoration(
          border: _showBlank ? null : InputBorder.none,
          labelText: label,
        ),
        isEmpty: '${value ?? ''}'.isEmpty && !state.settingsUIState.isFiltered,
        child: _showBlank
            ? DropdownButtonHideUnderline(
                child: DropdownButton<bool>(
                  value: value,
                  isExpanded: true,
                  isDense: true,
                  onChanged: (value) => onChanged(value),
                  items: [
                    DropdownMenuItem(
                      child: Text(state.settingsUIState.isFiltered
                          ? localization.useDefault
                          : ''),
                      value: null,
                    ),
                    DropdownMenuItem(
                      child: Text(falseLabel),
                      value: false,
                    ),
                    DropdownMenuItem(
                      child: Text(trueLabel),
                      value: true,
                    ),
                  ].toList(),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Flex(
                  direction:
                      isDesktop(context) ? Axis.horizontal : Axis.vertical,
                  children: <Widget>[
                    InkWell(
                      onTap: () => onChanged(false),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minWidth: 125, minHeight: 36),
                        child: Row(
                          children: [
                            IgnorePointer(
                              child: Radio<bool>(
                                value: false,
                                onChanged: (value) => null,
                                groupValue: value,
                                activeColor: Theme.of(context).accentColor,
                              ),
                            ),
                            Text(falseLabel),
                            SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => onChanged(true),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minWidth: 125, minHeight: 36),
                        child: Row(
                          children: [
                            IgnorePointer(
                              child: Radio<bool>(
                                value: true,
                                onChanged: (value) => null,
                                groupValue: value,
                                activeColor: Theme.of(context).accentColor,
                              ),
                            ),
                            Text(trueLabel),
                            SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
