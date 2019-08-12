import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';

Future<Null> viewPdf(InvoiceEntity invoice, BuildContext context) async {
  showDialog<Scaffold>(
      context: context,
      builder: (BuildContext context) {
        final localization = AppLocalization.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(invoice.isQuote
                ? localization.quote
                : localization.invoice + ' ' + invoice.invoiceNumber),
            actions: <Widget>[
              FlatButton(
                child: Text(localization.download),
                onPressed: () {
                  launch(invoice.invitationDownloadLink,
                      forceSafariVC: false, forceWebView: false);
                },
              ),
            ],
          ),
          body: FutureBuilder(
              future: createFileOfPdfUrl(invoice.invitationDownloadLink),
              builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return LoadingIndicator();
                  case ConnectionState.done:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else
                      return PDFView(filePath: snapshot.data.path);
                }
                return null; // unreachable
              }),
        );
      });
}

Future<File> createFileOfPdfUrl(String url) async {
  final filename = url.substring(url.lastIndexOf('/') + 1);
  final request = await HttpClient().getUrl(Uri.parse(url));
  final response = await request.close();
  final bytes = await consolidateHttpClientResponseBytes(response);
  final dir = (await getApplicationDocumentsDirectory()).path;
  final file = new File('$dir/$filename');
  await file.writeAsBytes(bytes);
  return file;
}
