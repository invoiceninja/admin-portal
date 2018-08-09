import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:http/http.dart' as http;
import 'package:invoiceninja_flutter/ui/app/dialogs/loading_dialog.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';

Future<Null> viewPdf(InvoiceEntity invoice, BuildContext context) async {
  final localization = AppLocalization.of(context);
  final navigator = Navigator.of(context);
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    if (await canLaunch(invoice.invitationSilentLink)) {
      await launch(invoice.invitationSilentLink,
          forceSafariVC: true, forceWebView: true);
    } else {
      throw localization.anErrorOccurred;
    }
  } else {
    showDialog<SimpleDialog>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(children: <Widget>[
            LoadingDialog(),
          ]),
    );
    final http.Response response = await http.Client().get(
          invoice.invitationDownloadLink + '?base64=true',
        );
    navigator.pop();
    FlutterPdfViewer.loadBytes(base64Decode(response.body.substring(28)));
  }
}
