import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
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
    this.subtitle,
  });

  final String subtitle;
  final BaseEntity entity;
  final bool isFilter;

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
      final client = entity is BelongsToClient
          ? state.clientState.map[(entity as BelongsToClient).clientId]
          : null;
      leading = ActionMenuButton(
        entityActions: entity.getActions(
            userCompany: state.userCompany, includeEdit: true, client: client),
        isSaving: false,
        color: state.prefState.enableDarkMode
            ? Colors.white
            : Theme.of(context).accentColor,
        entity: entity,
        onSelected: (context, action) =>
            handleEntityAction(context, entity, action),
      );
    } else {
      leading = IgnorePointer(
        ignoring: true,
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
          ignoring: true,
          child: IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => null,
          ),
        );
      }
    } else {
      Icon(Icons.navigate_next);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SelectedIndicator(
          isSelected: isFilteredBy && isDesktop(context),
          isMenu: true,
          child: ListTile(
            onTap: () => inspectEntity(context: context, entity: entity),
            onLongPress: () => inspectEntity(
                context: context, entity: entity, longPress: true),
            contentPadding: const EdgeInsets.only(left: 8, right: 8),
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
            contentPadding: const EdgeInsets.only(left: 16, right: 16),
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
        ListDivider(),
      ],
    );
  }
}
