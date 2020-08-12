import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/lists/selected_indicator.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class EntityListTile extends StatelessWidget {
  const EntityListTile({
    @required this.entity,
    @required this.isFilter,
    this.onEntityActionSelected,
    this.subtitle,
    this.client,
  });

  final String subtitle;
  final BaseEntity entity;
  final bool isFilter;
  final ClientEntity client;
  final Function(BuildContext, BaseEntity, EntityAction) onEntityActionSelected;

  @override
  Widget build(BuildContext context) {
    if (entity == null) {
      return SizedBox();
    }

    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final isFilteredBy = state.uiState.filterEntityId == entity.id &&
        state.uiState.filterEntityType == entity.entityType;

    Widget leading;
    if (isDesktop(context) && isFilteredBy) {
      final entityClient = client ??
          (entity is BelongsToClient
              ? state.clientState.map[(entity as BelongsToClient).clientId]
              : null);
      leading = ActionMenuButton(
        entityActions: entity.getActions(
            userCompany: state.userCompany,
            includeEdit: true,
            client: entityClient),
        isSaving: false,
        color: state.prefState.enableDarkMode
            ? Colors.white
            : Theme.of(context).accentColor,
        entity: entity,
        onSelected: (context, action) => onEntityActionSelected != null
            ? onEntityActionSelected(context, entity, action)
            : handleEntityAction(context, entity, action),
      );
    } else {
      leading = IgnorePointer(
        child: IconButton(
          icon: Icon(getEntityIcon(entity.entityType), size: 18.0),
          onPressed: () => null,
        ),
      );
    }

    Widget trailing;
    if (isNotMobile(context) && isFilter != null && !isFilter) {
      if (isFilteredBy) {
        trailing = IconButton(
          color: state.prefState.enableDarkMode
              ? Colors.white
              : Theme.of(context).accentColor,
          icon: Icon(Icons.chevron_right),
          onPressed: () => viewEntity(entity: entity, context: context),
        );
      } else {
        trailing = IgnorePointer(
          child: IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => null,
          ),
        );
      }
    } else {
      trailing = IgnorePointer(
        child: IconButton(
          icon: Icon(Icons.navigate_next),
          onPressed: () => null,
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SelectedIndicator(
          isSelected: isFilteredBy && isDesktop(context),
          isMenu: true,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            onTap: () => inspectEntity(context: context, entity: entity),
            onLongPress: () => inspectEntity(
                context: context, entity: entity, longPress: true),
            title: Text(localization.lookup('${entity.entityType}') +
                '  ›  ' +
                entity.listDisplayName),
            subtitle: (subtitle ?? '').isEmpty && entity.isActive
                ? null
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if ((subtitle ?? '').isNotEmpty) Text(subtitle),
                      if (!entity.isActive) EntityStateLabel(entity),
                    ],
                  ),
            leading: leading,
            trailing: trailing,
            isThreeLine: (subtitle ?? '').isNotEmpty && !entity.isActive,
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
    final isFilterMatch = isFilter && '$entityType' == mainRoute;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SelectedIndicator(
          isSelected: isFilterMatch,
          isMenu: true,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            title: Text(title),
            subtitle: Text(subtitle ?? ''),
            leading: IgnorePointer(
              child: IconButton(
                icon: Icon(getEntityIcon(entityType), size: 18.0),
                onPressed: onTap,
              ),
            ),
            trailing: isFilter
                ? onLongPress == null
                    ? SizedBox()
                    : IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: onLongPress,
                      )
                : IgnorePointer(
                    child: IconButton(
                      icon: Icon(Icons.navigate_next),
                      onPressed: () => null,
                    ),
                  ),
            onTap: onTap,
            onLongPress: onLongPress,
          ),
        ),
        ListDivider(),
      ],
    );
  }
}
