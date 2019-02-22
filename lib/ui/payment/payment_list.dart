import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_item.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentList extends StatelessWidget {
  const PaymentList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final PaymentListVM viewModel;

  void _showMenu(
      BuildContext context, PaymentEntity payment, ClientEntity client) async {
    if (payment == null || client == null) {
      return;
    }

    final user = viewModel.user;
    final message = await showDialog<String>(
        context: context,
        builder: (BuildContext dialogContext) => SimpleDialog(
                children: payment
                    .getEntityActions(
                        user: user, client: client, includeEdit: true)
                    .map((entityAction) {
              if (entityAction == null) {
                return Divider();
              } else {
                return ListTile(
                  leading: Icon(getEntityActionIcon(entityAction)),
                  title: Text(AppLocalization.of(context)
                      .lookup(entityAction.toString())),
                  onTap: () {
                    Navigator.of(dialogContext).pop();
                    viewModel.onEntityAction(context, payment, entityAction);
                  },
                );
              }
            }).toList()));

    if (message != null) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: SnackBarRow(
        message: message,
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final listState = viewModel.listState;
    final filteredEntityId = listState.filterEntityId;

    BaseEntity filteredEntity;
    switch (listState.filterEntityType) {
      case EntityType.client:
        filteredEntity = filteredEntityId != null
            ? state.clientState.map[filteredEntityId]
            : null;
        break;
      case EntityType.invoice:
      case EntityType.quote:
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
                          '${localization.filteredBy} ${filteredEntity.listDisplayName}',
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
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.paymentList.isEmpty
                      ? Opacity(
                          opacity: 0.5,
                          child: Center(
                            child: Text(
                              AppLocalization.of(context).noRecordsFound,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: viewModel.paymentList.length,
                          itemBuilder: (BuildContext context, index) {
                            final paymentId = viewModel.paymentList[index];
                            final payment = state.paymentState.map[paymentId];
                            final client =
                                paymentClientSelector(paymentId, state);
                            return Column(
                              children: <Widget>[
                                PaymentListItem(
                                  user: viewModel.user,
                                  filter: viewModel.filter,
                                  payment: payment,
                                  onTap: () =>
                                      viewModel.onPaymentTap(context, payment),
                                  onEntityAction: (EntityAction action) {
                                    if (action == EntityAction.more) {
                                      _showMenu(context, payment, client);
                                    } else {
                                      viewModel.onEntityAction(
                                          context, payment, action);
                                    }
                                  },
                                  onLongPress: () =>
                                      _showMenu(context, payment, client),
                                ),
                                Divider(
                                  height: 1.0,
                                ),
                              ],
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }
}
