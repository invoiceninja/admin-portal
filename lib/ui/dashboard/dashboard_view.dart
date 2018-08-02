import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_activity.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_panels.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DashboardView extends StatefulWidget {
  final DashboardVM viewModel;

  const DashboardView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _DashboardViewState createState() => new _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Scaffold(
      drawer: AppDrawerBuilder(),
      appBar: AppBar(
        title: Text(AppLocalization.of(context).dashboard),
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(
              text: localization.overview,
            ),
            Tab(
              text: localization.activity,
            ),
          ],
        ),
      ),
      body: CustomTabBarView(
        viewModel: widget.viewModel,
        controller: _controller,
      ),
    );
  }
}


class CustomTabBarView extends StatelessWidget {
  const CustomTabBarView({
    @required this.viewModel,
    @required this.controller,
  });

  final DashboardVM viewModel;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: <Widget>[
        RefreshIndicator(
          onRefresh: () => viewModel.onRefreshed(context),
          //child: DashboardOverview(viewModel: viewModel),
          child: DashboardPanels(
            viewModel: viewModel,
          ),
        ),
        RefreshIndicator(
          onRefresh: () => viewModel.onRefreshed(context),
          child: DashboardActivity(viewModel: viewModel),
        ),
      ],
    );
  }
}
