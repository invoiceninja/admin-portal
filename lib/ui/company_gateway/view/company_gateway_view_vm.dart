import 'dart:async';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_screen.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/view/company_gateway_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';

class CompanyGatewayViewScreen extends StatelessWidget {
  const CompanyGatewayViewScreen({
    Key key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;

  static const String route = '/$kSettings/$kSettingsCompanyGatewaysView';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CompanyGatewayViewVM>(
      converter: (Store<AppState> store) {
        return CompanyGatewayViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return CompanyGatewayView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class CompanyGatewayViewVM {
  CompanyGatewayViewVM({
    @required this.state,
    @required this.companyGateway,
    @required this.company,
    @required this.onEntityAction,
    @required this.onBackPressed,
    @required this.onRefreshed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory CompanyGatewayViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final companyGateway =
        state.companyGatewayState.map[state.companyGatewayUIState.selectedId] ??
            CompanyGatewayEntity(id: state.companyGatewayUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadCompanyGateway(
          completer: completer, companyGatewayId: companyGateway.id));
      return completer.future;
    }

    return CompanyGatewayViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: companyGateway.isNew,
      companyGateway: companyGateway,
      onRefreshed: (context) => _handleRefresh(context),
      onBackPressed: () {
        store.dispatch(UpdateCurrentRoute(CompanyGatewayScreen.route));
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions(
              context.getAppContext(), [companyGateway], action,
              autoPop: true),
    );
  }

  final AppState state;
  final CompanyGatewayEntity companyGateway;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function onBackPressed;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
