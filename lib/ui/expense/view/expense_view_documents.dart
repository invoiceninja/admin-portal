import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';

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
    final expense = widget.expense;
    final documentState = state.documentState;
    final documents = memoizedDocumentsSelector(
            documentState.map, documentState.list, expense)
        .toList();

    return DocumentGrid(documents);
  }
}
