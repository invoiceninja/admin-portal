import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

String processTemplate(
    String template, InvoiceEntity invoice, BuildContext context) {
  if (template == null) {
    return '';
  }

  final state = StoreProvider.of<AppState>(context).state;
  final localization = AppLocalization.of(context);
  final company = state.selectedCompany;
  final client = state.clientState.map[invoice.clientId] ??
      ClientEntity(id: invoice.clientId);
  final contact = client.contacts.first;

  final String sampleButton = '[${localization.button}]';
  const String sampleLink = 'https://example.com/...';

  template = template
      .replaceAll('\$footer', company.emailFooter)
      .replaceAll('\$emailSignature', company.emailFooter)
      .replaceAll('\$client', client.displayName)
      .replaceAll('\$idNumber', client.idNumber)
      .replaceAll('\$vatNumber', client.vatNumber)
      .replaceAll('\$account', company.name)
      .replaceAll('\$dueDate', formatDate(invoice.dueDate, context))
      .replaceAll('\$invoiceDate', formatDate(invoice.invoiceDate, context))
      .replaceAll('\$contact', contact.fullName)
      .replaceAll('\$firstName', contact.firstName)
      .replaceAll('\$amount', formatNumber(invoice.requestedAmount, context))
      .replaceAll('\$total', formatNumber(invoice.amount, context))
      .replaceAll('\$balance', formatNumber(invoice.balance, context))
      .replaceAll('\$invoice', invoice.invoiceNumber)
      .replaceAll('\$quote', invoice.invoiceNumber)
      .replaceAll('\$number', invoice.invoiceNumber)
      .replaceAll('\$partial', formatNumber(invoice.partial, context))
      .replaceAll('\$link', sampleLink)
      .replaceAll('\$password', '${localization.password}: ###########')
      .replaceAll('\$viewLink', sampleLink)
      .replaceAll('\$viewButton', sampleButton)
      .replaceAll('\$paymentLink', sampleLink)
      .replaceAll('\$paymentButton', sampleButton)
      .replaceAll('\$approveLink', sampleLink)
      .replaceAll('\$approveButton', sampleButton)
      .replaceAll('\$customClient1', client.customValue1)
      .replaceAll('\$customClient2', client.customValue2)
      .replaceAll('\$customContact1', contact.customValue1)
      .replaceAll('\$customContact2', contact.customValue2)
      .replaceAll('\$customInvoice1', invoice.customTextValue1)
      .replaceAll('\$customInvoice2', invoice.customTextValue2)
      .replaceAll('\$documents', '${localization.documents}: ...')
      .replaceAll('\$autoBill', '${localization.autoBilling}: ...')
      .replaceAll('\$portalLink', sampleLink)
      .replaceAll('\$portalButton', sampleButton);

  [
    'creidtCard',
    'bankTransfer',
    'paypal',
    'sofort',
    'sepa',
    'gocardless',
    'applePay',
    'custom1',
    'custom2',
    'custom3'
  ].forEach((gatewayType) {
    template = template
        .replaceAll('\$${gatewayType}Link', sampleLink)
        .replaceAll('\$${gatewayType}Button', sampleButton);
  });

  return template;
}
