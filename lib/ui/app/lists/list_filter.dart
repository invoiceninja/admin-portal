// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ListFilterMessage extends StatelessWidget {
  const ListFilterMessage({
    required this.filterEntityId,
    required this.filterEntityType,
    required this.onPressed,
    required this.onClearPressed,
    this.isSettings = false,
  });

  final String? filterEntityId;
  final EntityType? filterEntityType;
  final Function(BuildContext) onPressed;
  final Function() onClearPressed;
  final bool isSettings;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final filteredEntity =
        state.getEntityMap(filterEntityType)![filterEntityId];

    return Material(
      color: Colors.orange,
      elevation: 6.0,
      child: FilterListTile(
        entityType: filterEntityType,
        entity: filteredEntity as BaseEntity?,
        onPressed: onPressed,
        onClearPressed: onClearPressed,
        isSettings: isSettings,
      ),
    );
  }
}

class FilterListTile extends StatelessWidget {
  const FilterListTile({
    required this.entityType,
    required this.entity,
    required this.onPressed,
    required this.onClearPressed,
    this.isSettings = false,
  });

  final EntityType? entityType;
  final BaseEntity? entity;
  final Function(BuildContext) onPressed;
  final Function() onClearPressed;
  final bool isSettings;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    late String title;
    String? subtitle;

    if (isSettings) {
      subtitle = entity?.listDisplayName ?? '';
      if (entityType == EntityType.client) {
        title = localization!.clientSettings;
      } else if (entityType == EntityType.group) {
        title = localization!.groupSettings;
      }
    } else {
      title = localization!.filteredBy
          .replaceFirst(':value', entity!.listDisplayName);
      subtitle = localization.lookup(entityType.toString());
    }

    return ClipRect(
      child: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: .5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
          ),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return ListTile(
              leading: constraints.maxWidth > 250
                  ? Icon(getEntityIcon(entityType))
                  : null,
              title: Text(title),
              subtitle: Text(subtitle!),
              onTap: () => onPressed(context),
              trailing: IconButton(
                icon: Icon(Icons.clear),
                onPressed: onClearPressed,
              ),
            );
          }),
        ),
      ),
    );
  }
}
