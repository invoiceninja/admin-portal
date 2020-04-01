import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
import 'package:invoiceninja_flutter/ui/app/tables/entity_datatable.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EntityList extends StatefulWidget {
  const EntityList({
    Key key,
    @required this.isLoaded,
    @required this.state,
    @required this.entityType,
    @required this.entityList,
    @required this.onEntityTap,
    @required this.onRefreshed,
    @required this.onSortColumn,
    @required this.itemBuilder,
    this.presenter,
    this.tableColumns,
    this.onClearEntityFilterPressed,
    this.onViewEntityFilterPressed,
  }) : super(key: key);

  final bool isLoaded;
  final AppState state;
  final EntityType entityType;
  final List<String> tableColumns;
  final List<String> entityList;
  final Function(BuildContext, BaseEntity) onEntityTap;
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
        onTap: (BaseEntity entity) => widget.onEntityTap(context, entity));
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

    if (!widget.isLoaded) {
      return LoadingIndicator();
    }

    if (!isList &&
        state.shouldSelectEntity(
            entityType: entityType, hasRecords: entityList.isNotEmpty)) {
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        viewEntityById(
          context: context,
          entityType: entityType,
          entityId: entityList.isEmpty ? null : entityList.first,
        );
      });
    }

    final listOrTable = () {
      if (isList) {
        return Column(children: <Widget>[
          if (listState.filterEntityId != null)
            ListFilterMessage(
              filterEntityId: listState.filterEntityId,
              filterEntityType: listState.filterEntityType,
              onPressed: widget.onViewEntityFilterPressed,
              onClearPressed: widget.onClearEntityFilterPressed,
            ),
          Expanded(
              child: entityList.isEmpty
                  ? HelpText(AppLocalization.of(context).noRecordsFound)
                  : ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => ListDivider(),
                      itemCount: entityList.length,
                      itemBuilder: widget.itemBuilder,
                    )),
        ]);
      } else {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: PaginatedDataTable(
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
                    onSort: (int columnIndex, bool ascending) =>
                        widget.onSortColumn(field))),
              ],
              source: dataTableSource,
              header: DatatableHeader(
                entityType: widget.entityType,
                onClearPressed: widget.onClearEntityFilterPressed,
                onRefreshPressed: () => widget.onRefreshed(context),
              ),
              sortColumnIndex:
                  widget.tableColumns.indexOf(listUIState.sortField) + 1,
              sortAscending: listUIState.sortAscending,
            ),
          ),
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
