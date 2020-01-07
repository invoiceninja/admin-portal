import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/product_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';

class EntityDataTableSource extends DataTableSource {
  EntityDataTableSource(
      {@required this.context,
      @required this.entityList,
      @required this.entityMap,
      @required this.entityPresenter,
      @required this.onTap});

  BuildContext context;
  List<String> entityList;
  EntityPresenter entityPresenter;
  BuiltMap<String, ProductEntity> entityMap;
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
    final product = entityMap[entityList[index]];
    entityPresenter.initialize(entity: product, context: context);

    return DataRow(cells: [
      DataCell(ActionMenuButton(
        entityActions: product.getActions(
            userCompany: state.userCompany, includeEdit: true),
        isSaving: false,
        entity: product,
        onSelected: (context, action) =>
            handleProductAction(context, [product], action),
      )),
      DataCell(Text(entityPresenter.getField(ProductFields.productKey)),
          onTap: () => onTap(product)),
      DataCell(Text(entityPresenter.getField(ProductFields.price)),
          onTap: () => onTap(product)),
      DataCell(Text(entityPresenter.getField(ProductFields.cost)),
          onTap: () => onTap(product)),
      DataCell(Text(entityPresenter.getField(ProductFields.quantity)),
          onTap: () => onTap(product)),
    ]);
  }
}
