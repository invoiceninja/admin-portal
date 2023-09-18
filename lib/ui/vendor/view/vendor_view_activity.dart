// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/lists/activity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_vm.dart';

class VendorViewActivity extends StatefulWidget {
  const VendorViewActivity({Key? key, this.viewModel}) : super(key: key);

  final VendorViewVM? viewModel;

  @override
  _VendorViewActivityState createState() => _VendorViewActivityState();
}

class _VendorViewActivityState extends State<VendorViewActivity> {
  @override
  void didChangeDependencies() {
    if (widget.viewModel!.vendor.isStale) {
      widget.viewModel!.onRefreshed(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final vendor = widget.viewModel!.vendor;
    final activities = vendor.activities;

    if (!vendor.isLoaded) {
      return LoadingIndicator();
    }

    return ScrollableListViewBuilder(
      itemCount: activities.length,
      padding: const EdgeInsets.symmetric(vertical: 16),
      separatorBuilder: (context, index) => ListDivider(),
      itemBuilder: (BuildContext context, index) {
        final activity = activities[index];
        return ActivityListTile(activity: activity);
      },
    );
  }
}
