import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_item.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentList extends StatelessWidget {
  final PaymentListVM viewModel;

  const PaymentList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  void _showMenu(
      BuildContext context, PaymentEntity payment, ClientEntity client) async {
    final user = viewModel.user;
    final message = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(children: <Widget>[
          user.canEditEntity(payment) && client.hasEmailAddress
              ? ListTile(
            leading: Icon(Icons.send),
            title: Text(AppLocalization.of(context).email),
            onTap: () => viewModel.onEntityAction(
                context, payment, EntityAction.email),
          )
              : Container(),
          Divider(),
          user.canEditEntity(payment) && !payment.isActive
              ? ListTile(
            leading: Icon(Icons.restore),
            title: Text(AppLocalization.of(context).restore),
            onTap: () => viewModel.onEntityAction(
                context, payment, EntityAction.restore),
          )
              : Container(),
          user.canEditEntity(payment) && payment.isActive
              ? ListTile(
            leading: Icon(Icons.archive),
            title: Text(AppLocalization.of(context).archive),
            onTap: () => viewModel.onEntityAction(
                context, payment, EntityAction.archive),
          )
              : Container(),
          user.canEditEntity(payment) && !payment.isDeleted
              ? ListTile(
            leading: Icon(Icons.delete),
            title: Text(AppLocalization.of(context).delete),
            onTap: () => viewModel.onEntityAction(
                context, payment, EntityAction.delete),
          )
              : Container(),
        ]));
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
    final listState = viewModel.listState;
    final filteredClientId = listState.filterClientId;
    final filteredClient =
    filteredClientId != null ? viewModel.clientMap[filteredClientId] : null;

    return Column(
      children: <Widget>[
        filteredClient != null
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
                    localization.clientsPayments.replaceFirst(
                        ':client', filteredClient.displayName),
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
                  onPressed: () => viewModel.onClearClientFilterPressed(),
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
                final payment = viewModel.paymentMap[paymentId];
                final client =
                viewModel.clientMap[payment.clientId];
                return Column(
                  children: <Widget>[
                    PaymentListItem(
                      user: viewModel.user,
                      filter: viewModel.filter,
                      payment: payment,
                      onDismissed: (DismissDirection direction) =>
                          viewModel.onDismissed(
                              context, payment, direction),
                      onTap: () =>
                          viewModel.onPaymentTap(context, payment),
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
