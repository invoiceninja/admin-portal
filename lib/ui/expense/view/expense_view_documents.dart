// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';

class ExpenseViewDocuments extends StatelessWidget {
  const ExpenseViewDocuments(
      {Key? key, required this.expense, required this.viewModel})
      : super(key: key);

  final AbstractExpenseViewVM viewModel;
  final ExpenseEntity? expense;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return DocumentGrid(
      documents: expense!.documents.toList(),
      onUploadDocument: (path, isPrivate) =>
          viewModel.onUploadDocuments!(context, path, isPrivate),
      onRenamedDocument: () =>
          store.dispatch(LoadExpense(expenseId: expense!.id)),
      onViewExpense: null,
    );
  }
}
