import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class EntityListTile extends StatelessWidget {
  const EntityListTile({
    @required this.entity,
    this.onTap,
    this.onLongPress,
    this.subtitle,
  });

  final Function onTap;
  final Function onLongPress;
  final String subtitle;
  final BaseEntity entity;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final isFilteredBy = state.uiState.filterEntityId == entity.id &&
        state.uiState.filterEntityType == entity.entityType;

    Widget trailingIcon = Icon(Icons.navigate_next);
    if (isNotMobile(context)) {
      trailingIcon = Icon(Icons.filter_list,
          color: isFilteredBy ? Theme.of(context).accentColor : null);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Material(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              title: EntityStateTitle(entity: entity),
              subtitle: subtitle != null && subtitle.isNotEmpty
                  ? Text(subtitle)
                  : null,
              leading: Icon(getEntityIcon(entity.entityType), size: 18.0),
              trailing: trailingIcon,
              onTap: () => isFilteredBy && isNotMobile(context)
                  ? store.dispatch(ClearEntityFilter())
                  : onTap(),
              onLongPress: onLongPress,
            ),
          ),
        ),
        ListDivider(),
      ],
    );
  }
}

class EntitiesListTile extends StatelessWidget {
  const EntitiesListTile({
    this.entityType,
    this.onTap,
    this.onLongPress,
    this.title,
    this.subtitle,
  });

  final Function onTap;
  final Function onLongPress;
  final EntityType entityType;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    /*
    final isFilteredBy = state.uiState.filterEntityId == entity.id &&
        state.uiState.filterEntityType == entity.entityType;
    */

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Material(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              title: Text(title),
              subtitle: Text(subtitle ?? ''),
              leading: Icon(getEntityIcon(entityType), size: 18.0),
              trailing: Icon(Icons.navigate_next),
              onTap: onTap,
              onLongPress: onLongPress,
            ),
          ),
        ),
        ListDivider(),
      ],
    );
  }
}
