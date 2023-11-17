// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
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

class EntityListTile extends StatefulWidget {
  const EntityListTile({
    required this.entity,
    required this.isFilter,
    this.onEntityActionSelected,
    this.subtitle,
    this.client,
  });

  final String? subtitle;
  final BaseEntity entity;
  final bool isFilter;
  final ClientEntity? client;
  final Function(BuildContext, BaseEntity?, EntityAction)?
      onEntityActionSelected;

  @override
  _EntityListTileState createState() => _EntityListTileState();
}

class _EntityListTileState extends State<EntityListTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    if (widget.entity.isNew) {
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
          ? widget.onEntityActionSelected!(context, widget.entity, action)
          : handleEntityAction(widget.entity, action),
    );

    // we may have the id (so it's not considered new) but it hasn't yet been
    // created in the backend. ie, the invoice after converting a quote
    final trailing = widget.entity.createdAt == 0
        ? null
        : IgnorePointer(
            ignoring: !isHovered ||
                widget.isFilter ||
                widget.entity.entityType == EntityType.company,
            child: IconButton(
              icon: Icon(widget.entity.entityType != EntityType.company &&
                      (isHovered ||
                          widget.isFilter ||
                          isMobile(context) ||
                          state.uiState.previewStack.isNotEmpty)
                  ? Icons.chevron_right
                  : Icons.filter_list),
              onPressed: () => viewEntity(
                entity: widget.entity,
                addToStack: isDesktop(context) && !widget.isFilter,
              ),
            ),
          );

    String defaultSubtitle = '';
    final entity = widget.entity;

    if (entity is InvoiceEntity) {
      defaultSubtitle =
          formatNumber(entity.amount, context, clientId: entity.clientId)! +
              ' • ' +
              formatDate(entity.date, context);
    } else if (entity is PaymentEntity) {
      defaultSubtitle =
          formatNumber(entity.amount, context, clientId: entity.clientId)! +
              ' • ' +
              formatDate(entity.date, context);
    } else if (entity is ExpenseEntity) {
      defaultSubtitle =
          formatNumber(entity.amount, context, currencyId: entity.currencyId)! +
              ' • ' +
              formatDate(entity.date, context);
    } else if (entity is TransactionEntity) {
      defaultSubtitle =
          formatNumber(entity.amount, context, currencyId: entity.currencyId)! +
              ' • ' +
              formatDate(entity.date, context);
    }

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
              onTap: () {
                if (state.prefState
                    .isViewerFullScreen(widget.entity.entityType))
                  store.dispatch(ToggleViewerLayout(widget.entity.entityType));
                inspectEntity(entity: widget.entity);
              },
              onLongPress: () =>
                  inspectEntity(entity: widget.entity, longPress: true),
              title: Text(
                EntityPresenter().initialize(widget.entity, context).title()!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: ((widget.subtitle ?? '').isNotEmpty ||
                      defaultSubtitle.isNotEmpty ||
                      !entity.isActive)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((widget.subtitle ?? '').isNotEmpty)
                          Text(widget.subtitle!)
                        else if (defaultSubtitle.isNotEmpty)
                          Text(defaultSubtitle),
                        if (!entity.isActive) EntityStateLabel(widget.entity),
                      ],
                    )
                  : null,
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
    required this.isFilter,
    required this.entity,
    this.entityType,
    this.title,
    this.subtitle,
    this.hideNew = false,
  });

  final BaseEntity entity;
  final EntityType? entityType;
  final String? title;
  final String? subtitle;
  final bool isFilter;
  final bool hideNew;

  @override
  _EntitiesListTileState createState() => _EntitiesListTileState();
}

class _EntitiesListTileState extends State<EntitiesListTile> {
  bool _isHovered = false;

  void _onTap(BuildContext context) => viewEntitiesByType(
      entityType: widget.entityType, filterEntity: widget.entity);

  void _onLongPress() {
    if (widget.entity.isDeleted!) {
      return;
    }

    final store = StoreProvider.of<AppState>(context);
    final uiState = store.state.uiState;
    final entity = widget.entity;

    if (uiState.filterEntityId != entity.id ||
        uiState.filterEntityType != entity.entityType) {
      store.dispatch(FilterByEntity(entity: entity));
    }

    handleEntityAction(entity, EntityAction.newEntityType(widget.entityType));
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
              title: Text(widget.title ?? ''),
              subtitle: Text((widget.subtitle ?? '').isEmpty
                  ? AppLocalization.of(context)!.none
                  : widget.subtitle!),
              leading: _isHovered &&
                      !widget.hideNew &&
                      !widget.entity.isDeleted! &&
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
              trailing: IgnorePointer(
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
