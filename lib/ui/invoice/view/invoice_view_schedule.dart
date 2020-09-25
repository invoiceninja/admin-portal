import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class InvoiceViewSchedule extends StatelessWidget {
  const InvoiceViewSchedule({Key key, @required this.viewModel})
      : super(key: key);

  final EntityViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final invoice = viewModel.invoice;
    print('## recurring dates: ${invoice.recurringDates}');
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      children: invoice.recurringDates
          .map((schedule) => Row(
                children: [
                  Expanded(
                    child: Text(formatDate(schedule.sendDate, context)),
                  ),
                  Expanded(
                    child: Text(formatDate(schedule.dueDate, context)),
                  ),
                ],
              ))
          .toList(),
    );
  }
}
