import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/app_loading.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/loading_indicator.dart';
import 'package:invoiceninja/keys.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_state.dart';

class DashboardPanels extends StatelessWidget {
  final DashboardState dashboardState;

  DashboardPanels({
    Key key,
    @required this.dashboardState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLoading(builder: (context, loading) {
      return loading && dashboardState.lastUpdated == 0
          ? LoadingIndicator()
          : _buildPanels();
    });
  }

  ListView _buildPanels() {
    return ListView(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
        children: <Widget>[
          DashboardPanel(
              'Total Revenue', Icons.credit_card, this.dashboardState.data.paidToDate),
          DashboardPanel(
              'Average Invoice', Icons.email, this.dashboardState.data.averageInvoice),
          DashboardPanel(
              'Outstanding', Icons.schedule, this.dashboardState.data.balances),
          DashboardPanel(
              'Invoices Sent', Icons.send, this.dashboardState.data.invoicesSent, false),
          DashboardPanel(
              'Active Clients', Icons.people, this.dashboardState.data.activeClients, false),
        ]
    );
  }
}

class DashboardPanel extends StatelessWidget {
  DashboardPanel(this.title, this.icon, this.amount, [this.isMoney = true]);

  final String title;
  final IconData icon;
  final num amount;
  final bool isMoney;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(this.icon),
            title: Text(this.title),
            trailing: Text(this.isMoney ?
              "\$" + this.amount.toStringAsFixed(2) :
              this.amount.toString()),
          ),
        ],
      ),
    );
  }
}
