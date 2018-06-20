import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/ui/app/actions_menu_button.dart';
import 'package:invoiceninja/ui/app/two_value_header.dart';
import 'package:invoiceninja/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class InvoiceView extends StatefulWidget {
  final InvoiceViewVM viewModel;

  InvoiceView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _InvoiceViewState createState() => new _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView>
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
    var store = StoreProvider.of<AppState>(context);
    var invoice = widget.viewModel.invoice;

    _launchURL() async {
      const url = 'https://flutter.io';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text((localization.invoice + ' ' + widget.viewModel.invoice.invoiceNumber) ?? ''), // Text(localizations.invoiceDetails),
        actions: widget.viewModel.invoice.isNew()
            ? []
            : [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              widget.viewModel.onEditPressed(context);
            },
          ),
          ActionMenuButton(
            entity: widget.viewModel.invoice,
            onSelected: widget.viewModel.onActionSelected,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _launchURL();
          }
      ),
      body: ListView(
        children: <Widget>[
          TwoValueHeader(
            label1: localization.totalAmount,
            value1: invoice.amount,
            label2: localization.balanceDue,
            value2: invoice.balance,
          ),
          Divider(
            height: 1.0,
          ),
          ListTile(
            title: Text(widget.viewModel.client?.displayName ?? ''),
            leading: Icon(FontAwesomeIcons.users, size: 18.0),
            trailing: Icon(Icons.navigate_next),
            onTap: () => widget.viewModel.onClientPressed(context),
          ),
          Divider(
            height: 1.0,
          ),
        ],
      ),
    );
  }
}
