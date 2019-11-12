import 'dart:async';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
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
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_list.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';

class CompanyGatewayListBuilder extends StatelessWidget {
  const CompanyGatewayListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CompanyGatewayListVM>(
      converter: CompanyGatewayListVM.fromStore,
      builder: (context, viewModel) {
        return CompanyGatewayList(
          viewModel: viewModel,
        );
      },
    );
  }
}

class CompanyGatewayListVM {
  CompanyGatewayListVM({
    @required this.state,
    @required this.userCompany,
    @required this.companyGatewayList,
    @required this.companyGatewayMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onCompanyGatewayTap,
    @required this.listState,
    @required this.onRefreshed,
    @required this.onEntityAction,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
    @required this.onSortChanged,
    @required this.onRemovePressed,
  });

  static CompanyGatewayListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadCompanyGateways(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;
    final uiState = state.uiState.settingsUIState;
    final gatewayIds = memoizedFilteredCompanyGatewayList(
      state.companyGatewayState.map,
      state.companyGatewayState.list,
      state.companyGatewayListState,
      state.uiState.settingsUIState.settings.companyGatewayIds,
      !state.uiState.settingsUIState.isFiltered,
    );

    return CompanyGatewayListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.companyGatewayListState,
      companyGatewayList: gatewayIds,
      companyGatewayMap: state.companyGatewayState.map,
      isLoading: state.isLoading,
      isLoaded: state.companyGatewayState.isLoaded,
      filter: state.companyGatewayUIState.listUIState.filter,
      onClearEntityFilterPressed: () =>
          store.dispatch(FilterCompanyGatewaysByEntity()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.companyGatewayListState.filterEntityId,
          entityType: state.companyGatewayListState.filterEntityType),
      onCompanyGatewayTap: (context, companyGateway) {
        store.dispatch(ViewCompanyGateway(
            companyGatewayId: companyGateway.id, context: context));
      },
      onEntityAction: (BuildContext context, List<BaseEntity> companyGateway,
              EntityAction action) =>
          handleCompanyGatewayAction(context, companyGateway, action),
      onRefreshed: (context) => _handleRefresh(context),
      onRemovePressed: (gatewayId) {
        gatewayIds.remove(gatewayId);
        final settings = uiState.settings
            .rebuild((b) => b..companyGatewayIds = gatewayIds.join(','));
        store.dispatch(UpdateSettings(settings: settings));
      },
      onSortChanged: (int oldIndex, int newIndex) {
        final gatewayId = gatewayIds[oldIndex];
        gatewayIds.remove(gatewayId);
        gatewayIds.insert(newIndex, gatewayId);

        final settings = uiState.settings
            .rebuild((b) => b..companyGatewayIds = gatewayIds.join(','));
        store.dispatch(UpdateSettings(settings: settings));
      },
    );
  }

  final AppState state;
  final UserCompanyEntity userCompany;
  final List<String> companyGatewayList;
  final BuiltMap<String, CompanyGatewayEntity> companyGatewayMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, CompanyGatewayEntity) onCompanyGatewayTap;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
  final Function(int, int) onSortChanged;
  final Function(String) onRemovePressed;
}
