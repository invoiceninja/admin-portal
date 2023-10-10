// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/webhook/edit/webhook_edit.dart';
import 'package:invoiceninja_flutter/ui/webhook/view/webhook_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class WebhookEditScreen extends StatelessWidget {
  const WebhookEditScreen({Key? key}) : super(key: key);

  static const String route = '/$kSettings/$kSettingsWebhookEdit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, WebhookEditVM>(
      converter: (Store<AppState> store) {
        return WebhookEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return WebhookEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.webhook.updatedAt),
        );
      },
    );
  }
}

class WebhookEditVM {
  WebhookEditVM({
    required this.state,
    required this.webhook,
    required this.company,
    required this.onChanged,
    required this.isSaving,
    required this.origWebhook,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.isLoading,
  });

  factory WebhookEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final webhook = state.webhookUIState.editing!;

    return WebhookEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origWebhook: state.webhookState.map[webhook.id],
      webhook: webhook,
      company: state.company,
      onChanged: (WebhookEntity webhook) {
        store.dispatch(UpdateWebhook(webhook));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(entity: WebhookEntity(), force: true);
        if (state.webhookUIState.cancelCompleter != null) {
          state.webhookUIState.cancelCompleter!.complete();
        } else {
          store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
        }
      },
      onSavePressed: (BuildContext context) {
        Debouncer.runOnComplete(() {
          final webhook = store.state.webhookUIState.editing;
          final localization = navigatorKey.localization;
          final navigator = navigatorKey.currentState;
          final Completer<WebhookEntity> completer =
              new Completer<WebhookEntity>();
          store.dispatch(
              SaveWebhookRequest(completer: completer, webhook: webhook));
          return completer.future.then((savedWebhook) {
            showToast(webhook!.isNew
                ? localization!.createdWebhook
                : localization!.updatedWebhook);

            if (state.prefState.isMobile) {
              store.dispatch(UpdateCurrentRoute(WebhookViewScreen.route));
              if (webhook.isNew) {
                navigator!.pushReplacementNamed(WebhookViewScreen.route);
              } else {
                navigator!.pop(savedWebhook);
              }
            } else {
              viewEntity(
                entity: savedWebhook,
                force: true,
              );
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
    );
  }

  final WebhookEntity webhook;
  final CompanyEntity? company;
  final Function(WebhookEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final WebhookEntity? origWebhook;
  final AppState state;
}
