import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';

class ExpenseViewDocuments extends StatelessWidget {
  const ExpenseViewDocuments(
      {@required this.expense, @required this.viewModel});

  final ExpenseViewVM viewModel;
  final ExpenseEntity expense;

  @override
  Widget build(BuildContext context) {
    return DocumentGrid(
      documents: expense.documents.toList(),
      onUploadDocument: (path) => viewModel.onUploadDocument(context, path),
      onDeleteDocument: (document, password, idToken) =>
          viewModel.onDeleteDocument(context, document, password, idToken),
      onViewExpense: null,
    );
  }
}
