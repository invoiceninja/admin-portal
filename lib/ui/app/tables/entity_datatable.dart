import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart' hide DataRow, DataCell, DataColumn;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/tables/app_data_table.dart';
import 'package:invoiceninja_flutter/ui/app/tables/app_data_table_source.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';

class EntityDataTableSource extends AppDataTableSource {
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
    entityPresenter.initialize(entity, context);

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

    bool isSelected = false;
    if (!listState.isInMultiselect() &&
        (state.prefState.isPreviewEnabled || state.uiState.isEditing) &&
        (state.prefState.isPreviewVisible || state.uiState.isEditing)) {
      if (state.uiState.isEditing
          ? entity.id == editingId
          : entity.id == uIState.selectedId) {
        isSelected = true;
      }
    }

    final backgroundColor = isSelected && isDesktop(context)
        ? convertHexStringToColor(state.prefState.enableDarkMode
            ? kDefaultDarkSelectedColor
            : kDefaultLightSelectedColor)
        : null;

    return DataRow(
      selected: (listState.selectedIds ?? <String>[]).contains(entity.id),
      onSelectChanged:
          listState.isInMultiselect() ? (value) => onTap(entity) : null,
      cells: [
        if (!listState.isInMultiselect())
          DataCell(
            Row(
              children: <Widget>[
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
                  onSelected: (context, action) => handleEntityAction(
                      context.getAppContext(), entity, action),
                ),
              ],
            ),
            onTap: () => onTap(entity),
            backgroundColor: backgroundColor,
          ),
        ...tableColumns.map(
          (field) => DataCell(
            entityPresenter.getField(field: field, context: context),
            onTap: () => onTap(entity),
            backgroundColor: backgroundColor,
          ),
        )
      ],
    );
  }
}
