import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/payment/view/payment_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

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
      body: FormCard(children: [
        // STARTER: widgets - do not remove comment
        Text(payment.amount.toString(), style: Theme.of(context).textTheme.title),
        SizedBox(height: 12.0),

        Text(payment.transactionReference),
        Text(payment.privateNotes),
      ]),
    );
  }
}
