import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

class EntityListTile extends StatefulWidget {
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
  _EntityListTileState createState() => _EntityListTileState();
}

class _EntityListTileState extends State<EntityListTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    if (widget.entity == null) {
      return SizedBox();
    }

    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final isFilteredBy = state.uiState.filterEntityId == widget.entity.id &&
        state.uiState.filterEntityType == widget.entity.entityType;

    final entityClient = widget.client ??
        (widget.entity is BelongsToClient
            ? state.clientState.map[(widget.entity as BelongsToClient).clientId]
            : null);
    final isHovered =
        (!RendererBinding.instance.mouseTracker.mouseIsConnected &&
                isFilteredBy) ||
            _isHovered;

    final leading = ActionMenuButton(
      iconData:
          isHovered ? Icons.more_vert : getEntityIcon(widget.entity.entityType),
      iconSize: isHovered ? null : 18,
      entityActions: widget.entity.getActions(
          userCompany: state.userCompany,
          includeEdit: true,
          client: entityClient),
      isSaving: false,
      color: isFilteredBy
          ? (state.prefState.enableDarkMode
              ? Colors.white
              : Theme.of(context).accentColor)
          : null,
      entity: widget.entity,
      onSelected: (context, action) => widget.onEntityActionSelected != null
          ? widget.onEntityActionSelected(context, widget.entity, action)
          : handleEntityAction(context, widget.entity, action),
    );

    final trailing = IgnorePointer(
      ignoring: !isHovered,
      child: IconButton(
        icon: Icon(isHovered ? Icons.chevron_right : Icons.filter_list),
        onPressed: isHovered
            ? () => viewEntity(entity: widget.entity, context: context)
            : () => null,
        color: isFilteredBy
            ? (state.prefState.enableDarkMode
                ? Colors.white
                : Theme.of(context).accentColor)
            : null,
      ),
    );

    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SelectedIndicator(
            isSelected: isFilteredBy && isDesktop(context),
            isMenu: true,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              onTap: () =>
                  inspectEntity(context: context, entity: widget.entity),
              onLongPress: () => inspectEntity(
                  context: context, entity: widget.entity, longPress: true),
              title: Text(
                localization.lookup('${widget.entity.entityType}') +
                    '  ›  ' +
                    widget.entity.listDisplayName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle:
                  (widget.subtitle ?? '').isEmpty && widget.entity.isActive
                      ? null
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if ((widget.subtitle ?? '').isNotEmpty)
                              Text(widget.subtitle),
                            if (!widget.entity.isActive)
                              EntityStateLabel(widget.entity),
                          ],
                        ),
              leading: leading,
              trailing: trailing,
              isThreeLine:
                  (widget.subtitle ?? '').isNotEmpty && !widget.entity.isActive,
            ),
          ),
          ListDivider(),
        ],
      ),
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
            subtitle: Text((subtitle ?? '').isEmpty
                ? AppLocalization.of(context).none
                : subtitle),
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
