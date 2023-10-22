// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ExpenseViewSchedule extends StatefulWidget {
  const ExpenseViewSchedule({Key? key, required this.viewModel})
      : super(key: key);

  final AbstractExpenseViewVM viewModel;

  @override
  _ExpenseViewScheduleState createState() => _ExpenseViewScheduleState();
}

class _ExpenseViewScheduleState extends State<ExpenseViewSchedule> {
  @override
  void didChangeDependencies() {
    if (widget.viewModel.expense.isStale) {
      widget.viewModel.onRefreshed!(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final expense = widget.viewModel.expense;
    final localization = AppLocalization.of(context)!;

    return ScrollableListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                localization.sendDate,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        if (expense.isStale && expense.recurringDates!.isEmpty)
          LoadingIndicator(
            height: 300,
          ),
        ...expense.recurringDates!
            .map((schedule) => Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(formatDate(schedule.sendDate, context)),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ],
    );
  }
}
