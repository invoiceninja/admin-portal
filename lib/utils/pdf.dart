import 'dart:async';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:url_launcher/url_launcher.dart';

Future<Null> viewPdf(InvoiceEntity invoice, BuildContext context) async {
  final localization = AppLocalization.of(context);
  final String url = getInvoicePdfUrl(invoice, context);
  final bool useWebView = getInvoiceWebViewEnabled(context);
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: useWebView, forceWebView: useWebView);
  } else {
    throw '${localization.anErrorOccurred}';
  }
}

