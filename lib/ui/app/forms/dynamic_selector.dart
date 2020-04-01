import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DynamicSelector extends StatelessWidget {
  const DynamicSelector(
      {this.entityId, this.entityType, this.entityIds, this.onChanged});

  final String entityId;
  final List<String> entityIds;
  final EntityType entityType;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final entityMap = state.getEntityMap(entityType);

    if (entityIds.length < 10) {
      return AppDropdownButton(
        labelText: localization.lookup('$entityType'),
        value: entityId,
        showBlank: true,
        onChanged: (dynamic entityId) => onChanged(entityId),
        items: entityIds
            .map((entityId) => DropdownMenuItem(
                  child: Text(entityMap[entityId]?.listDisplayName ?? ''),
                  value: entityId,
                ))
            .toList(),
      );
    } else {
      return EntityDropdown(
        key: ValueKey('__${entityType}_${entityId}__'),
        labelText: localization.lookup('$entityType'),
        entityType: entityType,
        allowClearing: true,
        onSelected: (entity) => onChanged(entity.id),
        entityId: entityId,
        entityList: entityIds,
      );
    }
  }
}
