import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/pdf.dart';

class InvoiceViewHistory extends StatefulWidget {
  const InvoiceViewHistory({Key key, @required this.viewModel})
      : super(key: key);

  final EntityViewVM viewModel;

  @override
  _InvoiceViewHistoryState createState() => _InvoiceViewHistoryState();
}

class _InvoiceViewHistoryState extends State<InvoiceViewHistory> {
  @override
  void didChangeDependencies() {
    if (widget.viewModel.invoice.isStale) {
      widget.viewModel.onRefreshed(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final invoice = widget.viewModel.invoice;

    // TODO remove this null check, it shouldn't be needed
    if (invoice.isStale || invoice.history == null) {
      return LoadingIndicator();
    }

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemBuilder: (BuildContext context, index) {
        final history = invoice.history[index];
        return ListTile(
          title: Text(''),
          trailing: Icon(Icons.chevron_right),
          onTap: () =>
              viewPdf(invoice, context, activityId: history.id),
          subtitle: Text(
            formatDate(
              convertTimestampToDateString(history.createdAt),
              context,
              showTime: true,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => ListDivider(),
      itemCount: invoice.history.length,
    );
  }
}
