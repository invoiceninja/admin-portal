import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/actions_menu_button.dart';
import 'package:invoiceninja/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja/ui/client/view/client_details.dart';
import 'package:invoiceninja/ui/client/view/client_overview.dart';
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
        title: Text(widget.viewModel.client.displayName), // Text(localizations.clientDetails),
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
        actions: widget.viewModel.client.id == null
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
                    //title: const Text('Set backup account'),
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
        child: Icon(Icons.add),
        tooltip: localization.create,
      ),
      /*
        body:
        */
      /*
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(children: [
          Card(
            elevation: 2.0,
            margin: EdgeInsets.all(0.0),
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: false,
                      key: _nameKey,
                      initialValue: viewModel.client.name,
                      decoration: InputDecoration(
                        labelText: AppLocalization.of(context).name,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          new Builder(builder: (BuildContext context) {
            return viewModel.client.isDeleted == true
                ? Container()
                : ProgressButton(
                    label: AppLocalization.of(context).save.toUpperCase(),
                    isLoading: viewModel.isLoading,
                    isDirty: viewModel.isDirty,
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }

                      viewModel.onSaveClicked(context,
                          viewModel.client.rebuild((b) => b
                            ..name = _nameKey.currentState.value)
                      );
                    },
                  );
          }),
        ]),
      ),
     */
    );
  }
}

