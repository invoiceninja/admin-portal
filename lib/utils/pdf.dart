import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:native_pdf_renderer/native_pdf_renderer.dart';

Future<Null> viewPdf(InvoiceEntity invoice, BuildContext context) async {
  final localization = AppLocalization.of(context);
  if (Platform.isIOS) {
    if (await canLaunch(invoice.invitationBorderlessLink)) {
      await launch(invoice.invitationBorderlessLink,
          forceSafariVC: true, forceWebView: true);
    } else {
      throw localization.anErrorOccurred;
    }

    return;
  }

  /*
  showDialog<Scaffold>(
      context: context,
      builder: (BuildContext context) {
        final localization = AppLocalization.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                localization.invoice + ' ' + (invoice.invoiceNumber ?? '')),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  localization.download,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  launch(invoice.invitationDownloadLink,
                      forceSafariVC: false, forceWebView: false);
                },
              ),
            ],
          ),
          body: Container(
            color: Colors.grey,
            padding: const EdgeInsets.all(16),
            child: Center(
              child: FutureBuilder(
                  future: createFileOfPdfUrl(invoice.invitationDownloadLink),
                  builder: (BuildContext context,
                      AsyncSnapshot<PDFPageImage> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return LoadingIndicator();
                      case ConnectionState.done:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        else
                          return Container(
                            color: Colors.white,
                            child: Image(
                              height: double.infinity,
                              image: MemoryImage(snapshot.data.bytes),
                            ),
                          );
                    }
                    return null; // unreachable
                  }),
            ),
          ),
        );
      });
}

Future<PDFPageImage> createFileOfPdfUrl(String url) async {
  //final filename = url.substring(url.lastIndexOf('/') + 1);

  url =
      'https://staging.invoiceninja.com/download/gj5d2udwzowatfsjibarq4eyo4k0cvpd';

  final request = await HttpClient().getUrl(Uri.parse(url));
  final response = await request.close();
  final bytes = await consolidateHttpClientResponseBytes(response);

  final document = await PDFDocument.openData(bytes);
  final page = await document.getPage(1);
  final pageImage = await page.render(width: page.width, height: page.height);
  await page.close();

  return pageImage;
  */

  /*
  final dir = (await getApplicationDocumentsDirectory()).path;
  final file = new File('$dir/$filename');
  await file.writeAsBytes(bytes);
  return file;
   */
}
