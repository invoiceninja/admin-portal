import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    if (!viewModel.isLoaded) {
      return LoadingIndicator();
    } else if (viewModel.paymentList.isEmpty) {
      return Opacity(
        opacity: 0.5,
        child: Center(
          child: Text(
            AppLocalization.of(context).noRecordsFound,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }

    return _buildListView(context);
  }

  void _showMenu(BuildContext context, PaymentEntity payment) async {
    final user = viewModel.user;
    final message = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(children: <Widget>[
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

  Widget _buildListView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ListView.builder(
          itemCount: viewModel.paymentList.length,
          itemBuilder: (BuildContext context, index) {
            final paymentId = viewModel.paymentList[index];
            final payment = viewModel.paymentMap[paymentId];
            return Column(children: <Widget>[
              PaymentListItem(
                user: viewModel.user,
                filter: viewModel.filter,
                payment: payment,
                onDismissed: (DismissDirection direction) =>
                    viewModel.onDismissed(context, payment, direction),
                onTap: () => viewModel.onPaymentTap(context, payment),
                onLongPress: () => _showMenu(context, payment),
              ),
              Divider(
                height: 1.0,
              ),
            ]);
          }),
    );
  }
}
