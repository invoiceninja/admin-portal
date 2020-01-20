import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class FilterListTile extends StatelessWidget {
  const FilterListTile({
    @required this.entityType,
    @required this.entity,
    @required this.onPressed,
    @required this.onClearPressed,
  });

  final EntityType entityType;
  final BaseEntity entity;
  final Function(BuildContext) onPressed;
  final Function() onClearPressed;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return ListTile(
      dense: true,
      leading: Icon(getEntityIcon(entityType)),
      title: Text(localization.filteredBy
          .replaceFirst(':value', entity.listDisplayName)),
      subtitle: Text(localization.lookup(entityType.toString())),
      onTap: () => onPressed(context),
      trailing: IconButton(
        icon: Icon(Icons.clear),
        onPressed: onClearPressed,
      ),
    );
  }
}

class ListFilterMessage extends StatelessWidget {
  const ListFilterMessage({
    @required this.filterEntityId,
    @required this.filterEntityType,
    @required this.onPressed,
    @required this.onClearPressed,
  });

  final String filterEntityId;
  final EntityType filterEntityType;
  final Function(BuildContext) onPressed;
  final Function() onClearPressed;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final filteredEntity = state.getEntityMap(filterEntityType)[filterEntityId];

    return Material(
      color: Colors.orangeAccent,
      elevation: 6.0,
      child: FilterListTile(
          entityType: filterEntityType,
          entity: filteredEntity,
          onPressed: onPressed,
          onClearPressed: onClearPressed),
    );
  }
}
