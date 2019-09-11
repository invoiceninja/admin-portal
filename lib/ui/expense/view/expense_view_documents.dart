import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';

class ExpenseViewDocuments extends StatelessWidget {
  const ExpenseViewDocuments(
      {@required this.expense, @required this.viewModel});

  final ExpenseViewVM viewModel;
  final ExpenseEntity expense;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final documentState = state.documentState;
    final documents =
        memoizedExpenseDocumentsSelector(documentState.map, expense);

    return DocumentGrid(
      documentIds: documents,
      onUploadDocument: (path) => viewModel.onUploadDocument(context, path),
      onDeleteDocument: (document) =>
          viewModel.onDeleteDocument(context, document),
      onViewExpense: null,
    );
  }
}
