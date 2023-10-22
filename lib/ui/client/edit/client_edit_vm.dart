// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientEditScreen extends StatelessWidget {
  const ClientEditScreen({Key? key}) : super(key: key);

  static const String route = '/client/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClientEditVM>(
      converter: (Store<AppState> store) {
        return ClientEditVM.fromStore(store);
      },
      builder: (context, vm) {
        return ClientEdit(
          viewModel: vm,
        );
      },
    );
  }
}

class ClientEditVM {
  ClientEditVM({
    required this.state,
    required this.company,
    required this.isSaving,
    required this.client,
    required this.origClient,
    required this.onChanged,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.staticState,
    required this.copyBillingAddress,
    required this.copyShippingAddress,
  });

  factory ClientEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final client = state.clientUIState.editing!;

    return ClientEditVM(
        state: state,
        company: state.company,
        client: client,
        origClient: state.clientState.map[client.id],
        staticState: state.staticState,
        isSaving: state.isSaving,
        onChanged: (ClientEntity client) =>
            store.dispatch(UpdateClient(client)),
        copyBillingAddress: () =>
            store.dispatch(UpdateClient(client.rebuild((b) => b
              ..shippingAddress1 = client.address1
              ..shippingAddress2 = client.address2
              ..shippingCity = client.city
              ..shippingState = client.state
              ..shippingPostalCode = client.postalCode
              ..shippingCountryId = client.countryId))),
        copyShippingAddress: () =>
            store.dispatch(UpdateClient(client.rebuild((b) => b
              ..address1 = client.shippingAddress1
              ..address2 = client.shippingAddress2
              ..city = client.shippingCity
              ..state = client.shippingState
              ..postalCode = client.shippingPostalCode
              ..countryId = client.shippingCountryId))),
        onCancelPressed: (BuildContext context) {
          createEntity(entity: ClientEntity(), force: true);
          if (state.clientUIState.cancelCompleter != null) {
            state.clientUIState.cancelCompleter!.complete();
          } else {
            store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
          }
        },
        onSavePressed: (BuildContext context) {
          Debouncer.runOnComplete(() {
            final client = store.state.clientUIState.editing!;
            if (!client.hasNameSet) {
              showDialog<ErrorDialog>(
                  context: context,
                  builder: (BuildContext context) {
                    return ErrorDialog(
                        AppLocalization.of(navigatorKey.currentContext!)!
                            .pleaseEnterAClientOrContactName);
                  });
              return null;
            }
            final Completer<ClientEntity> completer = Completer<ClientEntity>();
            final localization = navigatorKey.localization;
            final navigator = navigatorKey.currentState;
            store.dispatch(
                SaveClientRequest(completer: completer, client: client));
            return completer.future.then((savedClient) {
              showToast(client.isNew
                  ? localization!.createdClient
                  : localization!.updatedClient);
              if (state.prefState.isMobile) {
                store.dispatch(UpdateCurrentRoute(ClientViewScreen.route));
                if (client.isNew && state.clientUIState.saveCompleter == null) {
                  navigator!.pushReplacementNamed(ClientViewScreen.route);
                } else {
                  navigator!.pop(savedClient);
                }
              } else if (state.clientUIState.saveCompleter == null) {
                if (!state.prefState.isPreviewVisible) {
                  store.dispatch(TogglePreviewSidebar());
                }
                viewEntity(entity: savedClient, force: true);
              }
            }).catchError((Object error) {
              showDialog<ErrorDialog>(
                  context: navigatorKey.currentContext!,
                  builder: (BuildContext context) {
                    return ErrorDialog(error);
                  });
            });
          });
        });
  }

  final AppState state;
  final CompanyEntity? company;
  final bool isSaving;
  final ClientEntity client;
  final ClientEntity? origClient;
  final Function(ClientEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final StaticState staticState;
  final Function() copyShippingAddress;
  final Function() copyBillingAddress;
}
