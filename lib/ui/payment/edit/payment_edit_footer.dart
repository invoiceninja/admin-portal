// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentEditFooter extends StatelessWidget {
  const PaymentEditFooter({required this.payment});

  final PaymentEntity payment;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    final invoicePaymentables = payment.invoices.toList();
    final creditPaymentables = payment.credits.toList();

    String amountLabel = payment.isOld ? payment.number + ' • ' : '';
    double paymentTotal = 0;
    double creditTotal = 0;

    invoicePaymentables.forEach((invoice) {
      paymentTotal += invoice.amount;
    });
    creditPaymentables.forEach((credit) {
      creditTotal += credit.amount;
    });

    amountLabel += localization.total +
        ' ' +
        formatNumber(paymentTotal, context, clientId: payment.clientId)!;

    if (payment.credits.isNotEmpty) {
      amountLabel += ' • ' +
          localization.credit +
          ' ' +
          formatNumber(creditTotal, context, clientId: payment.clientId)!;
    }

    return BottomAppBar(
      elevation: 0,
      color: Theme.of(context).cardColor,
      shape: CircularNotchedRectangle(),
      child: SizedBox(
        height: kTopBottomBarHeight,
        child: AppBorder(
          isTop: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: Text(
              amountLabel,
              style: TextStyle(
                color: state.prefState.enableDarkMode
                    ? Colors.white
                    : Colors.black,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
