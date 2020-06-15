import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/invoice_item_view.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceOverview extends StatelessWidget {
  const InvoiceOverview({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final EntityViewVM viewModel;
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final invoice = viewModel.invoice;
    final client = viewModel.client;
    final company = viewModel.company;

    final state = StoreProvider.of<AppState>(context).state;
    final payments = invoice.subEntityType == EntityType.quote
        ? <PaymentEntity>[]
        : memoizedPaymentsByInvoice(
            invoice.id, state.paymentState.map, state.paymentState.list);

    Map<String, String> stauses;
    Map<String, Color> colors;
    if (invoice.entityType == EntityType.quote) {
      stauses = kQuoteStatuses;
      colors = QuoteStatusColors.colors;
    } else if (invoice.entityType == EntityType.credit) {
      stauses = kCreditStatuses;
      colors = CreditStatusColors.colors;
    } else {
      stauses = kInvoiceStatuses;
      colors = InvoiceStatusColors.colors;
    }

    final userCompany = state.userCompany;
    final color = colors[invoice.calculatedStatusId];

    final widgets = <Widget>[
      EntityHeader(
        entity: invoice,
        statusColor: color,
        statusLabel: localization.lookup(stauses[invoice.calculatedStatusId]),
        label: invoice.subEntityType == EntityType.credit
            ? localization.creditAmount
            : invoice.subEntityType == EntityType.invoice
                ? localization.invoiceAmount
                : localization.quoteAmount,
        value:
            formatNumber(invoice.amount, context, clientId: invoice.clientId),
        secondLabel: invoice.subEntityType == EntityType.credit
            ? localization.creditRemaining
            : invoice.subEntityType == EntityType.invoice
                ? localization.balanceDue
                : null,
        secondValue: [EntityType.invoice, EntityType.credit]
                .contains(invoice.subEntityType)
            ? formatNumber(invoice.balance, context, clientId: invoice.clientId)
            : null,
      ),
      ListDivider(),
    ];

    String dueDateField = InvoiceFields.dueDate;
    if (invoice.subEntityType == EntityType.quote) {
      dueDateField = QuoteFields.validUntil;
    }

    final Map<String, String> fields = {
      InvoiceFields.invoiceDate: formatDate(invoice.date, context),
      dueDateField: formatDate(invoice.dueDate, context),
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

    if (invoice.customValue1.isNotEmpty) {
      final label1 = company.getCustomFieldLabel(CustomFieldType.invoice1);
      fields[label1] = formatCustomValue(
          context: context,
          field: CustomFieldType.invoice1,
          value: invoice.customValue1);
    }
    if (invoice.customValue2.isNotEmpty) {
      final label2 = company.getCustomFieldLabel(CustomFieldType.invoice2);
      fields[label2] = formatCustomValue(
          context: context,
          field: CustomFieldType.invoice2,
          value: invoice.customValue2);
    }

    widgets.add(
      EntityListTile(
        isFilter: isFilter,
        entity: client,
        onTap: () => viewModel.onClientPressed(context),
        onLongPress: () => viewModel.onClientPressed(context, true),
      ),
    );

    if (invoice.subEntityType == EntityType.quote ||
        invoice.subEntityType == EntityType.credit) {
      final relatedInvoice = state.invoiceState.map[invoice.invoiceId] ??
          InvoiceEntity(id: invoice.invoiceId);
      if ((invoice.invoiceId ?? '').isNotEmpty) {
        widgets.add(EntityListTile(
          isFilter: null,
          entity: relatedInvoice,
          onTap: () => viewEntity(context: context, entity: relatedInvoice),
        ));
      }
    }

    if (payments.isNotEmpty) {
      payments.forEach((payment) {
        widgets.add(
          EntityListTile(
            isFilter: isFilter,
            entity: payment,
            onTap: () => viewModel.onPaymentPressed(context, payment),
            onLongPress: () =>
                viewModel.onPaymentPressed(context, payment, true),
            subtitle:
                formatNumber(payment.amount, context, clientId: client.id) +
                    ' • ' +
                    formatDate(payment.date, context),
          ),
        );
      });

      widgets.addAll([
        ListDivider(),
      ]);
    }

    widgets.addAll([
      FieldGrid(fields),
    ]);

    if (invoice.privateNotes != null && invoice.privateNotes.isNotEmpty) {
      widgets.addAll([
        IconMessage(invoice.privateNotes),
        ListDivider(),
      ]);
    }

    if (invoice.lineItems.isNotEmpty) {
      invoice.lineItems.forEach((invoiceItem) {
        widgets.addAll([
          Builder(
            builder: (BuildContext context) {
              return InvoiceItemListTile(
                invoice: invoice,
                invoiceItem: invoiceItem,
                onTap: () => userCompany.canEditEntity(invoice)
                    ? viewModel.onEditPressed(
                        context, invoice.lineItems.indexOf(invoiceItem))
                    : null,
              );
            },
          ),
        ]);
      });

      widgets.addAll([
        ListDivider(),
      ]);
    }

    Widget surchargeRow(String label, double amount) {
      return Container(
        color: Theme.of(context).cardColor,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 12, right: 20, bottom: 12),
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

    if (invoice.customSurcharge1 != 0 && company.enableCustomSurchargeTaxes1) {
      widgets.add(surchargeRow(
          company.getCustomFieldLabel(CustomFieldType.surcharge1),
          invoice.customSurcharge1));
    }

    if (invoice.customSurcharge2 != 0 && company.enableCustomSurchargeTaxes2) {
      widgets.add(surchargeRow(
          company.getCustomFieldLabel(CustomFieldType.surcharge2),
          invoice.customSurcharge2));
    }

    invoice
        .calculateTaxes(invoice.usesInclusiveTaxes)
        .forEach((taxName, taxAmount) {
      widgets.add(surchargeRow(taxName, taxAmount));
    });

    if (invoice.customSurcharge1 != 0 && !company.enableCustomSurchargeTaxes1) {
      widgets.add(surchargeRow(
          company.getCustomFieldLabel(CustomFieldType.surcharge1),
          invoice.customSurcharge1));
    }

    if (invoice.customSurcharge2 != 0 && !company.enableCustomSurchargeTaxes2) {
      widgets.add(surchargeRow(
          company.getCustomFieldLabel(CustomFieldType.surcharge2),
          invoice.customSurcharge2));
    }

    if (invoice.customSurcharge3 != 0 && !company.enableCustomSurchargeTaxes3) {
      widgets.add(surchargeRow(
          company.getCustomFieldLabel(CustomFieldType.surcharge3),
          invoice.customSurcharge3));
    }

    if (invoice.customSurcharge4 != 0 && !company.enableCustomSurchargeTaxes4) {
      widgets.add(surchargeRow(
          company.getCustomFieldLabel(CustomFieldType.surcharge4),
          invoice.customSurcharge4));
    }

    return ListView(
      children: widgets,
    );
  }
}
