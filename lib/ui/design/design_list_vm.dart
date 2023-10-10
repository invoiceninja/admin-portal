// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_actions.dart';
import 'package:invoiceninja_flutter/redux/design/design_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/design/design_list_item.dart';
import 'package:invoiceninja_flutter/ui/design/design_presenter.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DesignListBuilder extends StatelessWidget {
  const DesignListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DesignListVM>(
      converter: DesignListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            onClearMultiselect: viewModel.onClearMultielsect,
            entityType: EntityType.design,
            //presenter: ClientPresenter(),
            state: viewModel.state,
            entityList: viewModel.designList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final designId = viewModel.designList[index];
              final design = viewModel.designMap[designId]!;
              final listState = state.getListState(EntityType.design);
              final isInMultiselect = listState.isInMultiselect();

              return DesignListItem(
                filter: viewModel.filter,
                design: design,
                isChecked: isInMultiselect && listState.isSelected(design.id),
              );
            });
      },
    );
  }
}

class DesignListVM {
  DesignListVM({
    required this.state,
    required this.userCompany,
    required this.designList,
    required this.designMap,
    required this.filter,
    required this.isLoading,
    required this.listState,
    required this.onRefreshed,
    required this.onEntityAction,
    required this.tableColumns,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static DesignListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>.value();
      }
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(RefreshData(completer: completer));
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
      filter: state.designUIState.listUIState.filter,
      onEntityAction: (BuildContext context, List<BaseEntity> designs,
              EntityAction action) =>
          handleDesignAction(context, designs, action),
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns: DesignPresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortDesigns(field)),
      onClearMultielsect: () => store.dispatch(ClearDesignMultiselect()),
    );
  }

  final AppState state;
  final UserCompanyEntity? userCompany;
  final List<String> designList;
  final BuiltMap<String, DesignEntity> designMap;
  final ListUIState listState;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
