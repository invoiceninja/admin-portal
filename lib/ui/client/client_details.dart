import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja/ui/app/actions_menu_button.dart';
import 'package:invoiceninja/ui/app/progress_button.dart';
import 'package:invoiceninja/ui/client/client_details_vm.dart';
import 'package:invoiceninja/utils/formatting.dart';
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

  _buildOverviewList() {
    var localization = AppLocalization.of(context);
    var client = widget.viewModel.client;
    var listTiles = <Widget>[];

    return listTiles;
  }

  _buildDetailsList() {
    var localization = AppLocalization.of(context);
    var client = widget.viewModel.client;
    var listTiles = <Widget>[];

    if (client.vatNumber.isNotEmpty) {
      listTiles.add(AppListTile(
        icon: Icons.location_city,
        title: client.vatNumber,
        subtitle: localization.vatNumber,
      ));
    }

    if (client.idNumber.isNotEmpty) {
      listTiles.add(AppListTile(
        icon: Icons.business,
        title: client.idNumber,
        subtitle: localization.idNumber,
      ));
    }

    var billingAddress = formatAddress(client);
    var shippingAddress = formatAddress(client, true);

    if (billingAddress.isNotEmpty) {
      listTiles.add(AppListTile(
        icon: Icons.pin_drop,
        title: billingAddress,
        subtitle: localization.billingAddress,
      ));
    }

    if (shippingAddress.isNotEmpty) {
      listTiles.add(AppListTile(
        icon: Icons.pin_drop,
        title: shippingAddress,
        subtitle: localization.shippingAddress,
      ));
    }

    if (client.website.isNotEmpty) {
      listTiles.add(AppListTile(
        icon: Icons.link,
        title: client.website,
        subtitle: localization.website,
      ));
    }

    if (client.workPhone.isNotEmpty) {
      listTiles.add(AppListTile(
        icon: Icons.phone,
        title: client.workPhone,
        subtitle: localization.phone,
      ));
    }

    listTiles.add(Divider());

    var contacts = client.contacts;
    contacts.forEach((contact) {
      if (contact.email.isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.email,
          title: contact.fullName() + '\n' + contact.email,
          subtitle: localization.email,
        ));
      }

      if (contact.phone.isNotEmpty) {
        listTiles.add(AppListTile(
          icon: Icons.phone,
          title: contact.fullName() + '\n' + contact.phone,
          subtitle: localization.phone,
        ));
      }
    });

    return listTiles;
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    Widget _overview() {
      _headerRow() {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(localization.balanceDue,
                    style: TextStyle(color: Colors.grey[700])),
                Text(
                  widget.viewModel.client.balance.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(localization.paidToDate,
                    style: TextStyle(color: Colors.grey[700])),
                Text(
                  widget.viewModel.client.paidToDate.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        );
      }

      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Card(
              elevation: 2.0,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: _headerRow(),
              ),
            ),
          ),
          Divider(height: 1.0,),
          Container(
            color: Colors.white,
            child: Material(
              type: MaterialType.transparency,
              child: ListTile(
                title: Text(localization.invoices),
                leading: Icon(FontAwesomeIcons.filePdfO, size: 18.0),
                trailing: Icon(Icons.navigate_next),
                onTap: () {},
              ),
            ),
          ),
          Divider(
            height: 1.0,
          ),
          Container(
            color: Colors.white,
            child: Material(
              type: MaterialType.transparency,
              child: ListTile(
                title: Text(localization.payments),
                leading: Icon(FontAwesomeIcons.creditCard, size: 18.0),
                trailing: Icon(Icons.navigate_next),
                onTap: () {},
              ),
            ),
          ),
          Divider(height: 1.0,),
        ],
      );
    }

    Widget _details() {
      return Padding(
        padding: EdgeInsets.all(12.0),
        child: ListView(
          children: _buildDetailsList(),
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

class AppListTile extends StatelessWidget {
  AppListTile({
    this.icon,
    this.title,
    this.subtitle,
    this.dense = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 12.0, top: 8.0, bottom: 8.0),
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle == null ? Container() : Text(subtitle),
      dense: dense,
    );
  }
}
