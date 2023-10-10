// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_screen.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/view/company_gateway_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CompanyGatewayViewScreen extends StatelessWidget {
  const CompanyGatewayViewScreen({
    Key? key,
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
    required this.state,
    required this.companyGateway,
    required this.company,
    required this.onEntityAction,
    required this.onBackPressed,
    required this.onRefreshed,
    required this.isSaving,
    required this.isLoading,
    required this.isDirty,
    required this.onStripeImportPressed,
    required this.onStripeVerifyPressed,
  });

  factory CompanyGatewayViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final companyGateway =
        state.companyGatewayState.map[state.companyGatewayUIState.selectedId] ??
            CompanyGatewayEntity(id: state.companyGatewayUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
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
          handleEntitiesActions([companyGateway], action, autoPop: true),
      onStripeVerifyPressed: (BuildContext context) {
        final localization = AppLocalization.of(context);
        final webClient = WebClient();
        final credentials = state.credentials;
        final url = '${credentials.url}/stripe/verify';

        passwordCallback(
            context: context,
            callback: (password, idToken) {
              store.dispatch(StartSaving());
              webClient
                  .post(url, credentials.token,
                      password: password, idToken: idToken)
                  .then((dynamic response) {
                store.dispatch(StopSaving());

                showDialog<void>(
                    context: navigatorKey.currentContext!,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(localization!.customerCount),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(localization.close.toUpperCase()))
                        ],
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 120, child: Text('Stripe')),
                                SizedBox(
                                    width: 100,
                                    child: Text(
                                      '${response['stripe_customer_count']}',
                                      textAlign: TextAlign.end,
                                    )),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                SizedBox(width: 120, child: Text(kAppName)),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                      '${(response['stripe_customers'] as Iterable).length}',
                                      textAlign: TextAlign.end),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              }).catchError((dynamic error) {
                store.dispatch(StopSaving());
                showErrorDialog(message: error);
              });
            });
      },
      onStripeImportPressed: (BuildContext context) {
        final localization = AppLocalization.of(context);
        final webClient = WebClient();
        final credentials = state.credentials;
        final url = '${credentials.url}/stripe/import_customers';

        passwordCallback(
            context: context,
            callback: (password, idToken) {
              store.dispatch(StartSaving());
              webClient
                  .post(url, credentials.token,
                      password: password, idToken: idToken)
                  .then((dynamic response) {
                store.dispatch(StopSaving());
                showMessageDialog(message: localization!.importedCustomers);
              }).catchError((dynamic error) {
                store.dispatch(StopSaving());
                showErrorDialog(message: error);
              });
            });
      },
    );
  }

  final AppState state;
  final CompanyGatewayEntity companyGateway;
  final CompanyEntity? company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function onBackPressed;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
  final Function(BuildContext) onStripeImportPressed;
  final Function(BuildContext) onStripeVerifyPressed;
}
