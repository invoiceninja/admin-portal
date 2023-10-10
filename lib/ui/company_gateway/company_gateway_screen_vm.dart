// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_selectors.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'company_gateway_screen.dart';

class CompanyGatewayScreenBuilder extends StatelessWidget {
  const CompanyGatewayScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CompanyGatewayScreenVM>(
      converter: CompanyGatewayScreenVM.fromStore,
      builder: (context, vm) {
        return CompanyGatewayScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class CompanyGatewayScreenVM {
  CompanyGatewayScreenVM({
    required this.isInMultiselect,
    required this.companyGatewayList,
    required this.userCompany,
    required this.companyGatewayMap,
    required this.onSavePressed,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> companyGatewayList;
  final BuiltMap<String?, CompanyGatewayEntity?> companyGatewayMap;
  final Function(BuildContext) onSavePressed;

  static CompanyGatewayScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return CompanyGatewayScreenVM(
        companyGatewayMap: state.companyGatewayState.map,
        companyGatewayList: memoizedFilteredCompanyGatewayList(
          state.companyGatewayState.map,
          state.companyGatewayState.list,
          state.companyGatewayListState,
          state.uiState.settingsUIState.settings.companyGatewayIds,
          !state.uiState.settingsUIState.isFiltered,
        ),
        userCompany: state.userCompany,
        isInMultiselect: state.companyGatewayListState.isInMultiselect(),
        onSavePressed: (context) {
          Debouncer.runOnComplete(
            () {
              final settingsUIState = store.state.uiState.settingsUIState;
              switch (settingsUIState.entityType) {
                case EntityType.company:
                  final completer = snackBarCompleter<Null>(
                      AppLocalization.of(context)!.savedSettings);
                  store.dispatch(SaveCompanyRequest(
                      completer: completer, company: settingsUIState.company));
                  break;
                case EntityType.group:
                  final completer = snackBarCompleter<GroupEntity>(
                      AppLocalization.of(context)!.savedSettings);
                  store.dispatch(SaveGroupRequest(
                      completer: completer, group: settingsUIState.group));
                  break;
                case EntityType.client:
                  final completer = snackBarCompleter<ClientEntity>(
                      AppLocalization.of(context)!.savedSettings);
                  store.dispatch(SaveClientRequest(
                      completer: completer, client: settingsUIState.client));
                  break;
              }
            },
          );
        });
  }
}
