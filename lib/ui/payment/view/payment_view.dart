import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/one_value_header.dart';
import 'package:invoiceninja_flutter/ui/app/two_value_header.dart';
import 'package:invoiceninja_flutter/ui/payment/view/payment_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentView extends StatefulWidget {
  final PaymentViewVM viewModel;

  const PaymentView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _PaymentViewState createState() => new _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final payment = viewModel.payment;
    final state = StoreProvider.of<AppState>(context).state;
    final client = paymentClientSelector(payment.id, state);
    final invoice = paymentInvoiceSelector(payment.id, state);
    final localization = AppLocalization.of(context);

    final fields = <String, String>{};
    fields[PaymentFields.paymentStatusId] =
        localization.lookup('payment_status_${payment.paymentStatusId}');
    if (payment.paymentDate.isNotEmpty) {
      fields[PaymentFields.paymentDate] =
          formatDate(payment.paymentDate, context);
    }
    if (payment.paymentTypeId > 0) {
      fields[PaymentFields.paymentTypeId] =
          state.staticState.paymentTypeMap[payment.paymentTypeId].name;
    }
    if (payment.transactionReference.isNotEmpty) {
      fields[PaymentFields.transactionReference] = payment.transactionReference;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(payment.transactionReference),
          actions: payment.isNew
              ? []
              : [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      viewModel.onEditPressed(context);
                    },
                  ),
                  ActionMenuButton(
                    user: viewModel.company.user,
                    isSaving: viewModel.isSaving,
                    entity: payment,
                    onSelected: viewModel.onActionSelected,
                  )
                ],
        ),
        body: ListView(
          children: <Widget>[
            payment.refunded > 0
                ? TwoValueHeader(
                    label1: localization.amount,
                    value1: formatNumber(payment.amount, context,
                        clientId: client.id),
                    label2: localization.refunded,
                    value2: formatNumber(payment.refunded, context,
                        clientId: client.id),
                  )
                : OneValueHeader(
                    label: localization.amount,
                    value: formatNumber(payment.amount, context,
                        clientId: client.id),
                  ),
            Material(
              color: Theme.of(context).canvasColor,
              child: ListTile(
                title: Text(client.displayName ?? ''),
                leading: Icon(FontAwesomeIcons.users, size: 18.0),
                trailing: Icon(Icons.navigate_next),
                onTap: () => viewModel.onTapClient(context),
              ),
            ),
            Container(
              color: Theme.of(context).backgroundColor,
              height: 12.0,
            ),
            Material(
              color: Theme.of(context).canvasColor,
              child: ListTile(
                title: Text('${localization.invoice} ${invoice.invoiceNumber}'),
                leading: Icon(FontAwesomeIcons.filePdfO, size: 18.0),
                trailing: Icon(Icons.navigate_next),
                onTap: () => viewModel.onTapInvoice(context),
              ),
            ),
            Container(
              color: Theme.of(context).backgroundColor,
              height: 12.0,
            ),
            payment.privateNotes != null && payment.privateNotes.isNotEmpty
                ? IconMessage(payment.privateNotes)
                : Container(),
            Container(
              color: Theme.of(context).backgroundColor,
              height: 12.0,
            ),
            FieldGrid(fields),
          ],
        ));
  }
}
