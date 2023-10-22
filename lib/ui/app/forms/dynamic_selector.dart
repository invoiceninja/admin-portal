// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DynamicSelector extends StatelessWidget {
  const DynamicSelector({
    Key? key,
    this.entityId,
    this.entityType,
    this.entityIds,
    this.onChanged,
    this.overrideSuggestedAmount,
    this.overrideSuggestedLabel,
    this.onAddPressed,
    this.allowClearing = true,
    this.labelText,
  }) : super(key: key);

  final String? labelText;
  final bool allowClearing;
  final String? entityId;
  final List<String?>? entityIds;
  final EntityType? entityType;
  final Function(String)? onChanged;
  final Function(SelectableEntity)? overrideSuggestedAmount;
  final Function(SelectableEntity?)? overrideSuggestedLabel;
  final Function(Completer<SelectableEntity> completer)? onAddPressed;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final entityMap = state.getEntityMap(entityType);

    if (!state.company.isModuleEnabled(entityType)) {
      return SizedBox();
    }

    if (entityIds!.length < 10) {
      return AppDropdownButton(
        labelText: labelText ?? localization!.lookup('$entityType'),
        value: entityId,
        showBlank: allowClearing,
        onChanged: (dynamic entityId) => onChanged!(entityId),
        items: entityIds!
            .map((entityId) => DropdownMenuItem(
                  child: Text(overrideSuggestedLabel != null
                      ? overrideSuggestedLabel!(entityMap![entityId])
                      : entityMap![entityId]?.listDisplayName ?? ''),
                  value: entityId,
                ))
            .toList(),
      );
    } else {
      return EntityDropdown(
        labelText: labelText ?? localization!.lookup('$entityType'),
        entityType: entityType,
        onSelected: (entity) => onChanged!(entity?.id ?? ''),
        onAddPressed: onAddPressed,
        entityId: entityId,
        entityList: entityIds,
        overrideSuggestedAmount: overrideSuggestedAmount,
        overrideSuggestedLabel: overrideSuggestedLabel,
        allowClearing: allowClearing,
      );
    }
  }
}
