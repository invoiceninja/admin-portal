import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
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
    final localization = AppLocalization.of(context);

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
                        clientId:
                            paymentClientSelector(payment.id, context).id),
                    label2: localization.refunded,
                    value2: formatNumber(payment.refunded, context,
                        clientId:
                            paymentClientSelector(payment.id, context).id),
                  )
                : OneValueHeader(
                    label: localization.amount,
                    value: formatNumber(payment.amount, context,
                        clientId:
                            paymentClientSelector(payment.id, context).id),
                  ),
            payment.privateNotes != null && payment.privateNotes.isNotEmpty
                ? IconMessage(payment.privateNotes)
                : Container(),
          ],
        ));
  }
}
