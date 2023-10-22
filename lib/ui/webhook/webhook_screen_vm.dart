// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_actions.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_selectors.dart';
import 'webhook_screen.dart';

class WebhookScreenBuilder extends StatelessWidget {
  const WebhookScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, WebhookScreenVM>(
      converter: WebhookScreenVM.fromStore,
      builder: (context, vm) {
        return WebhookScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class WebhookScreenVM {
  WebhookScreenVM({
    required this.isInMultiselect,
    required this.webhookList,
    required this.userCompany,
    required this.onEntityAction,
    required this.webhookMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> webhookList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String, WebhookEntity> webhookMap;

  static WebhookScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return WebhookScreenVM(
      webhookMap: state.webhookState.map,
      webhookList: memoizedFilteredWebhookList(
          state.getUISelection(EntityType.webhook),
          state.webhookState.map,
          state.webhookState.list,
          state.webhookListState),
      userCompany: state.userCompany,
      isInMultiselect: state.webhookListState.isInMultiselect(),
      onEntityAction: (BuildContext context, List<BaseEntity> webhooks,
              EntityAction action) =>
          handleWebhookAction(context, webhooks, action),
    );
  }
}
