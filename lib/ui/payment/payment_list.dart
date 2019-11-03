import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_item.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentList extends StatelessWidget {
  const PaymentList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final PaymentListVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final listState = viewModel.listState;
    final filteredEntityId = listState.filterEntityId;
    final listUIState = state.uiState.paymentUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    BaseEntity filteredEntity;
    String filteredMessage;

    switch (listState.filterEntityType) {
      case EntityType.client:
        filteredMessage = localization.filteredByClient;
        filteredEntity = filteredEntityId != null
            ? state.clientState.map[filteredEntityId]
            : null;
        break;
      case EntityType.invoice:
        filteredMessage = localization.filteredByInvoice;
        filteredEntity = filteredEntityId != null
            ? state.invoiceState.map[filteredEntityId]
            : null;
        break;
    }

    return Column(
      children: <Widget>[
        if (filteredEntity != null)
          ListFilterMessage(
            title: '$filteredMessage: ${filteredEntity.listDisplayName}',
            onPressed: viewModel.onViewEntityFilterPressed,
            onClearPressed: viewModel.onClearEntityFilterPressed,
          ),
        Expanded(
          child: !viewModel.isLoaded
              ? (viewModel.isLoading ? LoadingIndicator() : SizedBox())
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
                                paymentClientSelector(paymentId, state);

                            void showDialog() => showEntityActionsDialog(
                                entities: [payment],
                                context: context,
                                userCompany: state.userCompany,
                                client: client,
                                onEntityAction: viewModel.onEntityAction);

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
                                  viewModel.onEntityAction(
                                      context, [payment], action);
                                }
                              },
                              onLongPress: () async {
                                final longPressIsSelection =
                                    state.uiState.longPressSelectionIsDefault ??
                                        true;
                                if (longPressIsSelection && !isInMultiselect) {
                                  viewModel.onEntityAction(context, [payment],
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
