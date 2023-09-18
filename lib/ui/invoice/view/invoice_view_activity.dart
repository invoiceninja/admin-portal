// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/lists/activity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';

class InvoiceViewActivity extends StatefulWidget {
  const InvoiceViewActivity({Key? key, this.viewModel}) : super(key: key);

  final AbstractInvoiceViewVM? viewModel;

  @override
  _InvoiceViewActivityState createState() => _InvoiceViewActivityState();
}

class _InvoiceViewActivityState extends State<InvoiceViewActivity> {
  @override
  void didChangeDependencies() {
    if (widget.viewModel!.invoice!.isStale) {
      widget.viewModel!.onRefreshed!(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final invoice = widget.viewModel!.invoice!;
    final activities = invoice.activities;

    if (!invoice.isLoaded) {
      return LoadingIndicator();
    }

    return ScrollableListViewBuilder(
      itemCount: activities.length,
      padding: const EdgeInsets.symmetric(vertical: 16),
      separatorBuilder: (context, index) => ListDivider(),
      itemBuilder: (BuildContext context, index) {
        final activity = activities[index];
        return ActivityListTile(
          activity: activity,
          enableNavigation: false,
        );
      },
    );
  }
}
