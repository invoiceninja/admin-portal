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
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_actions.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/tax_rate_list_item.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaxRateListBuilder extends StatelessWidget {
  const TaxRateListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaxRateListVM>(
      converter: TaxRateListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            onClearMultiselect: viewModel.onClearMultielsect,
            entityType: EntityType.taxRate,
            //presenter: ClientPresenter(),
            state: viewModel.state,
            entityList: viewModel.taxRateList,
            //tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final taxRateId = viewModel.taxRateList[index];
              final taxRate = viewModel.taxRateMap[taxRateId]!;
              final listState = state.getListState(EntityType.taxRate);
              final isInMultiselect = listState.isInMultiselect();

              return TaxRateListItem(
                user: viewModel.userCompany!.user,
                filter: viewModel.filter,
                taxRate: taxRate,
                isChecked: isInMultiselect && listState.isSelected(taxRate.id),
              );
            });
      },
    );
  }
}

class TaxRateListVM {
  TaxRateListVM({
    required this.state,
    required this.userCompany,
    required this.taxRateList,
    required this.taxRateMap,
    required this.filter,
    required this.isLoading,
    required this.listState,
    required this.onRefreshed,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static TaxRateListVM fromStore(Store<AppState> store) {
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

    return TaxRateListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.taxRateListState,
      taxRateList: memoizedFilteredTaxRateList(
          state.getUISelection(EntityType.taxRate),
          state.taxRateState.map,
          state.taxRateState.list,
          state.taxRateListState),
      taxRateMap: state.taxRateState.map,
      isLoading: state.isLoading,
      filter: state.taxRateUIState.listUIState.filter,
      onRefreshed: (context) => _handleRefresh(context),
      onSortColumn: (field) => store.dispatch(SortTaxRates(field)),
      onClearMultielsect: () => store.dispatch(ClearTaxRateMultiselect()),
    );
  }

  final AppState state;
  final UserCompanyEntity? userCompany;
  final List<String> taxRateList;
  final BuiltMap<String?, TaxRateEntity?> taxRateMap;
  final ListUIState listState;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
