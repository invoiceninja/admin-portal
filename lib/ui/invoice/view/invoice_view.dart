import 'package:invoiceninja/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja/ui/app/actions_menu_button.dart';
import 'package:invoiceninja/ui/app/icon_message.dart';
import 'package:invoiceninja/ui/app/invoice/invoice_item_view.dart';
import 'package:invoiceninja/ui/app/two_value_header.dart';
import 'package:invoiceninja/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

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
    var appState = viewModel.appState;
    var invoice = viewModel.invoice;
    var client = viewModel.client;

    List<Widget> _buildView() {
      var invoice = widget.viewModel.invoice;
      var widgets = <Widget>[
        TwoValueHeader(
          label1: localization.totalAmount,
          value1: formatNumber(invoice.amount, appState,
              clientId: invoice.clientId),
          label2: localization.balanceDue,
          value2: formatNumber(invoice.balance, appState,
              clientId: invoice.clientId),
        ),
      ];

      Map<String, String> fields = {
        InvoiceFields.invoiceStatusId:
            invoiceStatusSelector(invoice, store.state.staticState),
        InvoiceFields.invoiceDate: invoice.invoiceDate,
        InvoiceFields.dueDate: invoice.dueDate,
        InvoiceFields.partial: formatNumber(invoice.partial, appState,
            clientId: invoice.clientId, zeroIsNull: true),
        InvoiceFields.partialDueDate: invoice.partialDueDate,
        InvoiceFields.poNumber: invoice.poNumber,
        InvoiceFields.discount: formatNumber(
            invoice.discount, widget.viewModel.appState,
            clientId: invoice.clientId,
            zeroIsNull: true,
            formatNumberType: invoice.isAmountDiscount
                ? FormatNumberType.money
                : FormatNumberType.percent),
      };

      List<Widget> fieldWidgets = [];
      fields.forEach((field, value) {
        if (value != null && value.isNotEmpty) {
          fieldWidgets.add(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Text(
                  localization.lookup(field),
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Flexible(
                  child: Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              )),
            ],
          ));
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
        Divider(height: 1.0),
        Container(
          color: Theme.of(context).backgroundColor,
          height: 12.0,
        ),
        Divider(height: 1.0),
        Padding(
          padding: EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0),
          child: IgnorePointer(
            child: GridView.count(
              shrinkWrap: true,
              primary: true,
              crossAxisCount: 2,
              children: fieldWidgets,
              childAspectRatio: 3.5,
            ),
          ),
        ),
        Divider(height: 1.0),
        Container(
          color: Theme.of(context).backgroundColor,
          height: 12.0,
        ),
        Divider(height: 1.0),
      ]);

      if (invoice.privateNotes != null && invoice.privateNotes.isNotEmpty) {
        widgets.addAll([
          IconMessage(invoice.privateNotes),
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
        ]);
      }

      invoice.invoiceItems.forEach((invoiceItem) {
        widgets.addAll([
          InvoiceItemListTile(
              invoice: invoice, invoiceItem: invoiceItem, state: appState),
          Divider(height: 1.0)
        ]);
      });

      return widgets;
    }

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              Text((localization.invoice + ' ' + invoice.invoiceNumber) ?? ''),
          actions: invoice.isNew
              ? []
              : [
                  EditIconButton(
                    isVisible: !invoice.isDeleted,
                    onPressed: () => viewModel.onEditPressed(context),
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
      ),
    );
  }
}
