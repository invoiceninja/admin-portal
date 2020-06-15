import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/lists/selected_indicator.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class EntityListTile extends StatelessWidget {
  const EntityListTile({
    @required this.entity,
    @required this.isFilter,
    this.onTap,
    this.onLongPress,
    this.subtitle,
  });

  final Function onTap;
  final Function onLongPress;
  final String subtitle;
  final BaseEntity entity;
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    if (entity == null) {
      return SizedBox();
    }

    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final isFilteredBy = state.uiState.filterEntityId == entity.id &&
        state.uiState.filterEntityType == entity.entityType;

    Widget leading;
    if (isFilteredBy) {
      final client = entity is BelongsToClient
          ? state.clientState.map[(entity as BelongsToClient).clientId]
          : null;
      leading = ActionMenuButton(
        entityActions: entity.getActions(
            userCompany: state.userCompany, includeEdit: true, client: client),
        isSaving: false,
        entity: entity,
        onSelected: (context, action) =>
            handleEntityAction(context, entity, action),
      );
    } else {
      leading = IconButton(
        icon: Icon(getEntityIcon(entity.entityType), size: 18.0),
        onPressed: onTap,
      );
    }

    Widget trailing;
    if (isNotMobile(context) && isFilter != null && !isFilter) {
      trailing = Icon(Icons.filter_list,
          color: isFilteredBy ? Theme.of(context).accentColor : null);
    } else {
      Icon(Icons.navigate_next);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Material(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 8, right: 12),
              title: EntityStateTitle(entity: entity),
              subtitle: subtitle != null && subtitle.isNotEmpty
                  ? Text(subtitle ?? '')
                  : null,
              leading: leading,
              trailing: trailing,
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
    @required this.isFilter,
  });

  final Function onTap;
  final Function onLongPress;
  final EntityType entityType;
  final String title;
  final String subtitle;
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final mainRoute = state.uiState.mainRoute;
    final isFilterMatch =
        isFilter && entityType.toString() == mainRoute.replaceFirst('/', '');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Material(
          color: Theme.of(context).cardColor,
          child: SelectedIndicator(
            isSelected: isFilterMatch,
            isMenu: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 8, right: 12),
                title: Text(title),
                subtitle: Text(subtitle ?? ''),
                leading: IconButton(
                  icon: Icon(getEntityIcon(entityType), size: 18.0),
                  onPressed: onTap,
                ),
                trailing: isFilter
                    ? IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: onLongPress,
                      )
                    : Icon(Icons.navigate_next),
                onTap: onTap,
                onLongPress: onLongPress,
              ),
            ),
          ),
        ),
        ListDivider(),
      ],
    );
  }
}
