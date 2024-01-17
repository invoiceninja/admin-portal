// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class BoolDropdownButton extends StatelessWidget {
  const BoolDropdownButton({
    required this.value,
    required this.onChanged,
    this.label,
    this.showBlank,
    this.enabledLabel,
    this.helpLabel,
    this.disabledLabel,
    this.iconData,
    this.minWidth,
  });

  final String? label;
  final String? helpLabel;
  final bool? value;
  final Function(bool?) onChanged;
  final IconData? iconData;
  final bool? showBlank;
  final String? enabledLabel;
  final String? disabledLabel;
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final trueLabel = enabledLabel ?? localization!.enabled;
    final falseLabel = disabledLabel ?? localization!.disabled;

    final state = StoreProvider.of<AppState>(context).state;
    final _showBlank = showBlank ?? state.settingsUIState.isFiltered;

    if (!_showBlank &&
        (enabledLabel == null || enabledLabel == localization!.yes)) {
      return Padding(
        padding: const EdgeInsets.only(top: 12),
        child: SwitchListTile(
          title: Text(label ?? ''),
          value: value ?? false,
          secondary:
              iconData != null && isDesktop(context) ? Icon(iconData) : null,
          onChanged: (value) => onChanged(value),
          activeColor: Theme.of(context).colorScheme.secondary,
          subtitle: helpLabel != null ? Text(helpLabel!) : null,
        ),
      );
    }

    final widget = _showBlank
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
                  child: Text(falseLabel),
                  value: false,
                ),
                DropdownMenuItem(
                  child: Text(trueLabel),
                  value: true,
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Flex(
              direction: isDesktop(context) ? Axis.horizontal : Axis.vertical,
              children: <Widget>[
                InkWell(
                  onTap: () => onChanged(false),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: minWidth ?? 130, minHeight: 36),
                    child: Row(
                      children: [
                        IgnorePointer(
                          child: Radio<bool>(
                            value: false,
                            onChanged: (value) => null,
                            groupValue: value,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
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
                    constraints: BoxConstraints(
                        minWidth: minWidth ?? 120, minHeight: 36),
                    child: Row(
                      children: [
                        IgnorePointer(
                          child: Radio<bool>(
                            value: true,
                            onChanged: (value) => null,
                            groupValue: value,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
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
          );

    if (label == null) {
      return widget;
    }

    return InputDecorator(
        decoration: InputDecoration(
          border: _showBlank ? null : InputBorder.none,
          labelText: label,
        ),
        isEmpty: '${value ?? ''}'.isEmpty,
        child: widget);
  }
}
