import 'dart:async';
import 'package:invoiceninja_flutter/data/models/tax_rate_model.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/tax_rate_list.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_actions.dart';

class TaxRateListBuilder extends StatelessWidget {
  const TaxRateListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaxRateListVM>(
      converter: TaxRateListVM.fromStore,
      builder: (context, viewModel) {
        return TaxRateList(
          viewModel: viewModel,
        );
      },
    );
  }
}

class TaxRateListVM {
  TaxRateListVM({
    @required this.userCompany,
    @required this.taxRateList,
    @required this.taxRateMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onTaxRateTap,
    @required this.listState,
    @required this.onRefreshed,
    @required this.onEntityAction,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
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
      onViewEntityFilterPressed: (BuildContext context) => store.dispatch(
          ViewClient(
              clientId: state.taxRateListState.filterEntityId,
              context: context)),
      onTaxRateTap: (context, taxRate) {
        store.dispatch(ViewTaxRate(taxRateId: taxRate.id, context: context));
      },
      onEntityAction: (BuildContext context, List<BaseEntity> taxRates,
              EntityAction action) =>
          handleTaxRateAction(context, taxRates, action),
      onRefreshed: (context) => _handleRefresh(context),
    );
  }

  final UserCompanyEntity userCompany;
  final List<String> taxRateList;
  final BuiltMap<String, TaxRateEntity> taxRateMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, TaxRateEntity) onTaxRateTap;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<TaxRateEntity>, EntityAction)
      onEntityAction;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
}
