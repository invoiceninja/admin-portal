import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/actions_menu_button.dart';
import 'package:invoiceninja/ui/client/view/client_view_details.dart';
import 'package:invoiceninja/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja/ui/client/view/client_view_overview.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientView extends StatefulWidget {
  final ClientViewVM viewModel;

  ClientView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _ClientViewState createState() => new _ClientViewState();
}

class _ClientViewState extends State<ClientView>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.viewModel.client
            .displayName ?? ''), // Text(localizations.clientDetails),
        bottom: TabBar(
          controller: _controller,
          //isScrollable: true,
          tabs: [
            Tab(
              text: localization.overview,
            ),
            Tab(
              text: localization.details,
            ),
          ],
        ),
        actions: widget.viewModel.client.isNew()
            ? []
            : [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    widget.viewModel.onEditClicked(context);
                  },
                ),
                ActionMenuButton(
                  entity: widget.viewModel.client,
                  onSelected: widget.viewModel.onActionSelected,
                )
              ],
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          ClientOverview(client: widget.viewModel.client),
          ClientViewDetails(client: widget.viewModel.client),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => SimpleDialog(
                    children: <Widget>[
                      ListTile(
                        dense: true,
                        leading: Icon(Icons.add_circle_outline),
                        title: Text(localization.invoice),
                        onTap: () {},
                      ),
                      ListTile(
                        dense: true,
                        leading: Icon(Icons.add_circle_outline),
                        title: Text(localization.payment),
                        onTap: () {},
                      ),
                    ]),
          );
        },
        child: Icon(Icons.add, color: Colors.white,),
        tooltip: localization.create,
      ),
    );
  }
}
