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
import 'package:invoiceninja_flutter/redux/subscription/subscription_actions.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_selectors.dart';
import 'subscription_screen.dart';

class SubscriptionScreenBuilder extends StatelessWidget {
  const SubscriptionScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SubscriptionScreenVM>(
      converter: SubscriptionScreenVM.fromStore,
      builder: (context, vm) {
        return SubscriptionScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class SubscriptionScreenVM {
  SubscriptionScreenVM({
    required this.isInMultiselect,
    required this.subscriptionList,
    required this.userCompany,
    required this.onEntityAction,
    required this.subscriptionMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> subscriptionList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String?, SubscriptionEntity?> subscriptionMap;

  static SubscriptionScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return SubscriptionScreenVM(
      subscriptionMap: state.subscriptionState.map,
      subscriptionList: memoizedFilteredSubscriptionList(
        state.getUISelection(EntityType.paymentLink),
        state.subscriptionState.map,
        state.subscriptionState.list,
        state.subscriptionListState,
      ),
      userCompany: state.userCompany,
      isInMultiselect: state.subscriptionListState.isInMultiselect(),
      onEntityAction: (BuildContext context, List<BaseEntity> subscriptions,
              EntityAction action) =>
          handleSubscriptionAction(context, subscriptions, action),
    );
  }
}
