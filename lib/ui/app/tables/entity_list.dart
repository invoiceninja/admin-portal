import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide DataRow, DataCell, DataColumn;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/app/tables/app_data_table.dart';
import 'package:invoiceninja_flutter/ui/app/tables/app_paginated_data_table.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_datatable.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';
import 'package:overflow_view/overflow_view.dart';

class EntityList extends StatefulWidget {
  EntityList({
    @required this.state,
    @required this.entityType,
    @required this.entityList,
    @required this.onRefreshed,
    @required this.onSortColumn,
    @required this.itemBuilder,
    @required this.onClearMultiselect,
    this.onPageChanged,
    this.presenter,
    this.tableColumns,
  }) : super(key: ValueKey('__${entityType}_${tableColumns}__'));

  final AppState state;
  final EntityType entityType;
  final List<String> tableColumns;
  final List<String> entityList;
  final Function(BuildContext) onRefreshed;
  final EntityPresenter presenter;
  final Function(String) onSortColumn;
  final Function(int) onPageChanged;
  final Function(BuildContext, int) itemBuilder;
  final Function onClearMultiselect;

  @override
  _EntityListState createState() => _EntityListState();
}

class _EntityListState extends State<EntityList> {
  EntityDataTableSource dataTableSource;

  @override
  void initState() {
    super.initState();

    final entityType = widget.entityType;
    final state = widget.state;
    final entityList = widget.entityList;
    final entityMap = state.getEntityMap(entityType);
    final entityState = state.getUIState(entityType);

    dataTableSource = EntityDataTableSource(
      context: context,
      entityType: entityType,
      editingId: entityState.editingId,
      tableColumns: widget.tableColumns,
      entityList: entityList.toList(),
      entityMap: entityMap,
      entityPresenter: widget.presenter,
      onTap: (BaseEntity entity) =>
          selectEntity(entity: entity, context: context),
    );
  }

  @override
  void didUpdateWidget(EntityList oldWidget) {
    super.didUpdateWidget(oldWidget);

    final state = widget.state;
    final uiState = state.getUIState(widget.entityType);
    dataTableSource.editingId = uiState.editingId;
    dataTableSource.entityList = widget.entityList;
    dataTableSource.entityMap = state.getEntityMap(widget.entityType);

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    dataTableSource.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final localization = AppLocalization.of(context);
    final state = widget.state;
    final uiState = state.uiState;
    final entityType = widget.entityType;
    final listUIState = state.getUIState(entityType).listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final entityList = widget.entityList;
    final entityMap = state.getEntityMap(entityType);
    final countSelected = (listUIState.selectedIds ?? <String>[]).length;
    final isList = entityType.isSetting || state.prefState.isModuleList;

    if (!state.isLoaded && entityList.isEmpty) {
      return LoadingIndicator();
    }

    final shouldSelectEntity = state.shouldSelectEntity(
        entityType: entityType, entityList: entityList);
    if (shouldSelectEntity != false) {
      // null is a special case which means we need to reselect
      // the current selection to add it to the history
      final entityId = shouldSelectEntity == null
          ? state.getUIState(entityType).selectedId
          : (entityList.isEmpty ? null : entityList.first);

      WidgetsBinding.instance.addPostFrameCallback((duration) {
        viewEntityById(
          appContext: context.getAppContext(),
          entityType: entityType,
          entityId: entityId,
        );
      });
    }

    final listOrTable = () {
      if (isList) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (uiState.filterEntityId != null && isMobile(context))
              ListFilterMessage(
                filterEntityId: uiState.filterEntityId,
                filterEntityType: uiState.filterEntityType,
                onPressed: (_) => viewEntityById(
                    appContext: context.getAppContext(),
                    entityId: state.uiState.filterEntityId,
                    entityType: state.uiState.filterEntityType),
                onClearPressed: () => store.dispatch(ClearEntityFilter()),
              ),
            Flexible(
              fit: FlexFit.loose,
              child: entityList.isEmpty
                  ? HelpText(AppLocalization.of(context).noRecordsFound)
                  : ScrollableListViewBuilder(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      separatorBuilder: (context, index) =>
                          (index == 0 || index == entityList.length)
                              ? SizedBox()
                              : ListDivider(),
                      itemCount: entityList.length + 2,
                      itemBuilder: (BuildContext context, index) {
                        if (index == 0 || index == entityList.length + 1) {
                          return Container(
                            color: Theme.of(context).cardColor,
                            height: 25,
                          );
                        } else {
                          return widget.itemBuilder(context, index - 1);
                        }
                      },
                    ) /*DraggableScrollbar.semicircle(
                      backgroundColor: Theme.of(context).backgroundColor,
                      scrollbarTimeToFade: Duration(seconds: 1),
                      controller: _scrollController,
                      child: ScrollableListViewBuilder(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        controller: _scrollController,
                        separatorBuilder: (context, index) =>
                            (index == 0 || index == entityList.length)
                                ? SizedBox()
                                : ListDivider(),
                        itemCount: entityList.length + 2,
                        itemBuilder: (BuildContext context, index) {
                          if (index == 0 || index == entityList.length + 1) {
                            return Container(
                              color: Theme.of(context).cardColor,
                              height: 25,
                            );
                          } else {
                            return widget.itemBuilder(context, index - 1);
                          }
                        },
                      ),
                    )*/
              ,
            ),
          ],
        );
      } else {
        if (widget.tableColumns.isEmpty) {
          return SizedBox();
        }

        // make sure the initial page shows the selected record
        final entityUIState = state.getUIState(entityType);
        final selectedIndex =
            widget.entityList.indexOf(entityUIState.selectedId);
        final rowsPerPage = state.prefState.rowsPerPage;

        int initialFirstRowIndex = 0;
        if (selectedIndex >= 0) {
          initialFirstRowIndex =
              (selectedIndex / rowsPerPage).floor() * rowsPerPage;
        }

        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (uiState.filterEntityId != null && isMobile(context))
              ListFilterMessage(
                filterEntityId: uiState.filterEntityId,
                filterEntityType: uiState.filterEntityType,
                onPressed: (_) {
                  viewEntityById(
                      appContext: context.getAppContext(),
                      entityId: state.uiState.filterEntityId,
                      entityType: state.uiState.filterEntityType);
                },
                onClearPressed: () {
                  store.dispatch(ClearEntityFilter());
                },
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: AppPaginatedDataTable(
                    key: ValueKey(
                        '__${uiState.filterEntityId}_${uiState.filterEntityType}_${listUIState.hashCode}_'),
                    onSelectAll: (value) {
                      final entities = entityList
                          .map((String entityId) => entityMap[entityId])
                          .where((invoice) =>
                              value != listUIState.isSelected(invoice.id))
                          .map((entity) => entity as BaseEntity)
                          .toList();
                      handleEntitiesActions(context.getAppContext(), entities,
                          EntityAction.toggleMultiselect);
                    },
                    columns: [
                      if (!isInMultiselect) DataColumn(label: SizedBox()),
                      ...widget.tableColumns.map((field) {
                        String label =
                            AppLocalization.of(context).lookup(field);
                        if (field.startsWith('custom')) {
                          final key = field.replaceFirst(
                              'custom', entityType.snakeCase);
                          label = state.company.getCustomFieldLabel(key);
                        }
                        return DataColumn(
                            label: Container(
                              constraints: BoxConstraints(
                                minWidth: kTableColumnWidthMin,
                                maxWidth: kTableColumnWidthMax,
                              ),
                              child: Text(
                                label,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            onSort: (int columnIndex, bool ascending) {
                              widget.onSortColumn(field);
                            });
                      }),
                    ],
                    source: dataTableSource,
                    sortColumnIndex:
                        widget.tableColumns.contains(listUIState.sortField)
                            ? widget.tableColumns.indexOf(listUIState.sortField)
                            : 0,
                    sortAscending: listUIState.sortAscending,
                    rowsPerPage: state.prefState.rowsPerPage,
                    onPageChanged: widget.onPageChanged,
                    initialFirstRowIndex: initialFirstRowIndex,
                  ),
                ),
              ),
            ),
          ],
        );
      }
    };

    final entities = listUIState.selectedIds == null
        ? <BaseEntity>[]
        : listUIState.selectedIds
            .map<BaseEntity>((entityId) => entityMap[entityId])
            .toList();
    final firstEntity = entities.isEmpty ? null : entities.first;
    final actions = (firstEntity?.getActions(
              includeEdit: false,
              multiselect: true,
              userCompany: state.userCompany,
              client: (firstEntity is BelongsToClient)
                  ? state.clientState
                      .get((firstEntity as BelongsToClient).clientId)
                  : null,
            ) ??
            [])
        .where((action) => action != null);

    return RefreshIndicator(
        onRefresh: () => widget.onRefreshed(context),
        child: Column(
          children: [
            AppBorder(
              isTop: true,
              child: AnimatedContainer(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: Theme.of(context).cardColor,
                height: isInMultiselect ? kTopBottomBarHeight : 0,
                duration: Duration(milliseconds: kDefaultAnimationDuration),
                curve: Curves.easeInOutCubic,
                child: AnimatedOpacity(
                  opacity: isInMultiselect ? 1 : 0,
                  duration: Duration(milliseconds: kDefaultAnimationDuration),
                  curve: Curves.easeInOutCubic,
                  child: Row(
                    children: [
                      if (state.prefState.moduleLayout == ModuleLayout.list)
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (value) {
                            final entities = entityList
                                .where((entityId) =>
                                    value != listUIState.isSelected(entityId))
                                .map<BaseEntity>(
                                    (entityId) => entityMap[entityId])
                                .toList();
                            handleEntitiesActions(context.getAppContext(),
                                entities, EntityAction.toggleMultiselect);
                          },
                          activeColor: Theme.of(context).accentColor,
                          value: entityList.length ==
                              (listUIState.selectedIds ?? <String>[]).length,
                        ),
                      if (isDesktop(context)) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(isList
                              ? '($countSelected)'
                              : localization.countSelected
                                  .replaceFirst(':count', '$countSelected')),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: OverflowView.flexible(
                                spacing: 8,
                                children: actions
                                    .map(
                                      (action) => OutlinedButton(
                                        child: IconText(
                                          icon: getEntityActionIcon(action),
                                          text: localization.lookup('$action'),
                                        ),
                                        onPressed: () {
                                          handleEntitiesActions(
                                              context.getAppContext(),
                                              entities,
                                              action);
                                          widget.onClearMultiselect();
                                        },
                                      ),
                                    )
                                    .toList(),
                                builder: (context, remaining) {
                                  return PopupMenuButton<EntityAction>(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
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
                                    onSelected: (EntityAction action) {
                                      handleEntitiesActions(
                                          context.getAppContext(),
                                          entities,
                                          action);
                                      widget.onClearMultiselect();
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return actions
                                          .toList()
                                          .sublist(actions.length - remaining)
                                          .map((action) {
                                        return PopupMenuItem<EntityAction>(
                                          value: action,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                getEntityActionIcon(action),
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                              SizedBox(width: 16.0),
                                              Text(AppLocalization.of(context)
                                                      .lookup(
                                                          action.toString()) ??
                                                  ''),
                                            ],
                                          ),
                                        );
                                      }).toList();
                                    },
                                  );
                                }),
                          ),
                        )
                      ] else ...[
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(localization.countSelected
                              .replaceFirst(':count', '$countSelected')),
                        ),
                        SaveCancelButtons(
                          isHeader: false,
                          saveLabel: localization.actions,
                          isEnabled: entities.isNotEmpty,
                          isCancelEnabled: true,
                          onSavePressed: (context) async {
                            await showEntityActionsDialog(
                              entities: entities,
                              context: context,
                              multiselect: true,
                              completer: Completer<Null>()
                                ..future.then<dynamic>(
                                    (_) => widget.onClearMultiselect()),
                            );
                          },
                          onCancelPressed: (_) => widget.onClearMultiselect(),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  listOrTable(),
                  if ((state.isLoading &&
                          (isMobile(context) || !entityType.isSetting)) ||
                      (state.isSaving && entityType.isSetting))
                    LinearProgressIndicator(),
                ],
              ),
            ),
          ],
        ));
  }
}
