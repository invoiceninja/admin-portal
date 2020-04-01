import 'dart:async';
import 'package:invoiceninja_flutter/data/models/design_model.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/design/design_list_item.dart';
import 'package:invoiceninja_flutter/ui/design/design_presenter.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/design/design_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_actions.dart';

class DesignListBuilder extends StatelessWidget {
  const DesignListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DesignListVM>(
      converter: DesignListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            isLoaded: viewModel.isLoaded,
            entityType: EntityType.design,
            //presenter: ClientPresenter(),
            state: viewModel.state,
            entityList: viewModel.designList,
            onEntityTap: viewModel.onDesignTap,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onClearEntityFilterPressed: viewModel.onClearEntityFilterPressed,
            onViewEntityFilterPressed: viewModel.onViewEntityFilterPressed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final designId = viewModel.designList[index];
              final design = viewModel.designMap[designId];
              final listState = state.getListState(EntityType.design);
              final isInMultiselect = listState.isInMultiselect();

              void showDialog() => showEntityActionsDialog(
                    entities: [design],
                    context: context,
                  );

              return DesignListItem(
                user: viewModel.state.user,
                filter: viewModel.filter,
                design: design,
                onEntityAction: (EntityAction action) {
                  if (action == EntityAction.more) {
                    showDialog();
                  } else {
                    handleDesignAction(context, [design], action);
                  }
                },
                onTap: () => viewModel.onDesignTap(context, design),
                onLongPress: () async {
                  final longPressIsSelection =
                      state.prefState.longPressSelectionIsDefault ?? true;
                  if (longPressIsSelection && !isInMultiselect) {
                    handleDesignAction(
                        context, [design], EntityAction.toggleMultiselect);
                  } else {
                    showDialog();
                  }
                },
                isChecked: isInMultiselect && listState.isSelected(design.id),
              );
            });
      },
    );
  }
}

class DesignListVM {
  DesignListVM({
    @required this.state,
    @required this.userCompany,
    @required this.designList,
    @required this.designMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onDesignTap,
    @required this.listState,
    @required this.onRefreshed,
    @required this.onEntityAction,
    @required this.tableColumns,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
    @required this.onSortColumn,
  });

  static DesignListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadDesigns(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return DesignListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.designListState,
      designList: memoizedFilteredDesignList(
          state.designState.map, state.designState.list, state.designListState),
      designMap: state.designState.map,
      isLoading: state.isLoading,
      isLoaded: state.designState.isLoaded,
      filter: state.designUIState.listUIState.filter,
      onClearEntityFilterPressed: () => store.dispatch(FilterDesignsByEntity()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.designListState.filterEntityId,
          entityType: state.designListState.filterEntityType),
      onDesignTap: (context, design) {
        if (store.state.designListState.isInMultiselect()) {
          handleDesignAction(context, [design], EntityAction.toggleMultiselect);
        } else {
          editEntity(context: context, entity: design);
        }
      },
      onEntityAction: (BuildContext context, List<BaseEntity> designs,
              EntityAction action) =>
          handleDesignAction(context, designs, action),
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns: DesignPresenter.getTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortDesigns(field)),
    );
  }

  final AppState state;
  final UserCompanyEntity userCompany;
  final List<String> designList;
  final BuiltMap<String, DesignEntity> designMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, BaseEntity) onDesignTap;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
}
