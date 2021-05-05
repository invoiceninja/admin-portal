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
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';

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
    if (widget.entity == null || widget.entity.isNew) {
      return SizedBox();
    }

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
      entity: widget.entity,
      onSelected: (context, action) => widget.onEntityActionSelected != null
          ? widget.onEntityActionSelected(context, widget.entity, action)
          : handleEntityAction(context.getAppContext(), widget.entity, action),
    );

    final trailing = widget.isFilter
        ? SizedBox()
        : IgnorePointer(
            ignoring: !isHovered,
            child: IconButton(
              icon: Icon(isHovered ||
                      isMobile(context) ||
                      state.uiState.previewStack.isNotEmpty
                  ? Icons.chevron_right
                  : Icons.filter_list),
              onPressed: () => viewEntity(
                entity: widget.entity,
                appContext: context.getAppContext(),
                addToStack: isDesktop(context) && !widget.isFilter,
              ),
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
                EntityPresenter().initialize(widget.entity, context).title,
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

class EntitiesListTile extends StatefulWidget {
  const EntitiesListTile({
    @required this.isFilter,
    @required this.entity,
    this.entityType,
    this.title,
    this.subtitle,
    this.hideNew = false,
  });

  final BaseEntity entity;
  final EntityType entityType;
  final String title;
  final String subtitle;
  final bool isFilter;
  final bool hideNew;

  @override
  _EntitiesListTileState createState() => _EntitiesListTileState();
}

class _EntitiesListTileState extends State<EntitiesListTile> {
  bool _isHovered = false;

  void _onTap(BuildContext context) => viewEntitiesByType(
      appContext: context.getAppContext(),
      entityType: widget.entityType,
      filterEntity: widget.entity);

  void _onLongPress() {
    final store = StoreProvider.of<AppState>(context);
    final uiState = store.state.uiState;
    final entity = widget.entity;
    if (uiState.filterEntityId != entity.id ||
        uiState.filterEntityType != entity.entityType) {
      store.dispatch(
          FilterByEntity(entityId: entity.id, entityType: entity.entityType));
    }
    handleEntityAction(context.getAppContext(), entity,
        EntityAction.newEntityType(widget.entityType));
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final mainRoute = state.uiState.mainRoute;
    final isFilterMatch =
        widget.isFilter && '${widget.entityType}' == toCamelCase(mainRoute);

    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SelectedIndicator(
            isSelected: isFilterMatch,
            isMenu: true,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text(widget.title),
              subtitle: Text((widget.subtitle ?? '').isEmpty
                  ? AppLocalization.of(context).none
                  : widget.subtitle),
              leading: _isHovered &&
                      !widget.hideNew &&
                      state.userCompany.canCreate(widget.entityType)
                  ? IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: _onLongPress,
                    )
                  : IgnorePointer(
                      child: IconButton(
                        icon:
                            Icon(getEntityIcon(widget.entityType), size: 18.0),
                        onPressed: () => _onTap(context),
                      ),
                    ),
              trailing: widget.isFilter
                  ? SizedBox()
                  : IgnorePointer(
                      child: IconButton(
                        icon: Icon(MdiIcons.chevronDoubleRight),
                        onPressed: () => null,
                      ),
                    ),
              onTap: () => _onTap(context),
              onLongPress: _onLongPress,
            ),
          ),
          ListDivider(),
        ],
      ),
    );
  }
}
