import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:flutter/foundation.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

Future<Null> viewPdf(InvoiceEntity invoice, BuildContext context) async {
  final localization = AppLocalization.of(context);

  /*
  if (Platform.isIOS) {
    if (await canLaunch(invoice.invitationBorderlessLink)) {
      await launch(invoice.invitationBorderlessLink,
          forceSafariVC: true, forceWebView: true);
    } else {
      throw localization.anErrorOccurred;
    }

    return;
  }
  */

  showDialog<Scaffold>(
      context: context,
      builder: (BuildContext context) {
        final localization = AppLocalization.of(context);

        if (kIsWeb) {
          //registerWebView(widget.html);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(localization.invoice + ' ' + (invoice.number ?? '')),
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
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: kIsWeb
                ? FutureBuilder(
                    future: renderWebPDF(context, invoice),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return LoadingIndicator();
                        case ConnectionState.done:
                          if (snapshot.hasError)
                            return Text(
                                '${getPdfRequirements(context)} - Error: ${snapshot.error}');
                          else
                            return Text('done');
                      }
                      return null;
                    })
                : FutureBuilder(
                    future: renderMobilePDF(context, invoice),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<PDFPageImage>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return LoadingIndicator();
                        case ConnectionState.done:
                          if (snapshot.hasError)
                            return Text(
                                '${getPdfRequirements(context)} - Error: ${snapshot.error}');
                          else
                            return snapshot.data.length == 1
                                ? Center(
                                    child: Container(
                                      color: Colors.white,
                                      child: Image(
                                          image: MemoryImage(
                                              snapshot.data.first.bytes),
                                          height: double.infinity),
                                    ),
                                  )
                                : ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: snapshot.data
                                        .map((page) => Row(
                                              children: <Widget>[
                                                Container(
                                                  width: 20,
                                                  height: double.infinity,
                                                  color: Colors.grey,
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child: ExtendedImage.memory(
                                                    page.bytes,
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                ),
                                              ],
                                            ))
                                        .toList(),
                                  );
                      }
                      return null; // unreachable
                    }),
          ),
        );
      });
}

Future<HttpClientResponse> _loadPDF(
    BuildContext context, InvoiceEntity invoice) async {
  final invitation = invoice.invitations.first;
  final url = invitation.downloadLink;
  final request = await HttpClient().getUrl(Uri.parse(url));
  final response = await request.close();

  if (response.statusCode >= 400) {
    showErrorDialog(
        context: context,
        message: '${response.statusCode}: ${response.reasonPhrase}');
    return null;
  }

  return response;
}

Future<String> renderWebPDF(BuildContext context, InvoiceEntity invoice) async {
  final response = await _loadPDF(context, invoice);
  print('Response: $response');

  return 'done';
}

Future<List<PDFPageImage>> renderMobilePDF(
    BuildContext context, InvoiceEntity invoice) async {
  final response = await _loadPDF(context, invoice);
  final bytes = await consolidateHttpClientResponseBytes(response);
  final document = await PDFDocument.openData(bytes);
  final List<PDFPageImage> pages = [];

  for (var i = 1; i <= document.pagesCount; i++) {
    final page = await document.getPage(i);
    final pageImage = await page.render(width: page.width, height: page.height);
    pages.add(pageImage);
    page.close();
  }

  return pages;
}
