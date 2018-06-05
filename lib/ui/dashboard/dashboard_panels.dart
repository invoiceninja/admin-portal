import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/app_loading.dart';
import 'package:invoiceninja/ui/app/loading_indicator.dart';
import 'package:invoiceninja/ui/dashboard/dashboard_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

class DashboardPanels extends StatelessWidget {
  final DashboardVM viewModel;

  DashboardPanels({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLoading(builder: (context, loading) {
      return loading && viewModel.dashboardState.lastUpdated == 0
          ? LoadingIndicator()
          : _buildPanels(context);
    });
  }

  Widget _buildPanels(BuildContext context) {
    if (viewModel.dashboardState.data == null) {
      return ListView();
    }

    var localization = AppLocalization.of(context);

    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ListView(
          padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
          children: <Widget>[
            DashboardRow(localization.totalRevenue, Icons.show_chart,
                viewModel.dashboardState.data.paidToDate, Color(0xFF117CC1)),
            Row(
              children: <Widget>[
                DashboardColumn(localization.averageInvoice, Icons.email,
                    viewModel.dashboardState.data.averageInvoice, Color(0xFF44AF69)),
                DashboardColumn(
                    localization.outstanding, Icons.schedule, viewModel.dashboardState.data.balances, Color(0xFFF8333C)),
              ],
            ),
            DashboardRow(localization.invoicesSent, Icons.send,
                viewModel.dashboardState.data.invoicesSent, Color(0xFFFCAB10), false),
            DashboardRow(localization.activeClients, Icons.people,
                viewModel.dashboardState.data.activeClients, Color(0xFFDBD5B5), false),
          ]),
    );
  }
}

class ColorIcon extends StatelessWidget {
  ColorIcon(this.icon, this.backgroundColor);
  final IconData icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52.0,
      height: 52.0,
      child: Icon(this.icon, color: Colors.white, size: 30.0,),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: this.backgroundColor,
        //backgroundImage: new BackgroundImage(
        //image: new AssetImage('assets/cat.jpg'),
      ),
    );
  }
}

class DashboardRow extends StatelessWidget {
  DashboardRow(this.title, this.icon, this.amount, this.color, [this.isMoney = true]);

  final String title;
  final IconData icon;
  final num amount;
  final Color color;
  final bool isMoney;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3.0, bottom: 3.0 ),
      child: Card(
        elevation: 2.0,
        child: ListTile(
          title: Padding(
            padding: EdgeInsets.only(top: 12.0, bottom: 12.0 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(this.title,
                  style: TextStyle(color: Colors.grey[700])),
                Text(this.isMoney
                    ? "\$" + this.amount.toStringAsFixed(2)
                    : this.amount.toString(),
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),)
              ],
            ),
          ),
          trailing: ColorIcon(this.icon, this.color),
        ),
      ),
    );
  }
}


class DashboardColumn extends StatelessWidget {
  DashboardColumn(this.title, this.icon, this.amount, this.color, [this.isMoney = true]);

  final String title;
  final IconData icon;
  final num amount;
  final Color color;
  final bool isMoney;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: 3.0, bottom: 3.0 ),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(child: ColorIcon(this.icon, this.color)),
                SizedBox(height: 18.0),
                Text(this.title,
                    style: TextStyle(color: Colors.grey[700])),
                Text(this.isMoney
                    ? "\$" + this.amount.toStringAsFixed(2)
                    : this.amount.toString(),
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

