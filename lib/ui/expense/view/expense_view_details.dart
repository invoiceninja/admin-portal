import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
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
      final documentState = state.documentState;
      final documents = memoizedDocumentsSelector(
              documentState.map, documentState.list, expense)
          .map(
        (documentId) {
          final document =
              documentState.map[documentId] ?? DocumentEntity(id: documentId);

          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, top: 16, right: 16, bottom: 28),
                      child: Text(document.name ?? '',
                          style: Theme.of(context).textTheme.subhead),
                    ),
                    document.preview != null && document.preview.isNotEmpty
                        ? CachedNetworkImage(
                            key: ValueKey(document.preview),
                            imageUrl: document.previewUrl(state.authState.url),
                            httpHeaders: {
                              'X-Ninja-Token': state.selectedCompany.token
                            },
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Text(
                                  '$error: $url',
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                ))
                        : Icon(Icons.insert_drive_file)
                  ],
                ),
              )
            ],
          );
        },
      ).toList();

      final listTiles = <Widget>[
        Container(
          color: Theme.of(context).backgroundColor,
          height: 12.0,
        ),
        FieldGrid(fields),
        Divider(
          height: 1.0,
        ),
        if (expense.publicNotes != null && expense.publicNotes.isNotEmpty)
          IconMessage(expense.publicNotes),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          crossAxisCount: 2,
          children: documents,
          //childAspectRatio: 3.5,
        ),
      ];

      return listTiles;
    }

    return ListView(
      children: _buildDetailsList(),
    );
  }
}
