import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_item.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class PaymentList extends StatelessWidget {
  const PaymentList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final PaymentListVM viewModel;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final listState = viewModel.listState;
    final listUIState = state.uiState.paymentUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final paymentList = viewModel.paymentList;

    if (isNotMobile(context) &&
        paymentList.isNotEmpty &&
        !paymentList.contains(state.paymentUIState.selectedId)) {
      viewEntityById(
          context: context,
          entityType: EntityType.payment,
          entityId: paymentList.first);
    }

    return Column(
      children: <Widget>[
        if (listState.filterEntityId != null)
          ListFilterMessage(
            filterEntityId: listState.filterEntityId,
            filterEntityType: listState.filterEntityType,
            onPressed: viewModel.onViewEntityFilterPressed,
            onClearPressed: viewModel.onClearEntityFilterPressed,
          ),
        Expanded(
          child: !viewModel.isLoaded
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.paymentList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: viewModel.paymentList.length,
                          itemBuilder: (BuildContext context, index) {
                            final paymentId = viewModel.paymentList[index];
                            final payment = state.paymentState.map[paymentId];
                            final client =
                                state.clientState.map[payment.clientId] ??
                                    ClientEntity(id: payment.clientId);

                            void showDialog() => showEntityActionsDialog(
                                  entities: [payment],
                                  context: context,
                                  client: client,
                                );

                            return PaymentListItem(
                              user: viewModel.user,
                              filter: viewModel.filter,
                              payment: payment,
                              onTap: () =>
                                  viewModel.onPaymentTap(context, payment),
                              onEntityAction: (EntityAction action) {
                                if (action == EntityAction.more) {
                                  showDialog();
                                } else {
                                  handlePaymentAction(
                                      context, [payment], action);
                                }
                              },
                              onLongPress: () async {
                                final longPressIsSelection = state.prefState
                                        .longPressSelectionIsDefault ??
                                    true;
                                if (longPressIsSelection && !isInMultiselect) {
                                  handlePaymentAction(context, [payment],
                                      EntityAction.toggleMultiselect);
                                } else {
                                  showDialog();
                                }
                              },
                              isChecked: isInMultiselect &&
                                  listUIState.isSelected(payment.id),
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }
}
