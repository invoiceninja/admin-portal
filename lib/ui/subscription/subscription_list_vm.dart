// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_actions.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/subscription/subscription_list_item.dart';
import 'package:invoiceninja_flutter/ui/subscription/subscription_presenter.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SubscriptionListBuilder extends StatelessWidget {
  const SubscriptionListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SubscriptionListVM>(
      converter: SubscriptionListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            entityType: EntityType.paymentLink,
            presenter: SubscriptionPresenter(),
            state: viewModel.state,
            entityList: viewModel.subscriptionList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            onClearMultiselect: viewModel.onClearMultielsect,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final subscriptionId = viewModel.subscriptionList[index];
              final subscription = viewModel.subscriptionMap[subscriptionId]!;
              final listState = state.getListState(EntityType.paymentLink);
              final isInMultiselect = listState.isInMultiselect();

              return SubscriptionListItem(
                user: viewModel.state.user,
                filter: viewModel.filter,
                subscription: subscription,
                isChecked:
                    isInMultiselect && listState.isSelected(subscription.id),
              );
            });
      },
    );
  }
}

class SubscriptionListVM {
  SubscriptionListVM({
    required this.state,
    required this.userCompany,
    required this.subscriptionList,
    required this.subscriptionMap,
    required this.filter,
    required this.isLoading,
    required this.listState,
    required this.onRefreshed,
    required this.onEntityAction,
    required this.tableColumns,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static SubscriptionListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>.value();
      }
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(RefreshData(completer: completer));
      return completer.future;
    }

    final state = store.state;

    return SubscriptionListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.subscriptionListState,
      subscriptionList: memoizedFilteredSubscriptionList(
        state.getUISelection(EntityType.paymentLink),
        state.subscriptionState.map,
        state.subscriptionState.list,
        state.subscriptionListState,
      ),
      subscriptionMap: state.subscriptionState.map,
      isLoading: state.isLoading,
      filter: state.subscriptionUIState.listUIState.filter,
      onEntityAction: (BuildContext context, List<BaseEntity> subscriptions,
              EntityAction action) =>
          handleSubscriptionAction(context, subscriptions, action),
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.paymentLink) ??
              SubscriptionPresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortSubscriptions(field)),
      onClearMultielsect: () => store.dispatch(ClearSubscriptionMultiselect()),
    );
  }

  final AppState state;
  final UserCompanyEntity? userCompany;
  final List<String> subscriptionList;
  final BuiltMap<String?, SubscriptionEntity?> subscriptionMap;
  final ListUIState listState;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
