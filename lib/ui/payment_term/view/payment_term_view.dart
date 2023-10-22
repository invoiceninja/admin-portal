// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/payment_term/view/payment_term_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentTermView extends StatefulWidget {
  const PaymentTermView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final PaymentTermViewVM viewModel;

  @override
  _PaymentTermViewState createState() => new _PaymentTermViewState();
}

class _PaymentTermViewState extends State<PaymentTermView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final paymentTerm = viewModel.paymentTerm;
    final localization = AppLocalization.of(context)!;

    return ViewScaffold(
      entity: paymentTerm,
      onBackPressed: () => viewModel.onBackPressed(),
      body: ScrollableListView(
        children: [
          EntityHeader(
            entity: paymentTerm,
            label: localization.name,
            value: paymentTerm.name,
          ),
        ],
      ),
    );
  }
}
