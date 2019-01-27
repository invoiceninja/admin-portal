import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/app/one_value_header.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/invoice_item_view.dart';
import 'package:invoiceninja_flutter/ui/app/two_value_header.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceView extends StatefulWidget {
  const InvoiceView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EntityViewVM viewModel;

  @override
  _InvoiceViewState createState() => new _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final invoice = widget.viewModel.invoice;
    final client = viewModel.client;
    final company = viewModel.company;

    final state = StoreProvider.of<AppState>(context).state;
    final payments = memoizedPaymentsByInvoice(
        invoice.id, state.paymentState.map, state.paymentState.list);

    List<Widget> _buildView() {
      final user = widget.viewModel.company.user;
      final color = invoice.isPastDue
          ? Colors.red
          : InvoiceStatusColors.colors[invoice.invoiceStatusId];
      final widgets = <Widget>[
        invoice.isQuote
            ? OneValueHeader(
                backgroundColor: color,
                label: localization.totalAmount,
                value: formatNumber(invoice.amount, context,
                    clientId: invoice.clientId),
              )
            : TwoValueHeader(
                backgroundColor: color,
                label1: localization.totalAmount,
                value1: formatNumber(invoice.amount, context,
                    clientId: invoice.clientId),
                label2: localization.balanceDue,
                value2: formatNumber(invoice.balance, context,
                    clientId: invoice.clientId),
              ),
      ];

      final Map<String, String> fields = {
        InvoiceFields.invoiceStatusId: invoice.isPastDue
            ? localization.pastDue
            : (invoice.invoiceStatusId > 0
                ? localization
                    .lookup('invoice_status_${invoice.invoiceStatusId}')
                : null),
        InvoiceFields.invoiceDate: formatDate(invoice.invoiceDate, context),
        InvoiceFields.dueDate: formatDate(invoice.dueDate, context),
        InvoiceFields.partial: formatNumber(invoice.partial, context,
            clientId: invoice.clientId, zeroIsNull: true),
        InvoiceFields.partialDueDate:
            formatDate(invoice.partialDueDate, context),
        InvoiceFields.poNumber: invoice.poNumber,
        InvoiceFields.discount: formatNumber(invoice.discount, context,
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

      widgets.addAll([
        Material(
          color: Theme.of(context).canvasColor,
          child: ListTile(
            title: Text(client?.displayName ?? ''),
            leading: Icon(FontAwesomeIcons.users, size: 18.0),
            trailing: Icon(Icons.navigate_next),
            onTap: () => viewModel.onClientPressed(context),
            onLongPress: () => viewModel.onClientPressed(context, true),
          ),
        ),
        Container(
          color: Theme.of(context).backgroundColor,
          height: 12.0,
        ),
      ]);

      if (payments.isNotEmpty) {
        if (payments.length == 1) {
          final payment = payments.first;
          widgets.addAll([
            Material(
              color: Theme.of(context).canvasColor,
              child: ListTile(
                title: Text(localization.payment),
                subtitle: Text(
                    formatNumber(payment.amount, context, clientId: client.id) +
                        ' • ' +
                        formatDate(payment.paymentDate, context)),
                leading: Icon(FontAwesomeIcons.creditCard, size: 18.0),
                trailing: Icon(Icons.navigate_next),
                onTap: () => viewModel.onPaymentPressed(context, payment),
                onLongPress: () =>
                    viewModel.onPaymentPressed(context, payment, true),
              ),
            ),
          ]);
        } else {
          widgets.addAll([
            Material(
              color: Theme.of(context).canvasColor,
              child: ListTile(
                title: Text(localization.payments),
                leading: Icon(FontAwesomeIcons.creditCard, size: 18.0),
                trailing: Icon(Icons.navigate_next),
                onTap: () => viewModel.onPaymentsPressed(context),
              ),
            ),
          ]);
        }

        widgets.addAll([
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
        ]);
      }

      widgets.addAll([
        FieldGrid(fields,
            fieldConverter: invoice.isQuote ? QuoteFields.convertField : null),
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
          Builder(
            builder: (BuildContext context) {
              return InvoiceItemListTile(
                invoice: invoice,
                invoiceItem: invoiceItem,
                onTap: () => user.canEditEntity(invoice)
                    ? viewModel.onEditPressed(context, invoiceItem)
                    : null,
              );
            },
          ),
        ]);
      });

      widgets.addAll([
        Container(
          color: Theme.of(context).backgroundColor,
          height: 12.0,
        ),
      ]);

      Widget surchargeRow(String label, double amount) {
        return Container(
          color: Theme.of(context).canvasColor,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 12.0, right: 16.0, bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(label),
                SizedBox(
                  width: 80.0,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(formatNumber(amount, context,
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

      return widgets;
    }

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: _CustomAppBar(
          viewModel: viewModel,
        ),
        body: Builder(
          builder: (BuildContext context) {
            return RefreshIndicator(
              onRefresh: () => viewModel.onRefreshed(context),
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: ListView(
                  children: _buildView(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar({
    @required this.viewModel,
  });

  final EntityViewVM viewModel;

  @override
  final Size preferredSize = const Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final invoice = viewModel.invoice;
    final client = viewModel.client;
    final user = viewModel.company.user;

    return AppBar(
      title: Text(
          '${invoice.isQuote ? localization.quote : localization.invoice} ${invoice.invoiceNumber}'),
      actions: invoice.isNew
          ? []
          : [
              user.canEditEntity(invoice)
                  ? EditIconButton(
                      isVisible: !invoice.isDeleted,
                      onPressed: () => viewModel.onEditPressed(context),
                    )
                  : Container(),
              ActionMenuButton(
                user: user,
                entityActions:
                    invoice.getEntityActions(client: client, user: user),
                isSaving: viewModel.isSaving,
                entity: invoice,
                onSelected: viewModel.onActionSelected,
              )
            ],
    );
  }
}
