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
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_selectors.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_list.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CompanyGatewayListBuilder extends StatelessWidget {
  const CompanyGatewayListBuilder({Key? key}) : super(key: key);

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
    required this.state,
    required this.companyGatewayList,
    required this.companyGatewayMap,
    required this.filter,
    required this.onCompanyGatewayTap,
    required this.listState,
    required this.onRefreshed,
    required this.onSortChanged,
    required this.onRemovePressed,
  });

  static CompanyGatewayListVM fromStore(Store<AppState> store) {
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
    final uiState = state.uiState.settingsUIState;
    String? companyGatewayIds =
        state.uiState.settingsUIState.settings.companyGatewayIds;
    if ((companyGatewayIds ?? '').isEmpty) {
      companyGatewayIds = state.companyGatewayState.list.join(',');
    }

    final gatewayIds = memoizedFilteredCompanyGatewayList(
      state.companyGatewayState.map,
      state.companyGatewayState.list,
      state.companyGatewayListState,
      companyGatewayIds,
      !state.uiState.settingsUIState.isFiltered,
    );

    return CompanyGatewayListVM(
      state: state,
      listState: state.companyGatewayListState,
      companyGatewayList: gatewayIds,
      companyGatewayMap: state.companyGatewayState.map,
      filter: state.companyGatewayUIState.listUIState.filter,
      onCompanyGatewayTap: (context, companyGateway) {
        if (store.state.companyGatewayListState.isInMultiselect()) {
          handleCompanyGatewayAction(
              context, [companyGateway], EntityAction.toggleMultiselect);
        } else {
          viewEntity(entity: companyGateway);
        }
      },
      onRefreshed: (context) => _handleRefresh(context),
      onRemovePressed: (gatewayId) {
        gatewayIds.remove(gatewayId);
        final settings = uiState.settings.rebuild((b) => b
          ..companyGatewayIds =
              gatewayIds.isEmpty ? '0' : gatewayIds.join(','));
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
  final List<String> companyGatewayList;
  final BuiltMap<String?, CompanyGatewayEntity?> companyGatewayMap;
  final ListUIState listState;
  final String? filter;
  final Function(BuildContext, CompanyGatewayEntity) onCompanyGatewayTap;
  final Function(BuildContext) onRefreshed;
  final Function(int, int) onSortChanged;
  final Function(String) onRemovePressed;
}
