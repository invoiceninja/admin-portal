import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_activity.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_details.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_overview.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

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
    final userCompany = viewModel.state.userCompany;

    return ViewScaffold(
      entity: client,
      appBarBottom: TabBar(
        controller: _controller,
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
      body: Container(
        color: Theme.of(context).cardColor,
        child: TabBarView(
          controller: _controller,
          children: <Widget>[
            RefreshIndicator(
              onRefresh: () => viewModel.onRefreshed(context),
              child: ClientOverview(viewModel: viewModel),
            ),
            RefreshIndicator(
              onRefresh: () => viewModel.onRefreshed(context),
              child: ClientViewDetails(client: viewModel.client),
            ),
            RefreshIndicator(
              onRefresh: () => viewModel.onRefreshed(context),
              child: ClientViewActivity(
                viewModel: viewModel,
                key: ValueKey(viewModel.client.id),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'client_view_fab',
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () {
          showDialog<SimpleDialog>(
            context: context,
            builder: (BuildContext context) => SimpleDialog(children: <Widget>[
              userCompany.canCreate(EntityType.client)
                  ? ListTile(
                      //dense: true,
                      leading: Icon(Icons.add_circle_outline),
                      title: Text(localization.invoice),
                      onTap: () {
                        Navigator.of(context).pop();
                        handleClientAction(
                            context, [client], EntityAction.newInvoice);
                      },
                    )
                  : Container(),
              userCompany.canCreate(EntityType.payment)
                  ? ListTile(
                      //dense: true,
                      leading: Icon(Icons.add_circle_outline),
                      title: Text(localization.payment),
                      onTap: () {
                        Navigator.of(context).pop();
                        handleClientAction(
                            context, [client], EntityAction.newPayment);
                      },
                    )
                  : Container(),
              company.isModuleEnabled(EntityType.quote) &&
                      userCompany.canCreate(EntityType.quote)
                  ? ListTile(
                      //dense: true,
                      leading: Icon(Icons.add_circle_outline),
                      title: Text(localization.quote),
                      onTap: () {
                        Navigator.of(context).pop();
                        handleClientAction(
                            context, [client], EntityAction.newQuote);
                      },
                    )
                  : Container(),
              company.isModuleEnabled(EntityType.project) &&
                      userCompany.canCreate(EntityType.project)
                  ? ListTile(
                      //dense: true,
                      leading: Icon(Icons.add_circle_outline),
                      title: Text(localization.project),
                      onTap: () {
                        Navigator.of(context).pop();
                        handleClientAction(
                            context, [client], EntityAction.newProject);
                      },
                    )
                  : Container(),
              company.isModuleEnabled(EntityType.task) &&
                      userCompany.canCreate(EntityType.task)
                  ? ListTile(
                      //dense: true,
                      leading: Icon(Icons.add_circle_outline),
                      title: Text(localization.task),
                      onTap: () {
                        Navigator.of(context).pop();
                        handleClientAction(
                            context, [client], EntityAction.newTask);
                      },
                    )
                  : Container(),
              company.isModuleEnabled(EntityType.expense) &&
                      userCompany.canCreate(EntityType.expense)
                  ? ListTile(
                      //dense: true,
                      leading: Icon(Icons.add_circle_outline),
                      title: Text(localization.expense),
                      onTap: () {
                        Navigator.of(context).pop();
                        createEntity(
                            context: context,
                            entity: ExpenseEntity(
                              state: store.state,
                              client: client,
                            ));
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
    );
  }
}
