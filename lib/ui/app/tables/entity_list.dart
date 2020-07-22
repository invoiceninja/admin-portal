import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide DataRow, DataCell, DataColumn;
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/tables/app_data_table.dart';
import 'package:invoiceninja_flutter/ui/app/tables/app_paginated_data_table.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_datatable.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class EntityList extends StatefulWidget {
  EntityList({
    @required this.state,
    @required this.entityType,
    @required this.entityList,
    @required this.onRefreshed,
    @required this.onSortColumn,
    @required this.itemBuilder,
    this.presenter,
    this.tableColumns,
    this.onClearEntityFilterPressed,
    this.onViewEntityFilterPressed,
  }) : super(key: ValueKey('__${entityType}_${tableColumns}__'));

  final AppState state;
  final EntityType entityType;
  final List<String> tableColumns;
  final List<String> entityList;
  final Function(BuildContext) onRefreshed;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
  final EntityPresenter presenter;
  final Function(String) onSortColumn;
  final Function(BuildContext, int) itemBuilder;

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
    final state = widget.state;
    final entityType = widget.entityType;
    final listState = state.getListState(entityType);
    final listUIState = state.getUIState(entityType).listUIState;
    final isList = state.prefState.moduleLayout == ModuleLayout.list ||
        widget.presenter == null;
    final entityList = widget.entityList;
    final entityMap = state.getEntityMap(entityType);

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
          context: context,
          entityType: entityType,
          entityId: entityId,
        );
      });
    }

    final listOrTable = () {
      if (isList) {
        return Column(children: <Widget>[
          if (listState.filterEntityId != null && isMobile(context))
            ListFilterMessage(
              filterEntityId: listState.filterEntityId,
              filterEntityType: listState.filterEntityType,
              onPressed: widget.onViewEntityFilterPressed,
              onClearPressed: widget.onClearEntityFilterPressed,
            ),
          SizedBox(
            height: 32,
          ),
          Flexible(
              child: entityList.isEmpty
                  ? HelpText(AppLocalization.of(context).noRecordsFound)
                  : Material(
                      color: Theme.of(context).cardColor,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => ListDivider(),
                        itemCount: entityList.length,
                        itemBuilder: widget.itemBuilder,
                      ),
                    )),
        ]);
      } else {
        if (widget.tableColumns.isEmpty) {
          return SizedBox();
        }

        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (listState.filterEntityId != null && isMobile(context))
              ListFilterMessage(
                filterEntityId: listState.filterEntityId,
                filterEntityType: listState.filterEntityType,
                onPressed: widget.onViewEntityFilterPressed,
                onClearPressed: widget.onClearEntityFilterPressed,
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: AppPaginatedDataTable(
                    onSelectAll: (value) {
                      final entities = entityList
                          .map((String entityId) => entityMap[entityId])
                          .where((invoice) =>
                              value != listUIState.isSelected(invoice.id))
                          .map((entity) => entity as BaseEntity)
                          .toList();
                      handleEntitiesActions(
                          context, entities, EntityAction.toggleMultiselect);
                    },
                    columns: [
                      if (!listUIState.isInMultiselect())
                        DataColumn(label: SizedBox()),
                      ...widget.tableColumns.map((field) => DataColumn(
                          label: Container(
                            constraints: BoxConstraints(
                              minWidth: kTableColumnWidthMin,
                              maxWidth: kTableColumnWidthMax,
                            ),
                            child: Text(
                              AppLocalization.of(context).lookup(field),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          numeric: EntityPresenter.isFieldNumeric(field),
                          onSort: (int columnIndex, bool ascending) {
                            widget.onSortColumn(field);
                          })),
                    ],
                    source: dataTableSource,
                    sortColumnIndex:
                        widget.tableColumns.indexOf(listUIState.sortField),
                    sortAscending: listUIState.sortAscending,
                  ),
                ),
              ),
            ),
          ],
        );
      }
    };

    return RefreshIndicator(
        onRefresh: () => widget.onRefreshed(context),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            if (state.isLoading ||
                (kEntitySettings.contains(entityType) && state.isSaving))
              LinearProgressIndicator(),
            listOrTable(),
          ],
        ));
  }
}
