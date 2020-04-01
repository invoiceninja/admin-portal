import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EntityDataTableSource extends DataTableSource {
  EntityDataTableSource(
      {@required this.context,
      @required this.editingId,
      @required this.entityList,
      @required this.entityMap,
      @required this.entityPresenter,
      @required this.tableColumns,
      @required this.entityType,
      @required this.onTap});

  EntityType entityType;
  String editingId;
  BuildContext context;
  List<String> entityList;
  EntityPresenter entityPresenter;
  BuiltMap<String, BaseEntity> entityMap;
  List<String> tableColumns;

  final Function(BaseEntity entity) onTap;

  @override
  int get selectedRowCount => 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => entityList.length;

  @override
  DataRow getRow(int index) {
    final state = StoreProvider.of<AppState>(context).state;
    final entity = entityMap[entityList[index]];
    entityPresenter.initialize(entity: entity, context: context);

    final listState = state.getListState(entityType);
    final uIState = state.getUIState(entityType);

    if (entity == null) {
      return DataRow(cells: [
        DataCell(SizedBox()),
        ...tableColumns.map(
          (field) => DataCell(
            SizedBox(),
          ),
        )
      ]);
    }

    return DataRow(
      selected: (listState.selectedIds ?? <String>[]).contains(entity.id),
      onSelectChanged:
          listState.isInMultiselect() ? (value) => onTap(entity) : null,
      cells: [
        if (!listState.isInMultiselect())
          DataCell(
            Row(
              children: <Widget>[
                if (state.prefState.isPreviewVisible || state.uiState.isEditing)
                  Text(
                    '•',
                    style: TextStyle(
                        color: (state.uiState.isEditing
                                ? entity.id == editingId
                                : entity.id == uIState.selectedId)
                            ? Theme.of(context).accentColor
                            : Colors.transparent,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ActionMenuButton(
                  entityActions: entity.getActions(
                      userCompany: state.userCompany,
                      includeEdit: true,
                      client: entity is BelongsToClient
                          ? state.clientState
                              .map[(entity as BelongsToClient)?.clientId]
                          : null),
                  isSaving: false,
                  entity: entity,
                  onSelected: (context, action) =>
                      handleEntityAction(context, entity, action),
                ),
              ],
            ),
            onTap: () => onTap(entity),
          ),
        ...tableColumns.map(
          (field) => DataCell(
            entityPresenter.getField(field: field, context: context),
            onTap: () => onTap(entity),
          ),
        )
      ],
    );
  }
}

class DatatableHeader extends StatelessWidget {
  const DatatableHeader({
    @required this.entityType,
    @required this.onClearPressed,
    @required this.onRefreshPressed,
  });

  final EntityType entityType;
  final Function onClearPressed;
  final Function onRefreshPressed;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final listUIState = state.getListState(entityType);

    Widget message = SizedBox();

    if (onClearPressed != null && listUIState.filterEntityId != null) {
      final entity = state.getEntityMap(
          listUIState.filterEntityType)[listUIState.filterEntityId];
      message = FilterListTile(
        onPressed: (context) => viewEntityById(
          context: context,
          entityId: listUIState.filterEntityId,
          entityType: listUIState.filterEntityType,
        ),
        onClearPressed: onClearPressed,
        entityType: listUIState.filterEntityType,
        entity: entity,
      );
    }

    return Row(
      children: <Widget>[
        FlatButton(
          child: Text(localization.refresh),
          onPressed: onRefreshPressed,
        ),
        SizedBox(width: 20),
        Expanded(child: message),
      ],
    );
  }
}
