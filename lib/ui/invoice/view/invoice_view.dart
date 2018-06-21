import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/ui/app/actions_menu_button.dart';
import 'package:invoiceninja/ui/app/icon_message.dart';
import 'package:invoiceninja/ui/app/invoice/invoice_item_view.dart';
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

class _InvoiceViewState extends State<InvoiceView> {
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

    _buildView() {
      var invoice = widget.viewModel.invoice;
      var widgets = <Widget>[
        TwoValueHeader(
          label1: localization.totalAmount,
          value1: invoice.amount,
          label2: localization.balanceDue,
          value2: invoice.balance,
        ),
      ];

      if (invoice.privateNotes != null && invoice.privateNotes.isNotEmpty) {
        widgets.add(IconMessage(invoice.privateNotes));
      }

      Map<String, String> fields = {
        InvoiceFields.invoiceDate: invoice.invoiceDate,
        InvoiceFields.dueDate: invoice.dueDate,
        InvoiceFields.partial: invoice.partial.toStringAsFixed(2),
        InvoiceFields.partialDueDate: invoice.partialDueDate,
        InvoiceFields.poNumber: invoice.poNumber,
        InvoiceFields.discount: invoice.discount.toStringAsFixed(2),
      };

      List<Widget> fieldWidgets = [];
      fields.forEach((field, value) {
        if (value != null && value.isNotEmpty) {
          fieldWidgets.add(Row(
            children: <Widget>[
              SizedBox(
                child: Text(localization.lookup(field)),
                width: 100.0,
              ),
              Text(value),
            ],
          ));
          fieldWidgets.addAll([]);
        }
      });

      widgets.addAll([
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
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: fieldWidgets,
          ),
        )
      ]);

      invoice.invoiceItems.forEach((invoiceItem) {
        widgets.add(InvoiceItemListTile(invoiceItem));
      });

      return widgets;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text((localization.invoice + ' ' + invoice.invoiceNumber) ?? ''),
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
        children: _buildView(),
      ),
    );
  }
}
