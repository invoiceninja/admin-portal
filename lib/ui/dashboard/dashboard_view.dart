import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
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
    final store = StoreProvider.of<AppState>(context);

    return Scaffold(
      drawer: AppDrawerBuilder(),
      appBar: AppBar(
        title: ListFilter(
          title: AppLocalization.of(context).dashboard,
          onFilterChanged: (value) {
            store.dispatch(FilterCompany(value));
          },
        ),
        actions: <Widget>[
          ListFilterButton(
            onFilterPressed: (String value) {
              store.dispatch(FilterCompany(value));
            },
          ),
        ],
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
