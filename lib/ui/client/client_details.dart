import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/actions_menu_button.dart';
import 'package:invoiceninja/ui/app/progress_button.dart';
import 'package:invoiceninja/ui/client/client_details_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientDetails extends StatefulWidget {
  final ClientDetailsVM viewModel;

  ClientDetails({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _ClientDetailsState createState() => new _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> _nameKey =
      GlobalKey<FormFieldState<String>>();
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

    Widget _overview() {
      return Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.pin_drop),
              title: Text(widget.viewModel.client.address1),
              subtitle: Text(localization.billingAddress),
            )
          ],
        ),
      );
    }

    Widget _details() {
      return Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.pin_drop),
              title: Text(widget.viewModel.client.address1),
              subtitle: Text(localization.billingAddress),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.viewModel.client.id == null
            ? localization.newClient
            : widget.viewModel.client
                .displayName), // Text(localizations.clientDetails),
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
                ActionMenuButton(
                  entity: widget.viewModel.client,
                  onSelected: widget.viewModel.onActionSelected,
                )
              ],
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          _overview(),
          _details(),
        ],
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
