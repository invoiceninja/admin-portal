// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';

class PaymentViewDocuments extends StatelessWidget {
  const PaymentViewDocuments({Key? key, required this.viewModel})
      : super(key: key);

  final PaymentViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final payment = viewModel.payment;

    return DocumentGrid(
      documents: payment.documents.toList(),
      onUploadDocument: (path, isPrivate) =>
          viewModel.onUploadDocuments(context, path, isPrivate),
      onRenamedDocument: () =>
          store.dispatch(LoadPayment(paymentId: payment.id)),
    );
  }
}
