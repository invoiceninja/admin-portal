// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_details.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_notes.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_settings.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';

class ExpenseEditDesktop extends StatelessWidget {
  const ExpenseEditDesktop({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final AbstractExpenseEditVM viewModel;

  @override
  Widget build(BuildContext context) {
    return ScrollableListView(
      primary: true,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FocusTraversalGroup(
                child: Column(
                  children: [
                    ExpenseEditDetails(
                      viewModel: viewModel,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FocusTraversalGroup(
                child: Column(
                  children: [
                    ExpenseEditNotes(
                      viewModel: viewModel,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FocusTraversalGroup(
                child: Column(
                  children: [
                    ExpenseEditSettings(
                      viewModel: viewModel,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
