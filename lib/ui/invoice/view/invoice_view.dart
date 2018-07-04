import 'package:invoiceninja/constants.dart';
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

  const InvoiceView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _InvoiceViewState createState() => new _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final invoice = viewModel.invoice;
    final client = viewModel.client;
    final company = state.selectedCompany;

    List<Widget> _buildView() {
      final invoice = widget.viewModel.invoice;
      final widgets = <Widget>[
        TwoValueHeader(
          backgroundColor: InvoiceStatusColors.colors[invoice.invoiceStatusId][200],
          label1: localization.totalAmount,
          value1:
              formatNumber(invoice.amount, state, clientId: invoice.clientId),
          label2: localization.balanceDue,
          value2:
              formatNumber(invoice.balance, state, clientId: invoice.clientId),
        ),
      ];

      final Map<String, String> fields = {
        InvoiceFields.invoiceStatusId:
            invoiceStatusSelector(invoice, store.state.staticState),
        InvoiceFields.invoiceDate: invoice.invoiceDate,
        InvoiceFields.dueDate: invoice.dueDate,
        InvoiceFields.partial: formatNumber(invoice.partial, state,
            clientId: invoice.clientId, zeroIsNull: true),
        InvoiceFields.partialDueDate: invoice.partialDueDate,
        InvoiceFields.poNumber: invoice.poNumber,
        InvoiceFields.discount: formatNumber(
            invoice.discount, widget.viewModel.state,
            clientId: invoice.clientId,
            zeroIsNull: true,
            formatNumberType: invoice.isAmountDiscount
                ? FormatNumberType.money
                : FormatNumberType.percent),
      };

      if (invoice.customTextValue1.isNotEmpty) {
        final label1 = company.getCustomFieldLabel(CustomFieldType.invoice1);
        fields[label1] = invoice.customTextValue1;
      }
      if (invoice.customTextValue2.isNotEmpty) {
        final label2 = company.getCustomFieldLabel(CustomFieldType.invoice2);
        fields[label2] = invoice.customTextValue2;
      }

      final List<Widget> fieldWidgets = [];
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
        Material(
          color: Theme.of(context).canvasColor,
          child: ListTile(
            title: Text(client?.displayName ?? ''),
            leading: Icon(FontAwesomeIcons.users, size: 18.0),
            trailing: Icon(Icons.navigate_next),
            onTap: () => viewModel.onClientPressed(context),
          ),
        ),
        Divider(height: 1.0),
        Container(
          color: Theme.of(context).backgroundColor,
          height: 12.0,
        ),
        Divider(height: 1.0),
        Container(
          color: Theme.of(context).canvasColor,
          child: Padding(
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
              invoice: invoice, invoiceItem: invoiceItem, state: state),
          Divider(height: 1.0)
        ]);
      });

      widgets.addAll([
        Container(
          color: Theme.of(context).backgroundColor,
          height: 12.0,
        ),
        Divider(height: 1.0),
      ]);

      Widget surchargeRow(String label, double amount) {
        return Container(
          color: Theme.of(context).canvasColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12.0, right: 16.0, bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(label),
                SizedBox(
                  width: 80.0,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(formatNumber(amount, viewModel.state,
                          clientId: invoice.clientId))),
                ),
              ],
            ),
          ),
        );
      }

      if (invoice.customValue1 != 0 && company.enableCustomInvoiceTaxes1) {
        widgets.add(surchargeRow(
            company.getCustomFieldLabel(CustomFieldType.surcharge1),
            invoice.customValue1));
      }

      if (invoice.customValue2 != 0 && company.enableCustomInvoiceTaxes2) {
        widgets.add(surchargeRow(
            company.getCustomFieldLabel(CustomFieldType.surcharge2),
            invoice.customValue2));
      }

      invoice
          .calculateTaxes(company.enableInclusiveTaxes)
          .forEach((taxName, taxAmount) {
        widgets.add(surchargeRow(taxName, taxAmount));
      });

      if (invoice.customValue1 != 0 && !company.enableCustomInvoiceTaxes1) {
        widgets.add(surchargeRow(
            company.getCustomFieldLabel(CustomFieldType.surcharge1),
            invoice.customValue1));
      }

      if (invoice.customValue2 != 0 && !company.enableCustomInvoiceTaxes2) {
        widgets.add(surchargeRow(
            company.getCustomFieldLabel(CustomFieldType.surcharge2),
            invoice.customValue2));
      }

      widgets.addAll([
        Divider(height: 1.0),
      ]);

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
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: ListView(
            children: _buildView(),
          ),
        ),
      ),
    );
  }
}
