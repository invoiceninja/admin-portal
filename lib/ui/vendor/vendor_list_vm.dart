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
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_list_item.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_presenter.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class VendorListBuilder extends StatelessWidget {
  const VendorListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VendorListVM>(
      converter: VendorListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
          onClearMultiselect: viewModel.onClearMultielsect,
          entityType: EntityType.vendor,
          presenter: VendorPresenter(),
          state: viewModel.state,
          entityList: viewModel.vendorList,
          tableColumns: viewModel.tableColumns,
          onRefreshed: viewModel.onRefreshed,
          onSortColumn: viewModel.onSortColumn,
          itemBuilder: (BuildContext context, index) {
            final vendorId = viewModel.vendorList[index];
            final vendor = viewModel.vendorMap[vendorId]!;
            final state = viewModel.state;
            final listUIState = state.getListState(EntityType.vendor);

            return VendorListItem(
              filter: viewModel.filter,
              vendor: vendor,
              isChecked: listUIState.isSelected(vendor.id),
              showCheck: listUIState.isInMultiselect(),
            );
          },
        );
      },
    );
  }
}

class VendorListVM {
  VendorListVM({
    required this.state,
    required this.vendorList,
    required this.vendorMap,
    required this.filter,
    required this.isLoading,
    required this.listState,
    required this.onRefreshed,
    required this.tableColumns,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static VendorListVM fromStore(Store<AppState> store) {
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

    return VendorListVM(
      state: state,
      listState: state.vendorListState,
      vendorList: memoizedFilteredVendorList(
          state.getUISelection(EntityType.vendor),
          state.vendorState.map,
          state.vendorState.list,
          state.vendorListState,
          state.userState.map,
          state.staticState),
      vendorMap: state.vendorState.map,
      isLoading: state.isLoading,
      filter: state.vendorUIState.listUIState.filter,
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.vendor) ??
              VendorPresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortVendors(field)),
      onClearMultielsect: () => store.dispatch(ClearVendorMultiselect()),
    );
  }

  final AppState state;
  final List<String> vendorList;
  final BuiltMap<String, VendorEntity> vendorMap;
  final ListUIState listState;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
