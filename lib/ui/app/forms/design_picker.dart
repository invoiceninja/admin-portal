// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/design_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DesignPicker extends StatelessWidget {
  const DesignPicker({
    required this.onSelected,
    this.label,
    this.initialValue,
    this.showBlank = false,
    this.entityType,
    this.autofocus = false,
  });

  final Function(DesignEntity?) onSelected;
  final String? label;
  final String? initialValue;
  final bool showBlank;
  final bool autofocus;
  final EntityType? entityType;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final designState = state.designState;

    return AppDropdownButton<String>(
      autofocus: autofocus,
      showBlank: showBlank,
      value: initialValue,
      onChanged: (dynamic value) => onSelected(designState.map[value]),
      items: designState.list
          .where((designId) {
            final design = designState.map[designId]!;
            if (state.isHosted &&
                !state.isPaidAccount &&
                !state.account.isTrial &&
                !design.isFree) {
              return false;
            }
            if (entityType != null && !design.supportsEntityType(entityType!)) {
              return false;
            }
            return design.isActive || designId == initialValue;
          })
          .map((value) => DropdownMenuItem(
                value: value,
                child: Text(designState.map[value]!.displayName),
              ))
          .toList(),
      labelText: label ?? localization!.design,
    );
  }
}
