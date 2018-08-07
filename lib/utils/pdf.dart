import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:http/http.dart' as http;
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';

Future<Null> viewPdf(InvoiceEntity invoice, BuildContext context) async {
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    if (await canLaunch(invoice.invitationSilentLink)) {
      await launch(invoice.invitationSilentLink, forceSafariVC: true, forceWebView: true);
    } else {
      throw AppLocalization.of(context).anErrorOccurred;
    }
  } else {
    final http.Response response = await http.Client().get(
      invoice.invitationDownloadLink + '?base64=true',
    );
    FlutterPdfViewer.loadBytes(base64Decode(response.body.substring(28)));
  }
}

