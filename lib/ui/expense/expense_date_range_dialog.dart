// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

void showExpenseDateRangeDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) => ExpenseDateRangeDialog(),
  );
}

class ExpenseDateRangeDialog extends StatelessWidget {
  const ExpenseDateRangeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;

    return StoreConnector<AppState, ListUIState>(
      converter: (store) => store.state.expenseListState,
      builder: (context, listState) {
        final store = StoreProvider.of<AppState>(context);

        return AlertDialog(
          title: Text(localization.dateRange),
          content: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DatePicker(
                  labelText: localization.startDate,
                  selectedDate: listState.filterStartDate,
                  allowClearing: true,
                  autofocus: true,
                  onSelected: (date, _) => store.dispatch(
                    FilterExpensesByDateRange(
                      startDate: date,
                      endDate: listState.filterEndDate,
                    ),
                  ),
                ),
                DatePicker(
                  labelText: localization.endDate,
                  selectedDate: listState.filterEndDate,
                  allowClearing: true,
                  onSelected: (date, _) => store.dispatch(
                    FilterExpensesByDateRange(
                      startDate: listState.filterStartDate,
                      endDate: date,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            if (listState.hasDateRangeFilter)
              TextButton(
                onPressed: () {
                  store.dispatch(FilterExpensesByDateRange());
                  Navigator.of(context).pop();
                },
                child: Text(localization.reset.toUpperCase()),
              ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(localization.close.toUpperCase()),
            ),
          ],
        );
      },
    );
  }
}
