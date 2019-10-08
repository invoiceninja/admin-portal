import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
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

    BaseEntity filteredEntity;
    String label;

    switch (listState.filterEntityType) {
      case EntityType.client:
        label = localization.filteredByClient;
        filteredEntity = filteredEntityId != null
            ? state.clientState.map[filteredEntityId]
            : null;
        break;
      case EntityType.invoice:
        label = localization.filteredByInvoice;
        filteredEntity = filteredEntityId != null
            ? state.invoiceState.map[filteredEntityId]
            : null;
        break;
    }

    return Column(
      children: <Widget>[
        filteredEntity != null
            ? Material(
                color: Colors.orangeAccent,
                elevation: 6.0,
                child: InkWell(
                  onTap: () => viewModel.onViewClientFilterPressed(context),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 18.0),
                      Expanded(
                        child: Text(
                          '$label: ${filteredEntity.listDisplayName}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () => viewModel.onClearEntityFilterPressed(),
                      )
                    ],
                  ),
                ),
              )
            : Container(),
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
                              onLongPress: () => showDialog(),
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }
}
