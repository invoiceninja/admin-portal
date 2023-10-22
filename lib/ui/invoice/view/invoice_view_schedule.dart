// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceViewSchedule extends StatefulWidget {
  const InvoiceViewSchedule({Key? key, required this.viewModel})
      : super(key: key);

  final AbstractInvoiceViewVM viewModel;

  @override
  _InvoiceViewScheduleState createState() => _InvoiceViewScheduleState();
}

class _InvoiceViewScheduleState extends State<InvoiceViewSchedule> {
  @override
  void didChangeDependencies() {
    if (widget.viewModel.invoice!.isStale) {
      widget.viewModel.onRefreshed!(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final invoice = widget.viewModel.invoice!;
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
            Expanded(
              child: Text(
                localization.dueDate,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        if (invoice.isStale && invoice.recurringDates!.isEmpty)
          LoadingIndicator(
            height: 300,
          ),
        ...invoice.recurringDates!
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
