import 'dart:async';
import 'dart:convert';
import 'dart:io' as file;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:flutter/foundation.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

Future<Null> viewPdf(InvoiceEntity invoice, BuildContext context,
    {String activityId}) async {
  showDialog<Scaffold>(
      context: context,
      builder: (BuildContext context) {
        return PDFScaffold(
          invoice: invoice,
          activityId: activityId,
        );
      });
}

class PDFScaffold extends StatefulWidget {
  const PDFScaffold({@required this.invoice, this.activityId});

  final InvoiceEntity invoice;
  final String activityId;

  @override
  _PDFScaffoldState createState() => _PDFScaffoldState();
}

class _PDFScaffoldState extends State<PDFScaffold> {
  String _pdfString;
  http.Response _response;
  PdfController _pdfController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _loadPDF(context, widget.invoice, widget.activityId).then((response) {
      setState(() {
        _response = response;
      });

      if (kIsWeb) {
        _pdfString =
            'data:application/pdf;base64,' + base64Encode(response.bodyBytes);
        WebUtils.registerWebView(_pdfString);
      } else {
        final document = PdfDocument.openData(_response.bodyBytes);
        if (_pdfController == null) {
          _pdfController = PdfController(document: document);
        } else {
          _pdfController.loadDocument(document);
        }
      }
    });
  }

  @override
  void dispose() {
    //_pdfController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final localization = AppLocalization.of(context);
    final invoice = widget.invoice;

    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(localization.invoice + ' ' + (invoice.number ?? '')),
          actions: <Widget>[
            FlatButton(
              child: Text(
                localization.download,
                style: TextStyle(color: store.state.headerTextColor),
              ),
              onPressed: _response == null
                  ? null
                  : () async {
                      if (kIsWeb) {
                        launch(invoice.invitationDownloadLink,
                            forceSafariVC: false, forceWebView: false);
                      } else {
                        final directory = await getExternalStorageDirectory();
                        final filePath =
                            '${directory.path}/${invoice.invoiceId}.pdf';
                        final pdfData = file.File(filePath);
                        pdfData.writeAsBytes(_response.bodyBytes);
                        await FlutterShare.shareFile(
                            title: 'test.pdf', filePath: filePath);
                      }
                    },
            ),
          ],
        ),
        body: _pdfString == null && _pdfController == null
            ? LoadingIndicator()
            : kIsWeb
                ? HtmlElementView(viewType: _pdfString)
                : PdfView(
                    controller: _pdfController,
                    scrollDirection:
                        isMobile(context) ? Axis.vertical : Axis.horizontal,
                  ));
  }
}

Future<Response> _loadPDF(
    BuildContext context, InvoiceEntity invoice, String activityId) async {
  http.Response response;

  if (activityId != null) {
    final store = StoreProvider.of<AppState>(context);
    final credential = store.state.credentials;
    response = await WebClient().get(
        '${credential.url}/activities/download_entity/$activityId',
        credential.token,
        rawResponse: true);
  } else {
    final invitation = invoice.invitations.first;
    final url = invitation.downloadLink;
    response = await http.Client().get(url);
  }

  if (response.statusCode >= 400) {
    showErrorDialog(
        context: context,
        message: '${response.statusCode}: ${response.reasonPhrase}');
    return null;
  }

  return response;
}
