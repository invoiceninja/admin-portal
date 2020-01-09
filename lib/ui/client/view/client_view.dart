import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_activity.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_details.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_overview.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ClientView extends StatefulWidget {
  const ClientView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientViewVM viewModel;

  @override
  _ClientViewState createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
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
    final viewModel = widget.viewModel;
    final client = viewModel.client;
    final company = viewModel.company;
    final user = company.user;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: _CustomAppBar(
          viewModel: viewModel,
          controller: _controller,
        ),
        body: CustomTabBarView(
          viewModel: viewModel,
          controller: _controller,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColorDark,
          onPressed: () {
            showDialog<SimpleDialog>(
              context: context,
              builder: (BuildContext context) =>
                  SimpleDialog(children: <Widget>[
                user.canCreate(EntityType.client)
                    ? ListTile(
                        //dense: true,
                        leading: Icon(Icons.add_circle_outline),
                        title: Text(localization.invoice),
                        onTap: () {
                          Navigator.of(context).pop();
                          store.dispatch(EditInvoice(
                              invoice: InvoiceEntity(company: company)
                                  .rebuild((b) => b.clientId = client.id),
                              context: context));
                        },
                      )
                    : Container(),
                user.canCreate(EntityType.payment)
                    ? ListTile(
                        //dense: true,
                        leading: Icon(Icons.add_circle_outline),
                        title: Text(localization.payment),
                        onTap: () {
                          Navigator.of(context).pop();
                          store.dispatch(EditPayment(
                              payment: PaymentEntity(company: company)
                                  .rebuild((b) => b.clientId = client.id),
                              context: context));
                        },
                      )
                    : Container(),
                company.isModuleEnabled(EntityType.quote) &&
                        user.canCreate(EntityType.quote)
                    ? ListTile(
                        //dense: true,
                        leading: Icon(Icons.add_circle_outline),
                        title: Text(localization.quote),
                        onTap: () {
                          Navigator.of(context).pop();
                          store.dispatch(EditQuote(
                              quote: InvoiceEntity(isQuote: true)
                                  .rebuild((b) => b.clientId = client.id),
                              context: context));
                        },
                      )
                    : Container(),
                company.isModuleEnabled(EntityType.project) &&
                        user.canCreate(EntityType.project)
                    ? ListTile(
                        //dense: true,
                        leading: Icon(Icons.add_circle_outline),
                        title: Text(localization.project),
                        onTap: () {
                          Navigator.of(context).pop();
                          store.dispatch(EditProject(
                              project: ProjectEntity()
                                  .rebuild((b) => b.clientId = client.id),
                              context: context));
                        },
                      )
                    : Container(),
                company.isModuleEnabled(EntityType.task) &&
                        user.canCreate(EntityType.task)
                    ? ListTile(
                        //dense: true,
                        leading: Icon(Icons.add_circle_outline),
                        title: Text(localization.task),
                        onTap: () {
                          Navigator.of(context).pop();
                          store.dispatch(EditTask(
                              task: TaskEntity(
                                      isRunning:
                                          store.state.uiState.autoStartTasks)
                                  .rebuild((b) => b.clientId = client.id),
                              context: context));
                        },
                      )
                    : Container(),
                company.isModuleEnabled(EntityType.expense) &&
                        user.canCreate(EntityType.expense)
                    ? ListTile(
                        //dense: true,
                        leading: Icon(Icons.add_circle_outline),
                        title: Text(localization.expense),
                        onTap: () {
                          Navigator.of(context).pop();
                          store.dispatch(EditExpense(
                              expense: ExpenseEntity(
                                  company: company,
                                  client: client,
                                  uiState: store.state.uiState),
                              context: context));
                        },
                      )
                    : Container(),
              ]),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          tooltip: localization.create,
        ),
      ),
    );
  }
}

class CustomTabBarView extends StatefulWidget {
  const CustomTabBarView({
    @required this.viewModel,
    @required this.controller,
  });

  final ClientViewVM viewModel;
  final TabController controller;

  @override
  _CustomTabBarViewState createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;

    return TabBarView(
      controller: widget.controller,
      children: <Widget>[
        RefreshIndicator(
          onRefresh: () => viewModel.onRefreshed(context, false),
          child: ClientOverview(viewModel: viewModel),
        ),
        RefreshIndicator(
          onRefresh: () => viewModel.onRefreshed(context, false),
          child: ClientViewDetails(client: viewModel.client),
        ),
        RefreshIndicator(
          onRefresh: () => viewModel.onRefreshed(context, true),
          child: ClientViewActivity(
            viewModel: viewModel,
            key: ValueKey(viewModel.client.id),
          ),
        ),
      ],
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar({
    @required this.viewModel,
    @required this.controller,
  });

  final ClientViewVM viewModel;
  final TabController controller;

  @override
  final Size preferredSize = const Size(double.infinity, kToolbarHeight * 2);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final client = viewModel.client;
    final user = viewModel.company.user;

    return AppBar(
      automaticallyImplyLeading: isMobile(context),
      title: EntityStateTitle(entity: client),
      bottom: TabBar(
        controller: controller,
        //isScrollable: true,
        tabs: [
          Tab(
            text: localization.overview,
          ),
          Tab(
            text: localization.details,
          ),
          Tab(
            text: localization.activity,
          ),
        ],
      ),
      actions: client.isNew
          ? []
          : [
              user.canEditEntity(client)
                  ? EditIconButton(
                      isVisible: !client.isDeleted,
                      onPressed: () => viewModel.onEditPressed(context),
                    )
                  : Container(),
              ActionMenuButton(
                user: viewModel.company.user,
                isSaving: viewModel.isSaving,
                entity: client,
                onSelected: viewModel.onEntityAction,
                entityActions: viewModel.client.getActions(user: user),
              )
            ],
    );
  }
}
