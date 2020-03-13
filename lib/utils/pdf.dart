import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:flutter/foundation.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

Future<Null> viewPdf(InvoiceEntity invoice, BuildContext context) async {
  /*
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
  */

  showDialog<Scaffold>(
      context: context,
      builder: (BuildContext context) {
        return PDFScaffold(
          invoice: invoice,
        );
      });
}

class PDFScaffold extends StatefulWidget {
  const PDFScaffold({this.invoice});

  final InvoiceEntity invoice;

  @override
  _PDFScaffoldState createState() => _PDFScaffoldState();
}

class _PDFScaffoldState extends State<PDFScaffold> {
  String _pdfString;
  List<PDFPageImage> _pdfImages;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      renderWebPDF(context, widget.invoice).then((value) => setState(() {
            _pdfString = value;
            registerWebView(_pdfString);
          }));
    } else {
      renderMobilePDF(context, widget.invoice)
          .then((value) => setState(() => _pdfImages = value));
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final invoice = widget.invoice;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
      body: kIsWeb
          ? _pdfString == null
              ? LoadingIndicator()
              : _pdfString == ''
                  ? SizedBox()
                  : HtmlElementView(viewType: _pdfString)
          : _pdfImages == null
              ? LoadingIndicator()
              : _pdfImages.isEmpty
                  ? SizedBox()
                  : Container(
                      color: Colors.grey,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: _pdfImages.length == 1
                          ? Center(
                              child: Container(
                                color: Colors.white,
                                child: Image(
                                    image: MemoryImage(_pdfImages.first.bytes),
                                    height: double.infinity),
                              ),
                            )
                          : ListView(
                              scrollDirection: Axis.horizontal,
                              children: _pdfImages
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
                            ),
                    ),
    );
  }
}

Future<Response> _loadPDF(BuildContext context, InvoiceEntity invoice) async {
  final invitation = invoice.invitations.first;
  final url = invitation.downloadLink;
  final http.Response response = await http.Client().get(url);

  if (response.statusCode >= 400) {
    showErrorDialog(context: context, message: '${response.statusCode}: ${response.reasonPhrase}');
  }
  
  return response;
}

Future<String> renderWebPDF(BuildContext context, InvoiceEntity invoice) async {
  final response = await _loadPDF(context, invoice);

  if (response == null) {
    return '';
  }

  return 'data:application/pdf;base64,' + base64Encode(response.bodyBytes);
}

Future<List<PDFPageImage>> renderMobilePDF(
    BuildContext context, InvoiceEntity invoice) async {
  final response = await _loadPDF(context, invoice);

  debugPrint('data:application/pdf;base64,' + base64Encode(response.bodyBytes));

  final List<PDFPageImage> pages = [];

  if (response == null) {
    return pages;
  }

  final document = await PDFDocument.openData(response.bodyBytes);

  for (var i = 1; i <= document.pagesCount; i++) {
    final page = await document.getPage(i);
    final pageImage = await page.render(width: page.width, height: page.height);
    pages.add(pageImage);
    page.close();
  }

  print('returning pages: ${pages.length}');
  return pages;
}
