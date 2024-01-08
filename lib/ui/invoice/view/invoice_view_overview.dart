// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/colors.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/purchase_order_model.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/data/models/recurring_invoice_model.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/invoice_item_view.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/portal_links.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceOverview extends StatelessWidget {
  const InvoiceOverview({
    Key? key,
    required this.viewModel,
    required this.isFilter,
  }) : super(key: key);

  final AbstractInvoiceViewVM viewModel;
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final state = viewModel.state!;
    final invoice = viewModel.invoice!;
    final client = viewModel.client;
    final vendor = state.vendorState.get(invoice.vendorId);
    final company = viewModel.company!;

    final creditMap = <PaymentableEntity, PaymentEntity?>{};
    final paymentMap = <PaymentableEntity, PaymentEntity?>{};
    final payments = invoice.isInvoice
        ? memoizedPaymentsByInvoice(
            invoice.id, state.paymentState.map, state.paymentState.list)
        : invoice.isCredit
            ? memoizedPaymentsByCredit(
                invoice.id, state.paymentState.map, state.paymentState.list)
            : <PaymentEntity>[];

    payments.forEach((payment) {
      payment!.invoicePaymentables.forEach((paymentable) {
        if (paymentable.invoiceId == invoice.id) {
          paymentMap[paymentable] = payment;
        }
      });
      payment.creditPaymentables.forEach((paymentable) {
        if (paymentable.creditId == invoice.id) {
          creditMap[paymentable] = payment;
        }
      });
    });

    Map<String, String> statuses;
    Map<String, Color?> colors;
    if (invoice.entityType == EntityType.quote) {
      statuses = kQuoteStatuses;
      colors = QuoteStatusColors(state.prefState.colorThemeModel).colors;
    } else if (invoice.entityType == EntityType.credit) {
      statuses = kCreditStatuses;
      colors = CreditStatusColors(state.prefState.colorThemeModel).colors;
    } else if (invoice.entityType == EntityType.recurringInvoice) {
      statuses = kRecurringInvoiceStatuses;
      colors =
          RecurringInvoiceStatusColors(state.prefState.colorThemeModel).colors;
    } else if (invoice.entityType == EntityType.purchaseOrder) {
      statuses = kPurchaseOrderStatuses;
      colors =
          PurchaseOrderStatusColors(state.prefState.colorThemeModel).colors;
    } else {
      statuses = kInvoiceStatuses;
      colors = InvoiceStatusColors(state.prefState.colorThemeModel).colors;
    }

    final userCompany = state.userCompany;
    final color = colors[invoice.calculatedStatusId];

    final widgets = <Widget>[
      EntityHeader(
        entity: invoice,
        statusColor: color,
        statusLabel: localization.lookup(statuses[invoice.calculatedStatusId]),
        label: invoice.isPurchaseOrder
            ? localization.amount
            : invoice.isCredit
                ? localization.creditAmount
                : invoice.isQuote
                    ? localization.quoteAmount
                    : localization.invoiceAmount,
        value: formatNumber(
          invoice.amount,
          context,
          clientId: invoice.isPurchaseOrder ? null : invoice.clientId,
          vendorId: invoice.isPurchaseOrder ? invoice.vendorId : null,
        ),
        secondLabel: invoice.isCredit
            ? localization.creditRemaining
            : (invoice.isQuote || invoice.isRecurringInvoice)
                ? null
                : localization.balanceDue,
        secondValue:
            [EntityType.invoice, EntityType.credit].contains(invoice.entityType)
                ? formatNumber(
                    invoice.balanceOrAmount,
                    context,
                    clientId: invoice.isPurchaseOrder ? null : invoice.clientId,
                    vendorId: invoice.isPurchaseOrder ? invoice.vendorId : null,
                  )
                : null,
      ),
      ListDivider(),
    ];

    widgets.addAll([
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: PortalLinks(
          viewLink: invoice.invitationSilentLink,
          copyLink: invoice.invitationLink,
          client: client,
        ),
      ),
      ListDivider(),
    ]);

    if (invoice.privateNotes.isNotEmpty) {
      widgets.addAll([
        IconMessage(invoice.privateNotes,
            iconData: Icons.lock, copyToClipboard: true),
        ListDivider(),
      ]);
    }

    String dueDateField = InvoiceFields.dueDate;
    if (invoice.isQuote || invoice.isCredit) {
      dueDateField = QuoteFields.validUntil;
    }

    final Map<String, String?> fields = {
      if (invoice.isQuote)
        QuoteFields.date: formatDate(invoice.date, context)
      else if (invoice.isCredit)
        CreditFields.date: formatDate(invoice.date, context)
      else if (invoice.isPurchaseOrder)
        PurchaseOrderFields.date: formatDate(invoice.date, context)
      else if (invoice.isInvoice)
        InvoiceFields.date: formatDate(invoice.date, context),
      dueDateField: formatDate(invoice.dueDate, context),
      if (invoice.isInvoice && !invoice.isPaid)
        InvoiceFields.nextSendDate: formatDate(invoice.nextSendDate, context),
      InvoiceFields.partial: formatNumber(invoice.partial, context,
          clientId: invoice.isPurchaseOrder ? null : invoice.clientId,
          vendorId: invoice.isPurchaseOrder ? invoice.vendorId : null,
          zeroIsNull: true),
      InvoiceFields.partialDueDate: formatDate(invoice.partialDueDate, context),
      InvoiceFields.poNumber: invoice.poNumber,
      InvoiceFields.discount: formatNumber(invoice.discount, context,
          clientId: invoice.isPurchaseOrder ? null : invoice.clientId,
          vendorId: invoice.isPurchaseOrder ? invoice.vendorId : null,
          zeroIsNull: true,
          formatNumberType: invoice.isAmountDiscount
              ? FormatNumberType.money
              : FormatNumberType.percent),
      if (invoice.isRecurringInvoice) ...{
        RecurringInvoiceFields.frequency:
            localization.lookup(kFrequencies[invoice.frequencyId]),
        RecurringInvoiceFields.lastSentDate:
            formatDate(invoice.lastSentDate, context),
        RecurringInvoiceFields.nextSendDate:
            formatDate(invoice.nextSendDate, context),
        if (invoice.nextSendDatetime.isNotEmpty)
          RecurringInvoiceFields.nextSendTime: formatDate(
              invoice.nextSendDatetime, context,
              showDate: false, showTime: true, showSeconds: false),
        RecurringInvoiceFields.remainingCycles: invoice.remainingCycles == -1
            ? localization.endless
            : '${invoice.remainingCycles}',
        RecurringInvoiceFields.autoBill: localization.lookup(invoice.autoBill) +
            ([SettingsEntity.AUTO_BILL_OPT_IN, SettingsEntity.AUTO_BILL_OPT_OUT]
                    .contains(invoice.autoBill)
                ? (' - ' +
                    (invoice.autoBillEnabled
                        ? localization.yes
                        : localization.no))
                : ''),
        InvoiceFields.dueDate: invoice.dueDateDays == 'terms'
            ? localization.paymentTerm
            : invoice.dueDateDays == 'on_receipt'
                ? localization.dueOnReceipt
                : invoice.dueDateDays == '1'
                    ? localization.firstDayOfTheMonth
                    : invoice.dueDateDays == '31'
                        ? localization.lastDayOfTheMonth
                        : localization.dayCount
                            .replaceFirst(':count', '${invoice.dueDateDays}'),
      }
    };

    if (company.hasCustomField(CustomFieldType.invoice1) &&
        invoice.customValue1.isNotEmpty) {
      final label1 = company.getCustomFieldLabel(CustomFieldType.invoice1);
      fields[label1] = formatCustomValue(
          context: context,
          field: CustomFieldType.invoice1,
          value: invoice.customValue1);
    }
    if (company.hasCustomField(CustomFieldType.invoice2) &&
        invoice.customValue2.isNotEmpty) {
      final label2 = company.getCustomFieldLabel(CustomFieldType.invoice2);
      fields[label2] = formatCustomValue(
          context: context,
          field: CustomFieldType.invoice2,
          value: invoice.customValue2);
    }
    if (company.hasCustomField(CustomFieldType.invoice3) &&
        invoice.customValue3.isNotEmpty) {
      final label3 = company.getCustomFieldLabel(CustomFieldType.invoice3);
      fields[label3] = formatCustomValue(
          context: context,
          field: CustomFieldType.invoice3,
          value: invoice.customValue3);
    }
    if (company.hasCustomField(CustomFieldType.invoice4) &&
        invoice.customValue4.isNotEmpty) {
      final label4 = company.getCustomFieldLabel(CustomFieldType.invoice4);
      fields[label4] = formatCustomValue(
          context: context,
          field: CustomFieldType.invoice4,
          value: invoice.customValue4);
    }

    if (invoice.isPurchaseOrder) {
      widgets.add(
        EntityListTile(
          isFilter: isFilter,
          entity: vendor,
          subtitle: vendor
              .getContact(invoice.invitations.first.vendorContactId)
              .emailOrFullName,
        ),
      );
    } else if (client != null) {
      widgets.add(EntityListTile(
        isFilter: isFilter,
        entity: client,
        subtitle: client
            .getContact(invoice.invitations.first.clientContactId)
            .emailOrFullName,
      ));
    }

    if (invoice.projectId.isNotEmpty) {
      final project = state.projectState.get(invoice.projectId);
      widgets.add(EntityListTile(entity: project, isFilter: isFilter));
    }

    if (invoice.expenseId.isNotEmpty) {
      final expense = state.vendorState.get(invoice.expenseId);
      widgets.add(EntityListTile(entity: expense, isFilter: isFilter));
    }

    if ((invoice.assignedUserId ?? '').isNotEmpty) {
      final assignedUser = state.userState.get(invoice.assignedUserId!);
      widgets.add(EntityListTile(
        isFilter: isFilter,
        entity: assignedUser,
      ));
    }

    if ((invoice.recurringId ?? '').isNotEmpty) {
      final recurringInvoice =
          state.recurringInvoiceState.get(invoice.recurringId!);
      widgets.add(EntityListTile(entity: recurringInvoice, isFilter: isFilter));
    } else if (invoice.isRecurring) {
      widgets.add(EntitiesListTile(
        entity: invoice,
        isFilter: isFilter,
        hideNew: true,
        entityType: EntityType.invoice,
        title: localization.invoices,
        subtitle: memoizedRecurringInvoiceStatsForInvoice(
                invoice.id, state.invoiceState.map)
            .present(localization.active, localization.archived),
      ));
    }

    final relatedInvoice = state.invoiceState.map[invoice.invoiceId] ??
        InvoiceEntity(id: invoice.invoiceId);
    if ((invoice.invoiceId ?? '').isNotEmpty) {
      widgets.add(EntityListTile(
        isFilter: isFilter,
        entity: relatedInvoice,
      ));
    }

    if (invoice.isInvoice) {
      final relatedQuote =
          memoizedInvoiceQuoteSelector(invoice, state.quoteState.map);
      if (relatedQuote != null) {
        widgets.add(EntityListTile(
          isFilter: isFilter,
          entity: relatedQuote,
        ));
      }
    }

    if (paymentMap.isNotEmpty) {
      paymentMap.entries.forEach((entry) {
        final payment = entry.value!;
        final paymentable = entry.key;
        String amount = formatNumber(
          paymentable.amount,
          context,
          clientId: invoice.isPurchaseOrder ? null : client!.id,
          vendorId: invoice.isPurchaseOrder ? invoice.vendorId : null,
        )!;
        if (paymentable.amount != payment.amount) {
          amount += '/' +
              formatNumber(
                payment.amount,
                context,
                clientId: invoice.isPurchaseOrder ? null : client!.id,
                vendorId: invoice.isPurchaseOrder ? invoice.vendorId : null,
              )!;
        }

        widgets.add(
          EntityListTile(
            isFilter: isFilter,
            entity: payment,
            subtitle: amount + ' • ' + formatDate(payment.date, context),
          ),
        );
      });
    }

    if (creditMap.isNotEmpty) {
      creditMap.entries.forEach((entry) {
        final credit = entry.value!;
        final paymentable = entry.key;
        String amount = formatNumber(
          paymentable.amount,
          context,
          clientId: invoice.isPurchaseOrder ? null : client!.id,
          vendorId: invoice.isPurchaseOrder ? invoice.vendorId : null,
        )!;
        if (paymentable.amount != credit.amount) {
          amount += '/' +
              formatNumber(
                credit.amount,
                context,
                clientId: invoice.isPurchaseOrder ? null : client!.id,
                vendorId: invoice.isPurchaseOrder ? invoice.vendorId : null,
              )!;
        }

        widgets.add(
          EntityListTile(
            isFilter: isFilter,
            entity: credit,
            subtitle: amount + ' • ' + formatDate(credit.date, context),
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

    if (invoice.lineItems.isNotEmpty) {
      invoice.lineItems.forEach((invoiceItem) {
        widgets.addAll([
          Builder(
            builder: (BuildContext context) {
              return InvoiceItemListTile(
                invoice: invoice,
                invoiceItem: invoiceItem,
                onTap: () => userCompany.canEditEntity(invoice)
                    ? viewModel.onEditPressed!(
                        context, invoice.lineItems.indexOf(invoiceItem))
                    : null,
              );
            },
          ),
        ]);
      });
    }

    Widget surchargeRow(String label, double amount) {
      return Container(
        color: Theme.of(context).cardColor,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 10, right: 56, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                width: 100.0,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    formatNumber(
                      amount,
                      context,
                      clientId:
                          invoice.isPurchaseOrder ? null : invoice.clientId,
                      vendorId:
                          invoice.isPurchaseOrder ? invoice.vendorId : null,
                    )!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    widgets.addAll([
      SizedBox(height: 8),
      surchargeRow(
          localization.subtotal,
          invoice.calculateSubtotal(
              precision: precisionForInvoice(state, invoice))),
    ]);

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
    if (invoice.customSurcharge3 != 0 && company.enableCustomSurchargeTaxes3) {
      widgets.add(surchargeRow(
          company.getCustomFieldLabel(CustomFieldType.surcharge3),
          invoice.customSurcharge3));
    }
    if (invoice.customSurcharge4 != 0 && company.enableCustomSurchargeTaxes4) {
      widgets.add(surchargeRow(
          company.getCustomFieldLabel(CustomFieldType.surcharge4),
          invoice.customSurcharge4));
    }

    invoice
        .calculateTaxes(
            useInclusiveTaxes: invoice.usesInclusiveTaxes,
            precision: precisionForInvoice(state, invoice))
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

    if (!invoice.isQuote)
      widgets.add(surchargeRow(localization.paidToDate, invoice.paidToDate));

    if (invoice.isQuote || !invoice.isSent)
      widgets.add(surchargeRow(localization.amount, invoice.amount));
    else
      widgets.add(surchargeRow(localization.balanceDue, invoice.balance));

    if (invoice.partial != 0) {
      widgets.add(surchargeRow(localization.partialDue, invoice.partial));
    }

    if (invoice.publicNotes.isNotEmpty) {
      widgets.addAll([
        ListDivider(),
        IconMessage(invoice.publicNotes, copyToClipboard: true),
      ]);
    }

    return ScrollableListView(
      children: widgets,
    );
  }
}
