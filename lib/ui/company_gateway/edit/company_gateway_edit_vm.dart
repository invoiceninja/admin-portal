// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

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
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/edit/company_gateway_edit.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/view/company_gateway_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class CompanyGatewayEditScreen extends StatelessWidget {
  const CompanyGatewayEditScreen({Key? key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsCompanyGatewaysEdit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CompanyGatewayEditVM>(
      converter: (Store<AppState> store) {
        return CompanyGatewayEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return CompanyGatewayEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.companyGateway.updatedAt),
        );
      },
    );
  }
}

class CompanyGatewayEditVM {
  CompanyGatewayEditVM({
    required this.state,
    required this.companyGateway,
    required this.company,
    required this.onChanged,
    required this.isSaving,
    required this.origCompanyGateway,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.isLoading,
    required this.onGatewaySignUpPressed,
  });

  factory CompanyGatewayEditVM.fromStore(Store<AppState> store) {
    final companyGateway = store.state.companyGatewayUIState.editing!;
    final state = store.state;

    return CompanyGatewayEditVM(
        state: state,
        isLoading: state.isLoading,
        isSaving: state.isSaving,
        origCompanyGateway: state.companyGatewayState.map[companyGateway.id],
        companyGateway: companyGateway,
        company: state.company,
        onChanged: (CompanyGatewayEntity companyGateway) {
          store.dispatch(UpdateCompanyGateway(companyGateway));
        },
        onCancelPressed: (BuildContext context) {
          createEntity(entity: CompanyGatewayEntity(), force: true);
          store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
        },
        onSavePressed: (BuildContext context) {
          Debouncer.runOnComplete(() {
            final localization = navigatorKey.localization;
            final navigator = navigatorKey.currentState;
            final companyGateway = store.state.companyGatewayUIState.editing;
            final Completer<CompanyGatewayEntity> completer =
                new Completer<CompanyGatewayEntity>();
            store.dispatch(SaveCompanyGatewayRequest(
                completer: completer, companyGateway: companyGateway));
            return completer.future.then((savedCompanyGateway) {
              showToast(companyGateway!.isNew
                  ? localization!.createdCompanyGateway
                  : localization!.updatedCompanyGateway);

              final company = store.state.company;
              if ((company.settings.companyGatewayIds ?? '').isNotEmpty) {
                store.dispatch(SaveCompanyRequest(
                    completer: Completer<Null>(),
                    company: company.rebuild((b) => b
                      ..settings.companyGatewayIds =
                          company.settings.companyGatewayIds! +
                              ',' +
                              savedCompanyGateway.id)));
              }

              if (state.prefState.isMobile) {
                store.dispatch(
                    UpdateCurrentRoute(CompanyGatewayViewScreen.route));
                if (companyGateway.isNew) {
                  navigator!
                      .pushReplacementNamed(CompanyGatewayViewScreen.route);
                } else {
                  navigator!.pop(savedCompanyGateway);
                }
              } else {
                viewEntityById(
                    entityId: savedCompanyGateway.id,
                    entityType: EntityType.companyGateway,
                    force: true);
              }
            }).catchError((Object error) {
              showDialog<ErrorDialog>(
                  context: navigatorKey.currentContext!,
                  builder: (BuildContext context) {
                    return ErrorDialog(error);
                  });
            });
          });
        },
        onGatewaySignUpPressed: (gatewayId) async {
          final webClient = WebClient();
          final credentials = state.credentials;
          final url = '${credentials.url}/one_time_token';

          store.dispatch(StartSaving());

          webClient
              .post(url, credentials.token,
                  data: jsonEncode({
                    'context': {'return_url': ''}
                  }))
              .then((dynamic response) {
            store.dispatch(StopSaving());
            switch (gatewayId) {
              case kGatewayStripeConnect:
                launchUrl(Uri.parse(
                    '${cleanApiUrl(credentials.url)}/stripe/signup/${response['hash']}'));
                break;
              case kGatewayWePay:
                launchUrl(Uri.parse(
                    '${cleanApiUrl(credentials.url)}/wepay/signup/${response['hash']}'));
                break;
              case kGatewayPayPalPlatform:
                launchUrl(Uri.parse(
                    '${cleanApiUrl(credentials.url)}/paypal?hash=${response['hash']}'));
                break;
            }
          }).catchError((dynamic error) {
            store.dispatch(StopSaving());
            showErrorDialog(message: '$error');
          });
        });
  }

  final CompanyGatewayEntity companyGateway;
  final CompanyEntity? company;
  final Function(CompanyGatewayEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final CompanyGatewayEntity? origCompanyGateway;
  final AppState state;
  final Function(String) onGatewaySignUpPressed;
}
