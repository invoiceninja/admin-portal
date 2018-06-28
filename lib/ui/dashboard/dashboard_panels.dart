import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/utils/formatting.dart';
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
      return !viewModel.dashboardState.isLoaded
          ? LoadingIndicator()
          : _buildPanels(context);
    });
  }

  Widget _buildPanels(BuildContext context) {
    if (!viewModel.dashboardState.isLoaded) {
      return LoadingIndicator();
    }

    var localization = AppLocalization.of(context);

    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ListView(
          padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
          children: <Widget>[
            DashboardRow(
                state: viewModel.state,
                title: localization.totalRevenue,
                color: Color(0xFF117CC1),
                icon: Icons.show_chart,
                amount: viewModel.dashboardState.data.paidToDate),
            Row(
              children: <Widget>[
                DashboardColumn(
                  amount: viewModel.dashboardState.data.averageInvoice,
                  icon: Icons.email,
                  color: Color(0xFF44AF69),
                  title: localization.averageInvoice,
                  state: viewModel.state,
                ),
                DashboardColumn(
                  amount: viewModel.dashboardState.data.balances,
                  icon: Icons.schedule,
                  color: Color(0xFFF8333C),
                  title: localization.outstanding,
                  state: viewModel.state,
                ),
              ],
            ),
            DashboardRow(
                state: viewModel.state,
                title: localization.invoicesSent,
                color: Color(0xFFFCAB10),
                icon: Icons.send,
                isMoney: false,
                amount: viewModel.dashboardState.data.invoicesSent.toDouble()),
            DashboardRow(
                state: viewModel.state,
                title: localization.activeClients,
                color: Color(0xFFDBD5B5),
                icon: Icons.people,
                isMoney: false,
                amount: viewModel.dashboardState.data.activeClients.toDouble()),
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
      child: Icon(
        this.icon,
        color: Colors.white,
        size: 30.0,
      ),
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
  DashboardRow(
      {@required this.state,
      @required this.title,
      @required this.icon,
      @required this.amount,
      @required this.color,
      this.isMoney = true});

  final AppState state;
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
                Text(this.title, style: TextStyle()),
                Text(
                  formatNumber(amount, state,
                      formatType: isMoney
                          ? NumberFormatTypes.money
                          : NumberFormatTypes.int),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
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
  DashboardColumn(
      {@required this.state,
      @required this.title,
      @required this.icon,
      @required this.amount,
      @required this.color,
      this.isMoney = true});

  final AppState state;
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
                Center(child: ColorIcon(this.icon, this.color)),
                SizedBox(height: 18.0),
                Text(this.title, style: TextStyle()),
                Text(
                  formatNumber(amount, state,
                      formatType: isMoney
                          ? NumberFormatTypes.money
                          : NumberFormatTypes.int),
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
