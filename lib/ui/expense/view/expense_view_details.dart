import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ExpenseViewDetails extends StatefulWidget {
  const ExpenseViewDetails({this.expense});

  final ExpenseEntity expense;

  @override
  _ExpenseViewDetailsState createState() => _ExpenseViewDetailsState();
}

class _ExpenseViewDetailsState extends State<ExpenseViewDetails> {
  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final localization = AppLocalization.of(context);
    final expense = widget.expense;

    List<Widget> _buildDetailsList() {
      String tax = '';
      if (expense.taxName1.isNotEmpty) {
        tax += formatNumber(expense.taxRate1, context,
                formatNumberType: FormatNumberType.percent) +
            ' ' +
            expense.taxName1;
      }
      if (expense.taxName2.isNotEmpty) {
        tax += ' ' +
            formatNumber(expense.taxRate2, context,
                formatNumberType: FormatNumberType.percent) +
            ' ' +
            expense.taxName2;
      }

      final fields = <String, String>{
        localization.amount: formatNumber(expense.amount, context,
            currencyId: expense.expenseCurrencyId),
        localization.tax: tax,
        localization.paymentType:
            state.staticState.paymentTypeMap[expense.paymentTypeId]?.name,
        localization.paymentDate: formatDate(expense.paymentDate, context),
        localization.transactionReference: expense.transactionReference,
        localization.exchangeRate: expense.isConverted
            ? formatNumber(expense.exchangeRate, context,
                formatNumberType: FormatNumberType.double)
            : null,
        localization.currency: expense.isConverted
            ? state.staticState.currencyMap[expense.invoiceCurrencyId]?.name
            : null,
      };

      final listTiles = <Widget>[
        FieldGrid(fields),
        Divider(
          height: 1.0,
        ),
        if (expense.publicNotes != null && expense.publicNotes.isNotEmpty)
          IconMessage(expense.publicNotes),
      ];

      return listTiles;
    }

    return ListView(
      children: _buildDetailsList(),
    );
  }
}
