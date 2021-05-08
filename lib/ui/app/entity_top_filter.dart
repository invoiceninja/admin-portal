import 'package:invoiceninja_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:overflow_view/overflow_view.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';

class EntityTopFilter extends StatelessWidget {
  const EntityTopFilter({@required this.show});

  final bool show;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;

    final filterEntityType = uiState.filterEntityType;
    final routeEntityType = uiState.entityTypeRoute;

    final entityMap =
        filterEntityType != null ? state.getEntityMap(filterEntityType) : null;
    final filterEntity =
        entityMap != null ? entityMap[uiState.filterEntityId] : null;
    final relatedTypes = filterEntityType?.relatedTypes
            ?.where((element) => state.company.isModuleEnabled(element))
            ?.toList() ??
        [];

    final backgroundColor =
        !state.prefState.enableDarkMode && state.hasAccentColor
            ? state.accentColor
            : Theme.of(context).cardColor;

    return Material(
      color: backgroundColor,
      child: AnimatedContainer(
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
                    SizedBox(width: 8),
                    if (!state.prefState.showFilterSidebar)
                      IconButton(
                        tooltip: localization.showSidebar,
                        icon: Icon(
                          Icons.chrome_reader_mode,
                          color: state.headerTextColor,
                        ),
                        onPressed: () => store.dispatch(
                            UpdateUserPreferences(showFilterSidebar: true)),
                      ),
                    SizedBox(width: 4),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 220),
                      child: TextButton(
                        child: Text(
                          EntityPresenter()
                              .initialize(filterEntity, context)
                              .title,
                          style: TextStyle(
                              fontSize: 17, color: state.headerTextColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        style: TextButton.styleFrom(
                          minimumSize: Size(0, 36),
                        ),
                        onPressed: () => viewEntity(
                          entity: filterEntity,
                          appContext: context.getAppContext(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: OverflowView.flexible(
                          spacing: 4,
                          children: <Widget>[
                            for (int i = 0; i < relatedTypes.length; i++)
                              DecoratedBox(
                                child: TextButton(
                                  child: Text(
                                    localization
                                        .lookup('${relatedTypes[i].plural}'),
                                    style: TextStyle(
                                      color: state.headerTextColor,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    minimumSize: Size(0, 36),
                                  ),
                                  onPressed: () {
                                    viewEntitiesByType(
                                      appContext: context.getAppContext(),
                                      entityType: relatedTypes[i],
                                      filterEntity: filterEntity,
                                    );
                                  },
                                  onLongPress: () {
                                    handleEntityAction(
                                        context.getAppContext(),
                                        filterEntity,
                                        EntityAction.newEntityType(
                                            relatedTypes[i]));
                                  },
                                ),
                                decoration: BoxDecoration(
                                  border: relatedTypes[i] == routeEntityType
                                      ? Border(
                                          bottom: BorderSide(
                                            color: state.prefState
                                                        .enableDarkMode ||
                                                    !state.hasAccentColor
                                                ? state.accentColor
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Row(
                                  children: [
                                    Text(
                                      localization.more,
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
                                    entity: filterEntity,
                                    appContext: context.getAppContext(),
                                  );
                                } else {
                                  viewEntitiesByType(
                                    appContext: context.getAppContext(),
                                    entityType: value,
                                    filterEntity: filterEntity,
                                  );
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  filterEntityType.relatedTypes
                                      .sublist(relatedTypes.length - remaining)
                                      .where((element) => state.company
                                          .isModuleEnabled(element))
                                      .map((type) => PopupMenuItem<EntityType>(
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
                    IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: state.headerTextColor,
                      ),
                      onPressed: () => store.dispatch(FilterByEntity(
                        entityId: uiState.filterEntityId,
                        entityType: uiState.filterEntityType,
                      )),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
