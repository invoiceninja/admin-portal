import 'dart:async';
import 'package:invoiceninja_flutter/data/models/tax_rate_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/tax_rate_list_item.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_actions.dart';

class TaxRateListBuilder extends StatelessWidget {
  const TaxRateListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaxRateListVM>(
      converter: TaxRateListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            isLoaded: viewModel.isLoaded,
            entityType: EntityType.taxRate,
            //presenter: ClientPresenter(),
            state: viewModel.state,
            entityList: viewModel.taxRateList,
            onEntityTap: viewModel.onTaxRateTap,
            //tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onClearEntityFilterPressed: viewModel.onClearEntityFilterPressed,
            onViewEntityFilterPressed: viewModel.onViewEntityFilterPressed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final taxRateId = viewModel.taxRateList[index];
              final taxRate = viewModel.taxRateMap[taxRateId];
              final listState = state.getListState(EntityType.taxRate);
              final isInMultiselect = listState.isInMultiselect();

              void showDialog() => showEntityActionsDialog(
                    entities: [taxRate],
                    context: context,
                  );

              return TaxRateListItem(
                user: viewModel.userCompany.user,
                filter: viewModel.filter,
                taxRate: taxRate,
                onTap: () => viewModel.onTaxRateTap(context, taxRate),
                onEntityAction: (EntityAction action) {
                  if (action == EntityAction.more) {
                    showDialog();
                  } else {
                    handleTaxRateAction(context, [taxRate], action);
                  }
                },
                onLongPress: () async {
                  final longPressIsSelection =
                      state.prefState.longPressSelectionIsDefault ?? true;
                  if (longPressIsSelection && !isInMultiselect) {
                    handleTaxRateAction(
                        context, [taxRate], EntityAction.toggleMultiselect);
                  } else {
                    showDialog();
                  }
                },
                isChecked: isInMultiselect && listState.isSelected(taxRate.id),
              );
            });
      },
    );
  }
}

class TaxRateListVM {
  TaxRateListVM({
    @required this.state,
    @required this.userCompany,
    @required this.taxRateList,
    @required this.taxRateMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onTaxRateTap,
    @required this.listState,
    @required this.onRefreshed,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
    @required this.onSortColumn,
  });

  static TaxRateListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadTaxRates(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return TaxRateListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.taxRateListState,
      taxRateList: memoizedFilteredTaxRateList(state.taxRateState.map,
          state.taxRateState.list, state.taxRateListState),
      taxRateMap: state.taxRateState.map,
      isLoading: state.isLoading,
      isLoaded: state.taxRateState.isLoaded,
      filter: state.taxRateUIState.listUIState.filter,
      onClearEntityFilterPressed: () =>
          store.dispatch(FilterTaxRatesByEntity()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.taxRateListState.filterEntityId,
          entityType: state.taxRateListState.filterEntityType),
      onTaxRateTap: (context, taxRate) {
        if (store.state.taxRateListState.isInMultiselect()) {
          handleTaxRateAction(
              context, [taxRate], EntityAction.toggleMultiselect);
        } else {
          viewEntity(context: context, entity: taxRate);
        }
      },
      onRefreshed: (context) => _handleRefresh(context),
      onSortColumn: (field) => store.dispatch(SortTaxRates(field)),
    );
  }

  final AppState state;
  final UserCompanyEntity userCompany;
  final List<String> taxRateList;
  final BuiltMap<String, TaxRateEntity> taxRateMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, BaseEntity) onTaxRateTap;
  final Function(BuildContext) onRefreshed;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
  final Function(String) onSortColumn;
}
