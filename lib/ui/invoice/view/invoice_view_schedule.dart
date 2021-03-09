import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceViewSchedule extends StatelessWidget {
  const InvoiceViewSchedule({Key key, @required this.viewModel})
      : super(key: key);

  final EntityViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final invoice = viewModel.invoice;
    final localization = AppLocalization.of(context);

    return ScrollableListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(localization.sendDate),
            ),
            Expanded(
              child: Text(localization.dueDate),
            ),
          ],
        ),
        ...invoice.recurringDates
            .map((schedule) => Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(formatDate(schedule.sendDate, context)),
                      ),
                      Expanded(
                        child: Text(formatDate(schedule.dueDate, context)),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ],
    );
  }
}
