import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';

String getMapURL(BuildContext context) {
  final bool iOS = Theme.of(context).platform == TargetPlatform.iOS;
  return iOS
      ? 'http://maps.apple.com/?address='
      : 'https://maps.google.com/?q=';
}

String getPlatform(BuildContext context) =>
    Theme.of(context).platform == TargetPlatform.iOS ? 'ios' : 'android';

bool getInvoiceWebViewEnabled(BuildContext context) =>
    Theme.of(context).platform == TargetPlatform.iOS;

String getInvoicePdfUrl(InvoiceEntity invoice, BuildContext context) =>
    Theme.of(context).platform == TargetPlatform.iOS
        ? invoice.invitationSilentLink
        : 'https://docs.google.com/viewer?url=' +
            invoice.invitationDownloadLink;
