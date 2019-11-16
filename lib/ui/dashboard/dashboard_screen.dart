import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_activity.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_panels.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DashboardVM viewModel;

  @override
  _DashboardScreenState createState() => new _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
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
    final state = store.state;

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        drawer: isMobile(context) || state.uiState.isMenuFloated
            ? MenuDrawerBuilder()
            : null,
        endDrawer: isMobile(context) || state.uiState.isHistoryFloated
            ? HistoryDrawerBuilder()
            : null,
        appBar: AppBar(
          leading: isMobile(context) || state.uiState.isMenuFloated
              ? null
              : IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () =>
                      store.dispatch(UserSettingsChanged(sidebar: AppSidebar.menu)),
                ),
          title: ListFilter(
            title: AppLocalization.of(context).dashboard,
            key: ValueKey(state.uiState.filterClearedAt),
            filter: state.uiState.filter,
            onFilterChanged: (value) {
              store.dispatch(FilterCompany(value));
            },
          ),
          actions: [
            ListFilterButton(
              filter: state.uiState.filter,
              onFilterPressed: (String value) {
                store.dispatch(FilterCompany(value));
              },
            ),
            if (!state.uiState.isHistoryVisible)
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    if (isMobile(context) || state.uiState.isHistoryFloated) {
                      Scaffold.of(context).openEndDrawer();
                    } else {
                      store.dispatch(UserSettingsChanged(sidebar: AppSidebar.history));
                    }
                  },
                ),
              ),
          ],
          bottom: store.state.uiState.filter != null
              ? null
              : TabBar(
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
    if (viewModel.filter != null) {
      return ListView.builder(
          itemCount: viewModel.filteredList.length,
          itemBuilder: (BuildContext context, index) {
            final entity = viewModel.filteredList[index];
            final subtitle = entity.matchesFilterValue(viewModel.filter);
            return ListTile(
              title: Text(entity.listDisplayName),
              leading: Icon(getEntityIcon(entity.entityType)),
              trailing: Icon(Icons.navigate_next),
              subtitle: subtitle != null ? Text(subtitle) : Container(),
              onTap: () {
                dynamic action;
                switch (entity.entityType) {
                  case EntityType.product:
                    action = EditProduct(product: entity, context: context);
                    break;
                  case EntityType.project:
                    action =
                        ViewProject(projectId: entity.id, context: context);
                    break;
                  case EntityType.task:
                    action = ViewTask(taskId: entity.id, context: context);
                    break;
                  case EntityType.payment:
                    action =
                        ViewPayment(paymentId: entity.id, context: context);
                    break;
                  case EntityType.quote:
                    action = ViewQuote(quoteId: entity.id, context: context);
                    break;
                  case EntityType.client:
                    action = ViewClient(clientId: entity.id, context: context);
                    break;
                  case EntityType.invoice:
                    action =
                        ViewInvoice(invoiceId: entity.id, context: context);
                    break;
                }
                StoreProvider.of<AppState>(context).dispatch(action);
              },
            );
          });
    }

    return TabBarView(
      controller: controller,
      children: <Widget>[
        /*
        RefreshIndicator(
          onRefresh: () => viewModel.onRefreshed(context),
          child: DashboardPanels(
            viewModel: viewModel,
          ),
        ),
        */
        DashboardPanels(
          viewModel: viewModel,
        ),
        RefreshIndicator(
            onRefresh: () => viewModel.onRefreshed(context),
            child: DashboardActivity(viewModel: viewModel)),
      ],
    );
  }
}
