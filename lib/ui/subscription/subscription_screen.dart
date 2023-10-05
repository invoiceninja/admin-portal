// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/subscription/subscription_list_vm.dart';
import 'package:invoiceninja_flutter/ui/subscription/subscription_presenter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'subscription_screen_vm.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsPaymentLinks';

  final SubscriptionScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);

    return ListScaffold(
      entityType: EntityType.paymentLink,
      onHamburgerLongPress: () =>
          store.dispatch(StartSubscriptionMultiselect()),
      appBarTitle: ListFilter(
        key: ValueKey(
            '__filter_${state.subscriptionListState.filterClearedAt}__'),
        entityType: EntityType.paymentLink,
        entityIds: viewModel.subscriptionList,
        filter: state.subscriptionListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterSubscriptions(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterSubscriptionsByState(state));
        },
      ),
      onCheckboxPressed: () {
        if (store.state.subscriptionListState.isInMultiselect()) {
          store.dispatch(ClearSubscriptionMultiselect());
        } else {
          store.dispatch(StartSubscriptionMultiselect());
        }
      },
      body: SubscriptionListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.paymentLink,
        tableColumns: SubscriptionPresenter.getAllTableFields(userCompany),
        defaultTableColumns:
            SubscriptionPresenter.getDefaultTableFields(userCompany),
        onSelectedSortField: (value) {
          store.dispatch(SortSubscriptions(value));
        },
        sortFields: [
          SubscriptionFields.createdAt,
          SubscriptionFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterSubscriptionsByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.subscriptionListState.isInMultiselect()) {
            store.dispatch(ClearSubscriptionMultiselect());
          } else {
            store.dispatch(StartSubscriptionMultiselect());
          }
        },
        onSelectedCustom1: (value) =>
            store.dispatch(FilterSubscriptionsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterSubscriptionsByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterSubscriptionsByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterSubscriptionsByCustom4(value)),
      ),
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.paymentLink)
          ? FloatingActionButton(
              heroTag: 'subscription_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.paymentLink);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization!.newPaymentLink,
            )
          : null,
    );
  }
}
