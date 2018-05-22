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
    return ListView(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
        children: <Widget>[
          DashboardPanel(
              'Total Revenue', Icons.credit_card, this.dashboard.paidToDate),
          DashboardPanel(
              'Average Invoice', Icons.email, this.dashboard.averageInvoice),
          DashboardPanel(
              'Outstanding', Icons.schedule, this.dashboard.balances),
          DashboardPanel(
              'Invoices Sent', Icons.send, this.dashboard.invoicesSent, false),
          DashboardPanel(
              'Active Clients', Icons.people, this.dashboard.activeClients, false),
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
            trailing: Text(this.amount.toStringAsFixed(this.isMoney ? 2 : 0)),
          ),
        ],
      ),
    );
  }
}
