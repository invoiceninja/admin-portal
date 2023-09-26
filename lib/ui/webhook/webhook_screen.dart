// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/webhook/webhook_list_vm.dart';
import 'package:invoiceninja_flutter/ui/webhook/webhook_presenter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'webhook_screen_vm.dart';

class WebhookScreen extends StatelessWidget {
  const WebhookScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsWebhooks';

  final WebhookScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);

    return ListScaffold(
      entityType: EntityType.webhook,
      onHamburgerLongPress: () => store.dispatch(StartWebhookMultiselect()),
      onCancelSettingsSection: kSettingsAccountManagement,
      appBarTitle: ListFilter(
        key: ValueKey('__filter_${state.webhookListState.filterClearedAt}__'),
        entityType: EntityType.webhook,
        entityIds: viewModel.webhookList,
        filter: state.webhookListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterWebhooks(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterWebhooksByState(state));
        },
      ),
      onCheckboxPressed: () {
        if (store.state.webhookListState.isInMultiselect()) {
          store.dispatch(ClearWebhookMultiselect());
        } else {
          store.dispatch(StartWebhookMultiselect());
        }
      },
      body: WebhookListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.webhook,
        tableColumns: WebhookPresenter.getAllTableFields(userCompany),
        defaultTableColumns:
            WebhookPresenter.getDefaultTableFields(userCompany),
        onSelectedSortField: (value) {
          store.dispatch(SortWebhooks(value));
        },
        sortFields: [
          WebhookFields.targetUrl,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterWebhooksByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.webhookListState.isInMultiselect()) {
            store.dispatch(ClearWebhookMultiselect());
          } else {
            store.dispatch(StartWebhookMultiselect());
          }
        },
        onSelectedCustom1: (value) =>
            store.dispatch(FilterWebhooksByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterWebhooksByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterWebhooksByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterWebhooksByCustom4(value)),
      ),
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.webhook)
          ? FloatingActionButton(
              heroTag: 'webhook_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.webhook);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization!.newWebhook,
            )
          : null,
    );
  }
}
