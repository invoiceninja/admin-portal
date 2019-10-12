import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_screen.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/view/company_gateway_view_vm.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/edit/company_gateway_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CompanyGatewayEditScreen extends StatelessWidget {
  const CompanyGatewayEditScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsOnlinePaymentsEdit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CompanyGatewayEditVM>(
      converter: (Store<AppState> store) {
        return CompanyGatewayEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return CompanyGatewayEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.companyGateway.id),
        );
      },
    );
  }
}

class CompanyGatewayEditVM {
  CompanyGatewayEditVM({
    @required this.state,
    @required this.companyGateway,
    @required this.company,
    @required this.onChanged,
    @required this.isSaving,
    @required this.origCompanyGateway,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.onBackPressed,
    @required this.isLoading,
  });

  factory CompanyGatewayEditVM.fromStore(Store<AppState> store) {
    final companyGateway = store.state.companyGatewayUIState.editing;
    final state = store.state;

    return CompanyGatewayEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origCompanyGateway: state.companyGatewayState.map[companyGateway.id],
      companyGateway: companyGateway,
      company: state.selectedCompany,
      onChanged: (CompanyGatewayEntity companyGateway) {
        store.dispatch(UpdateCompanyGateway(companyGateway));
      },
      onBackPressed: () {
        if (state.uiState.currentRoute.contains(CompanyGatewayScreen.route)) {
          store.dispatch(UpdateCurrentRoute(companyGateway.isNew
              ? CompanyGatewayScreen.route
              : CompanyGatewayViewScreen.route));
        }
      },
      onCancelPressed: (BuildContext context) {
        store.dispatch(EditCompanyGateway(
            companyGateway: CompanyGatewayEntity(),
            context: context,
            force: true));
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
      onSavePressed: (BuildContext context) {
        final Completer<CompanyGatewayEntity> completer =
            new Completer<CompanyGatewayEntity>();
        store.dispatch(SaveCompanyGatewayRequest(
            completer: completer, companyGateway: companyGateway));
        return completer.future.then((savedCompanyGateway) {
          store.dispatch(UpdateCurrentRoute(CompanyGatewayViewScreen.route));
          if (isMobile(context)) {
            if (companyGateway.isNew) {
              Navigator.of(context)
                  .pushReplacementNamed(CompanyGatewayViewScreen.route);
            } else {
              Navigator.of(context).pop(savedCompanyGateway);
            }
          }
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
    );
  }

  final CompanyGatewayEntity companyGateway;
  final CompanyEntity company;
  final Function(CompanyGatewayEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final Function onBackPressed;
  final bool isLoading;
  final bool isSaving;
  final CompanyGatewayEntity origCompanyGateway;
  final AppState state;
}
