import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/product_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';

class EntityDataTableSource extends DataTableSource {
  EntityDataTableSource(
      {@required this.context,
      @required this.entityList,
      @required this.entityMap,
      @required this.entityPresenter,
      @required this.columnFields,
      @required this.entityType,
      @required this.onTap});

  EntityType entityType;
  BuildContext context;
  List<String> entityList;
  EntityPresenter entityPresenter;
  BuiltMap<String, BaseEntity> entityMap;
  List<String> columnFields;

  final Function(ProductEntity product) onTap;

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

    return DataRow(
      selected: (listState.selectedIds ?? <String>[]).contains(entity.id),
      onSelectChanged: listState.isInMultiselect()
          ? (value) {
              print('onSelectChanged: $value');
            }
          : null,
      cells: [
        DataCell(
          ActionMenuButton(
            entityActions: entity.getActions(
                userCompany: state.userCompany, includeEdit: true),
            isSaving: false,
            entity: entity,
            onSelected: (context, action) =>
                handleEntityAction(context, entity, action),
          ),
        ),
        ...columnFields.map(
          (field) => DataCell(
            Text(entityPresenter.getField(field)),
            onTap: () => onTap(entity),
          ),
        )
      ],
    );
  }
}
