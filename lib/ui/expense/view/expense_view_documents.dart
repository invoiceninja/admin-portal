import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/document_tile.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ExpenseViewDocuments extends StatefulWidget {
  const ExpenseViewDocuments({this.expense});

  final ExpenseEntity expense;

  @override
  _ExpenseViewDocumentsState createState() => _ExpenseViewDocumentsState();
}

class _ExpenseViewDocumentsState extends State<ExpenseViewDocuments> {
  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final localization = AppLocalization.of(context);
    final expense = widget.expense;

    final documentState = state.documentState;
    final documents = memoizedDocumentsSelector(
            documentState.map, documentState.list, expense)
        .map(
      (documentId) {
        final document =
            documentState.map[documentId] ?? DocumentEntity(id: documentId);

        return DocumentTile(document);
      },
    ).toList();

    return ListView(
      children: [
        Container(
          color: Theme.of(context).backgroundColor,
          height: 12.0,
        ),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          crossAxisCount: 2,
          children: documents,
          //childAspectRatio: 3.5,
        ),
      ],
    );
  }
}
