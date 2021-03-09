import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:timeago/timeago.dart' as timeago;

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
    final viewModel = widget.viewModel;
    final invoice = viewModel.invoice;

    // TODO remove this null check, it shouldn't be needed
    if (invoice.isStale || invoice.history == null) {
      return LoadingIndicator();
    }

    final historyList = invoice.history.toList();
    historyList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return ScrollableListViewBuilder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemBuilder: (BuildContext context, index) {
        final history = historyList[index];
        final user = viewModel.state.userState.get(history.activity.userId);

        return ListTile(
          title: Text(
            formatNumber(history.amount, context, clientId: invoice.clientId) +
                ' • ' +
                user.fullName,
          ),
          subtitle: Text(formatDate(
                convertTimestampToDateString(history.createdAt),
                context,
                showTime: true,
              ) +
              ' • ' +
              timeago.format(convertTimestampToDate(history.createdAt))),
          trailing: Icon(Icons.chevron_right),
          onTap: () =>
              viewModel.onViewPdf(context, invoice, history.activityId),
        );
      },
      separatorBuilder: (context, index) => ListDivider(),
      itemCount: invoice.history.length,
    );
  }
}
