// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_actions.dart';
import 'package:invoiceninja_flutter/ui/webhook/view/webhook_view.dart';
import 'package:invoiceninja_flutter/ui/webhook/webhook_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class WebhookViewScreen extends StatelessWidget {
  const WebhookViewScreen({
    Key? key,
    this.isFilter = false,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsWebhookView';
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, WebhookViewVM>(
      converter: (Store<AppState> store) {
        return WebhookViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return WebhookView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class WebhookViewVM {
  WebhookViewVM({
    required this.state,
    required this.webhook,
    required this.company,
    required this.onEntityAction,
    required this.onBackPressed,
    required this.onRefreshed,
    required this.isSaving,
    required this.isLoading,
    required this.isDirty,
  });

  factory WebhookViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final webhook = state.webhookState.map[state.webhookUIState.selectedId] ??
        WebhookEntity(id: state.webhookUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(LoadWebhook(completer: completer, webhookId: webhook.id));
      return completer.future;
    }

    return WebhookViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: webhook.isNew,
      webhook: webhook,
      onRefreshed: (context) => _handleRefresh(context),
      onBackPressed: () {
        store.dispatch(UpdateCurrentRoute(WebhookScreen.route));
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([webhook], action, autoPop: true),
    );
  }

  final AppState state;
  final WebhookEntity webhook;
  final CompanyEntity? company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onRefreshed;
  final Function onBackPressed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
