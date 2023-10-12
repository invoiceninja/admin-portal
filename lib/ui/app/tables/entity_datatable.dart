// Flutter imports:

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EntityDataTableSource extends DataTableSource {
  EntityDataTableSource(
      {required this.context,
      required this.editingId,
      required this.entityList,
      required this.entityMap,
      required this.entityPresenter,
      required this.tableColumns,
      required this.entityType,
      required this.onTap});

  EntityType entityType;
  String editingId;
  BuildContext context;
  List<String?> entityList;
  EntityPresenter? entityPresenter;
  BuiltMap<String?, BaseEntity?>? entityMap;
  List<String>? tableColumns;

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
    final prefState = state.prefState;
    final entity = entityMap![entityList[index]]!;
    entityPresenter!.initialize(entity, context);

    final listState = state.getListState(entityType);
    final uIState = state.getUIState(entityType);

    bool isSelected = false;
    if (!listState.isInMultiselect() &&
        (state.prefState.isPreviewVisible || state.uiState.isEditing)) {
      if (state.uiState.isEditing
          ? entity.id == editingId
          : entity.id == uIState!.selectedId) {
        isSelected = true;
      }
    }

    Color? backgroundColor;
    final rowColor = state.prefState.activeCustomColors[
            PrefState.THEME_TABLE_ALTERNATE_ROW_BACKGROUND_COLOR] ??
        '';

    if (isSelected && isDesktop(context)) {
      backgroundColor = convertHexStringToColor(state.prefState.enableDarkMode
          ? kDefaultDarkSelectedColor
          : kDefaultLightSelectedColor);
    } else if (rowColor.isNotEmpty && index % 2 == 0) {
      backgroundColor = convertHexStringToColor(rowColor);
    }

    final wideFields = [
      'public_notes',
      'private_notes',
      'description',
      'custom1',
      'custom2',
      'custom3',
      'custom4',
    ];

    return DataRow(
      color: backgroundColor == null
          ? null
          : MaterialStateProperty.all<Color>(backgroundColor),
      selected: (listState.selectedIds ?? <String>[]).contains(entity.id),
      onSelectChanged:
          listState.isInMultiselect() ? (value) => onTap(entity) : null,
      cells: [
        if (!listState.isInMultiselect())
          DataCell(
            Row(
              children: <Widget>[
                IconButton(
                  tooltip: prefState.enableTooltips
                      ? AppLocalization.of(context)!.longPressToSelect
                      : null,
                  onPressed: () => editEntity(entity: entity),
                  icon: GestureDetector(
                    child: Icon(MdiIcons.circleEditOutline),
                    onLongPress: () => handleEntityAction(
                        entity, EntityAction.toggleMultiselect),
                  ),
                ),
                ActionMenuButton(
                  entityActions: entity.getActions(
                      userCompany: state.userCompany,
                      includeEdit: state.prefState.tapSelectedToEdit,
                      client: entity is BelongsToClient
                          ? state.clientState
                              .map[(entity as BelongsToClient).clientId]
                          : null),
                  isSaving: false,
                  entity: entity,
                  onSelected: (context, action) =>
                      handleEntityAction(entity, action),
                ),
              ],
            ),
            onTap: () => onTap(entity),
          ),
        ...tableColumns!.map(
          (field) => DataCell(
            ConstrainedBox(
              child: entityPresenter!.getField(field: field, context: context),
              constraints: BoxConstraints(
                maxWidth: wideFields.contains(field)
                    ? kTableColumnWidthMax * 1.5
                    : kTableColumnWidthMax,
                minWidth: field == ProductFields.description
                    ? kTableColumnWidthMax
                    : 0,
              ),
            ),
            onTap: () => onTap(entity),
            onLongPress: () => selectEntity(entity: entity, longPress: true),
          ),
        )
      ],
    );
  }
}
