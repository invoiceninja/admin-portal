// Flutter imports:
import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:overflow_view/overflow_view.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EntityTopFilter extends StatelessWidget {
  const EntityTopFilter({
    required this.show,
  });

  final bool show;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final prefState = state.prefState;

    final filterEntityType = uiState.filterEntityType;
    final routeEntityType = uiState.entityTypeRoute;

    final entityMap =
        filterEntityType != null ? state.getEntityMap(filterEntityType) : null;
    final filterEntity =
        entityMap != null ? entityMap[uiState.filterEntityId] : null;
    final relatedTypes = filterEntityType?.relatedTypes
            .where((element) => state.company.isModuleEnabled(element))
            .toList() ??
        [];

    final backgroundColor = !prefState.enableDarkMode && state.hasAccentColor
        ? state.accentColor
        : Theme.of(context).cardColor;

    return Material(
      color: backgroundColor,
      child: Column(
        children: [
          if (prefState.isViewerFullScreen(uiState.filterEntityType))
            Expanded(
                child: uiState.filterEntityType == EntityType.client
                    ? ClientViewScreen(
                        isTopFilter: true,
                      )
                    : uiState.filterEntityType == EntityType.vendor
                        ? VendorViewScreen(isTopFilter: true)
                        : Placeholder()),
          AnimatedContainer(
            height: show ? 46 : 0,
            duration: Duration(milliseconds: kDefaultAnimationDuration),
            curve: Curves.easeInOutCubic,
            child: AnimatedOpacity(
              opacity: show ? 1 : 0,
              duration: Duration(milliseconds: kDefaultAnimationDuration),
              curve: Curves.easeInOutCubic,
              child: filterEntity == null
                  ? Container(
                      color: backgroundColor,
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(width: 4),
                        if (!prefState
                            .isViewerFullScreen(filterEntityType)) ...[
                          IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: state.headerTextColor,
                            ),
                            onPressed: () => store.dispatch(
                              FilterByEntity(entity: uiState.filterEntity),
                            ),
                          ),
                        ],
                        SizedBox(width: 4),
                        if (!prefState.isFilterVisible &&
                            !prefState.isViewerFullScreen(filterEntityType))
                          InkWell(
                            onTap: () {
                              store.dispatch(UpdateUserPreferences(
                                  isFilterVisible: !prefState.isFilterVisible));
                            },
                            onLongPress: () {
                              editEntity(entity: filterEntity);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 12),
                                Icon(
                                  Icons.chrome_reader_mode,
                                  color: state.headerTextColor,
                                ),
                                SizedBox(width: 12),
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 220),
                                  child: Text(
                                    EntityPresenter()
                                        .initialize(
                                            filterEntity as BaseEntity, context)
                                        .title()!,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: state.headerTextColor),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(width: 12),
                              ],
                            ),
                          ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: OverflowView.flexible(
                              spacing: 4,
                              children: <Widget>[
                                for (int i = 0; i < relatedTypes.length; i++)
                                  DecoratedBox(
                                    child: TextButton(
                                      child: Text(
                                        localization!.lookup(
                                            '${relatedTypes[i].plural}'),
                                        style: TextStyle(
                                          color: state.headerTextColor,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        minimumSize: Size(0, 36),
                                      ),
                                      onPressed: () {
                                        viewEntitiesByType(
                                          entityType: relatedTypes[i],
                                          filterEntity:
                                              filterEntity as BaseEntity?,
                                        );
                                      },
                                      onLongPress: () {
                                        handleEntityAction(
                                            filterEntity as BaseEntity,
                                            EntityAction.newEntityType(
                                                relatedTypes[i]));
                                      },
                                    ),
                                    decoration: BoxDecoration(
                                      border: relatedTypes[i] == routeEntityType
                                          ? Border(
                                              bottom: BorderSide(
                                                color: prefState
                                                            .enableDarkMode ||
                                                        !state.hasAccentColor
                                                    ? state.accentColor!
                                                    : Colors.white,
                                                width: 2,
                                              ),
                                            )
                                          : null,
                                    ),
                                  )
                              ],
                              builder: (context, remaining) {
                                return PopupMenuButton<EntityType>(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Row(
                                      children: [
                                        Text(
                                          localization!.more,
                                          style: TextStyle(
                                              color: state.headerTextColor),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(Icons.arrow_drop_down,
                                            color: state.headerTextColor),
                                      ],
                                    ),
                                  ),
                                  initialValue: routeEntityType,
                                  onSelected: (EntityType value) {
                                    if (value == filterEntityType) {
                                      viewEntity(
                                        entity: filterEntity as BaseEntity,
                                      );
                                    } else {
                                      viewEntitiesByType(
                                        entityType: value,
                                        filterEntity:
                                            filterEntity as BaseEntity?,
                                      );
                                    }
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      filterEntityType!.relatedTypes
                                          .sublist(
                                              relatedTypes.length - remaining)
                                          .where((element) => state.company
                                              .isModuleEnabled(element))
                                          .map((type) =>
                                              PopupMenuItem<EntityType>(
                                                value: type,
                                                child: ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                    minWidth: 75,
                                                  ),
                                                  child: Text(type ==
                                                          filterEntityType
                                                      ? localization.overview
                                                      : '${localization.lookup(type.plural)}'),
                                                ),
                                              ))
                                          .toList(),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        if (!prefState
                            .isViewerFullScreen(filterEntityType)) ...[
                          if (filterEntityType!.hasFullWidthViewer)
                            AppBorder(
                              isLeft: true,
                              child: InkWell(
                                onTap: () {
                                  store.dispatch(ToggleViewerLayout(
                                      uiState.filterEntityType));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Icon(
                                    MdiIcons.chevronDown,
                                    color: state.headerTextColor,
                                  ),
                                ),
                              ),
                            ),
                        ]
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class EntityTopFilterHeader extends StatelessWidget {
  const EntityTopFilterHeader();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final prefState = state.prefState;

    final filterEntityType = uiState.filterEntityType;

    final entityMap =
        filterEntityType != null ? state.getEntityMap(filterEntityType) : null;
    final filterEntity =
        entityMap != null ? entityMap[uiState.filterEntityId]! : null;

    final backgroundColor = !prefState.enableDarkMode && state.hasAccentColor
        ? state.accentColor
        : Theme.of(context).cardColor;

    final entityActions = (filterEntity as BaseEntity)
        .getActions(
          includeEdit: true,
          userCompany: state.userCompany,
        )
        .whereNotNull();
    final textStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: state.headerTextColor);

    return Material(
      color: backgroundColor,
      elevation: 4,
      child: SizedBox(
        height: kTopBottomBarHeight - 4,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 4,
            ),
            IconButton(
              icon: Icon(
                Icons.clear,
                color: state.headerTextColor,
              ),
              onPressed: () {
                final entityType = uiState.filterEntityType!;
                if (entityType.hasFullWidthViewer &&
                    state.prefState.isViewerFullScreen(entityType)) {
                  viewEntitiesByType(
                      entityType: entityType,
                      page: state.historyList.length >= 2
                          ? state.historyList[1].page
                          : 0);
                } else {
                  store.dispatch(
                    FilterByEntity(entity: uiState.filterEntity),
                  );
                }
              },
            ),
            SizedBox(width: 4),
            if (!prefState.isFilterVisible)
              InkWell(
                onTap: () {
                  store.dispatch(UpdateUserPreferences(
                      isFilterVisible: !prefState.isFilterVisible));
                },
                onLongPress: () {
                  editEntity(entity: filterEntity);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 12),
                    Icon(
                      Icons.chrome_reader_mode,
                      color: state.headerTextColor,
                    ),
                    SizedBox(width: 12),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 220),
                      child: Text(
                        EntityPresenter()
                            .initialize(filterEntity, context)
                            .title()!,
                        style: TextStyle(
                            fontSize: 17, color: state.headerTextColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(width: 12),
                  ],
                ),
              ),
            SizedBox(width: 12),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: OverflowView.flexible(
                    spacing: 8,
                    children: entityActions.map(
                      (action) {
                        final label = localization!.lookup('$action');

                        return OutlinedButton(
                          style: action == EntityAction.edit
                              ? ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      state.prefState.colorThemeModel!
                                          .colorSuccess))
                              : null,
                          child: IconText(
                            icon: getEntityActionIcon(action),
                            text: label,
                            style: state.isSaving ? null : textStyle,
                          ),
                          onPressed: state.isSaving
                              ? null
                              : () {
                                  handleEntitiesActions([filterEntity], action);
                                },
                        );
                      },
                    ).toList(),
                    builder: (context, remaining) {
                      return PopupMenuButton<EntityAction>(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Text(
                                localization!.more,
                                style: textStyle,
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_drop_down,
                                  color: state.headerTextColor),
                            ],
                          ),
                        ),
                        onSelected: (EntityAction action) {
                          handleEntitiesActions([filterEntity], action);
                        },
                        itemBuilder: (BuildContext context) {
                          return entityActions
                              .toList()
                              .sublist(entityActions.length - remaining)
                              .map((action) {
                            return PopupMenuItem<EntityAction>(
                              value: action,
                              child: Row(
                                children: <Widget>[
                                  Icon(getEntityActionIcon(action),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  SizedBox(width: 16.0),
                                  Text(AppLocalization.of(context)!
                                      .lookup(action.toString())),
                                ],
                              ),
                            );
                          }).toList();
                        },
                      );
                    }),
              ),
            ),
            AppBorder(
              isLeft: true,
              child: InkWell(
                onTap: () {
                  store.dispatch(ToggleViewerLayout(uiState.filterEntityType));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    MdiIcons.chevronUp,
                    color: state.headerTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
