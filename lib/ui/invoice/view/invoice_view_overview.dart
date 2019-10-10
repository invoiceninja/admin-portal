import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/invoice_item_view.dart';
import 'package:invoiceninja_flutter/ui/app/one_value_header.dart';
import 'package:invoiceninja_flutter/ui/app/two_value_header.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceOverview extends StatelessWidget {
  const InvoiceOverview({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EntityViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final invoice = viewModel.invoice;
    final client = viewModel.client;
    final company = viewModel.company;

    final state = StoreProvider.of<AppState>(context).state;
    final payments = memoizedPaymentsByInvoice(
        invoice.id, state.paymentState.map, state.paymentState.list);

    final userCompany = state.userCompany;
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
          : localization.lookup('invoice_status_${invoice.invoiceStatusId}'),
      InvoiceFields.invoiceDate: formatDate(invoice.invoiceDate, context),
      InvoiceFields.dueDate: formatDate(invoice.dueDate, context),
      InvoiceFields.partial: formatNumber(invoice.partial, context,
          clientId: invoice.clientId, zeroIsNull: true),
      InvoiceFields.partialDueDate: formatDate(invoice.partialDueDate, context),
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
          title: EntityStateTitle(entity: client),
          leading: Icon(getEntityIcon(EntityType.client), size: 18.0),
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
              title: EntityStateTitle(entity: payment),
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
      FieldGrid(fields),
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

    if (invoice.invoiceItems.isNotEmpty) {
      invoice.invoiceItems.forEach((invoiceItem) {
        widgets.addAll([
          Builder(
            builder: (BuildContext context) {
              return InvoiceItemListTile(
                invoice: invoice,
                invoiceItem: invoiceItem,
                onTap: () => userCompany.canEditEntity(invoice)
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
    }

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

    if (invoice.customValue1 != 0 &&
        company.settings.enableCustomInvoiceTaxes1) {
      widgets.add(surchargeRow(
          company.getCustomFieldLabel(CustomFieldType.surcharge1),
          invoice.customValue1));
    }

    if (invoice.customValue2 != 0 &&
        company.settings.enableCustomInvoiceTaxes2) {
      widgets.add(surchargeRow(
          company.getCustomFieldLabel(CustomFieldType.surcharge2),
          invoice.customValue2));
    }

    invoice
        .calculateTaxes(company.settings.enableInclusiveTaxes)
        .forEach((taxName, taxAmount) {
      widgets.add(surchargeRow(taxName, taxAmount));
    });

    if (invoice.customValue1 != 0 &&
        !company.settings.enableCustomInvoiceTaxes1) {
      widgets.add(surchargeRow(
          company.getCustomFieldLabel(CustomFieldType.surcharge1),
          invoice.customValue1));
    }

    if (invoice.customValue2 != 0 &&
        !company.settings.enableCustomInvoiceTaxes2) {
      widgets.add(surchargeRow(
          company.getCustomFieldLabel(CustomFieldType.surcharge2),
          invoice.customValue2));
    }

    return ListView(
      children: widgets,
    );
  }
}
