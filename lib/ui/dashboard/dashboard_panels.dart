import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/app_loading.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DashboardPanels extends StatelessWidget {
  final DashboardVM viewModel;

  const DashboardPanels({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  void _showDateOptions(BuildContext context) {
    print('show date options');
  }

  Widget _header(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text('Aug 15 - Sep 15',
                          style: Theme.of(context).textTheme.title),
                    ],
                  ),
                ),
                onTap: () {},
              ),
            ),
            IconButton(
                icon: Icon(Icons.navigate_before),
                onPressed: () {
                  print('prev');
                }),
            SizedBox(width: 8.0),
            IconButton(
                icon: Icon(Icons.navigate_next),
                onPressed: () {
                  print('next');
                }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _header(context),
      ],
    );
  }

/*
  @override
  Widget build(BuildContext context) {
    return AppLoading(builder: (context, loading) {
      return !viewModel.dashboardState.isLoaded
          ? LoadingIndicator()
          : _buildPanels(context);
    });
  }

  Widget _buildPanels(BuildContext context) {
    if (!viewModel.dashboardState.isLoaded) {
      return LoadingIndicator();
    }

    final localization = AppLocalization.of(context);

    return ListView(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
        children: <Widget>[
          DashboardRow(
              title: localization.totalRevenue,
              color: Color(0xFF117CC1),
              icon: Icons.show_chart,
              amount: viewModel.dashboardState.data.paidToDate),
          Row(
            children: <Widget>[
              DashboardColumn(
                  title: localization.invoicesSent,
                  color: Color(0xFFFCAB10),
                  icon: Icons.send,
                  isMoney: false,
                  amount:
                      viewModel.dashboardState.data.invoicesSent.toDouble()),
              DashboardColumn(
                  title: localization.activeClients,
                  color: Color(0xFFDBD5B5),
                  icon: Icons.people,
                  isMoney: false,
                  amount:
                      viewModel.dashboardState.data.activeClients.toDouble()),
            ],
          ),
          DashboardRow(
            amount: viewModel.dashboardState.data.averageInvoice,
            icon: Icons.email,
            color: Color(0xFF44AF69),
            title: localization.averageInvoice,
          ),
          DashboardRow(
            amount: viewModel.dashboardState.data.balances,
            icon: Icons.schedule,
            color: Color(0xFFF8333C),
            title: localization.outstanding,
          ),
        ]);
  }
  */
}

class ColorIcon extends StatelessWidget {
  const ColorIcon(this.icon, this.backgroundColor);

  final IconData icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52.0,
      height: 52.0,
      child: Icon(
        icon,
        color: Colors.white,
        size: 30.0,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
    );
  }
}

/*
class DashboardRow extends StatelessWidget {
  const DashboardRow(
      {@required this.title,
      @required this.icon,
      @required this.amount,
      @required this.color,
      this.isMoney = true});

  final String title;
  final IconData icon;
  final num amount;
  final Color color;
  final bool isMoney;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
      child: Card(
        elevation: 2.0,
        child: ListTile(
          title: Padding(
            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle()),
                Text(
                  formatNumber(amount, context,
                      formatNumberType: isMoney
                          ? FormatNumberType.money
                          : FormatNumberType.int),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          trailing: ColorIcon(icon, color),
        ),
      ),
    );
  }
}

class DashboardColumn extends StatelessWidget {
  const DashboardColumn(
      {@required this.title,
      @required this.icon,
      @required this.amount,
      @required this.color,
      this.isMoney = true});

  final String title;
  final IconData icon;
  final num amount;
  final Color color;
  final bool isMoney;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(child: ColorIcon(icon, color)),
                SizedBox(height: 18.0),
                Text(title, style: TextStyle()),
                Text(
                  formatNumber(isMoney ? round(amount, 2) : amount, context,
                      formatNumberType: isMoney
                          ? FormatNumberType.money
                          : FormatNumberType.int),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
