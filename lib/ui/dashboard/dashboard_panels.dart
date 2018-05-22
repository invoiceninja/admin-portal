import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/app_loading.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/loading_indicator.dart';
import 'package:invoiceninja/keys.dart';

class DashboardPanels extends StatelessWidget {
  final DashboardEntity dashboard;

  DashboardPanels({
    Key key,
    @required this.dashboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('building...');
    return AppLoading(builder: (context, loading) {
      return loading
          ? LoadingIndicator(key: NinjaKeys.productsLoading)
          : _buildPanels();
    });
  }

  Text _buildPanels() {
    return Text('Paid to Date: ' + dashboard.paidToDate.toString());
  }
}
