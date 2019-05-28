import 'dart:async';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

Future<Null> viewPdf(InvoiceEntity invoice, BuildContext context) async {

  /*
  final navigator = Navigator.of(context);
  navigator.push(
      MaterialPageRoute<PDFViewer>(builder: (context) => PDFScreen(invoice)));
  */

  final localization = AppLocalization.of(context);
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    if (await canLaunch(invoice.invitationBorderlessLink)) {
      await launch(invoice.invitationBorderlessLink,
          forceSafariVC: true, forceWebView: true);
    } else {
      throw localization.anErrorOccurred;
    }
  } else {
    final String url =
        'https://docs.google.com/viewer?url=' + invoice.invitationDownloadLink;
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw localization.anErrorOccurred;
    }
  }
}

/*
class PDFScreen extends StatefulWidget {
  const PDFScreen(this.invoice);

  final InvoiceEntity invoice;

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  PDFDocument document;

  @override
  void initState() {
    super.initState();

    PDFDocument.fromURL(widget.invoice.invitationDownloadLink).then((doc) {
      setState(() => document = doc);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.invoice.invoiceNumber}'),
      ),
      body: Center(
        child: document == null
            ? CircularProgressIndicator()
            : PDFViewer(
                showPicker: false,
                document: document,
              ),
      ),
    );
  }
}
*/