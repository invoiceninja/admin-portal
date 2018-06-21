import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja/data/models/models.dart';
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
    var viewModel = widget.viewModel;
    var invoice = viewModel.invoice;
    var client = viewModel.client;

    _launchURL() async {
      var url = 'http://www.google.com';
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false, forceWebView: false);
      } else {
        throw '${localization.couldNotLaunch}';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text((localization.invoice + ' ' + invoice.invoiceNumber) ??
            ''), // Text(localizations.invoiceDetails),
        actions: invoice.isNew()
            ? []
            : [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    viewModel.onEditPressed(context);
                  },
                ),
                ActionMenuButton(
                  customActions: [
                    client.hasEmailAddress
                        ? ActionMenuChoice(
                            action: EntityAction.email,
                            icon: Icons.send,
                            label: AppLocalization.of(context).email,
                          )
                        : null,
                    ActionMenuChoice(
                      action: EntityAction.pdf,
                      icon: Icons.picture_as_pdf,
                      label: AppLocalization.of(context).pdf,
                    ),
                  ],
                  isLoading: viewModel.isLoading,
                  entity: invoice,
                  onSelected: viewModel.onActionSelected,
                )
              ],
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
            title: Text(client?.displayName ?? ''),
            leading: Icon(FontAwesomeIcons.users, size: 18.0),
            trailing: Icon(Icons.navigate_next),
            onTap: () => viewModel.onClientPressed(context),
          ),
          Divider(
            height: 1.0,
          ),
        ],
      ),
    );
  }
}
