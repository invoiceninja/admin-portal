import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/payment_term/view/payment_term_view_vm.dart';

class PaymentTermView extends StatefulWidget {
  const PaymentTermView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final PaymentTermViewVM viewModel;

  @override
  _PaymentTermViewState createState() => new _PaymentTermViewState();
}

class _PaymentTermViewState extends State<PaymentTermView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final userCompany = viewModel.state.userCompany;
    final paymentTerm = viewModel.paymentTerm;

    return ViewScaffold(
      entity: paymentTerm,
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}
