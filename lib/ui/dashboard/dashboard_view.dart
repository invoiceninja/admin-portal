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
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_activity.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_panels.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DashboardVM viewModel;

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

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
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
