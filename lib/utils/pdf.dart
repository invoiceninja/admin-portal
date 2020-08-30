import 'dart:async';
import 'dart:convert';
import 'dart:io' as file;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:flutter/foundation.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:path_provider/path_provider.dart';
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
  const PDFScaffold(
      {@required this.invoice, this.activityId, this.showAppBar = true});

  final InvoiceEntity invoice;
  final String activityId;
  final bool showAppBar;

  @override
  _PDFScaffoldState createState() => _PDFScaffoldState();
}

class _PDFScaffoldState extends State<PDFScaffold> {
  bool _isLoading = true;
  String _activityId;
  String _pdfString;
  http.Response _response;
  PdfController _pdfController;
  int _pageNumber = 1, _pageCount = 1;

  @override
  void initState() {
    super.initState();

    _activityId = widget.activityId;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadPdf();
  }

  void loadPdf() {
    setState(() {
      _isLoading = true;
    });

    _loadPDF(context, widget.invoice, _activityId).then((response) {
      setState(() {
        _response = response;
        _isLoading = false;
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
          // loadDocument is causing an error
          //_pdfController.loadDocument(document);
          _pdfController?.dispose();
          _pdfController = PdfController(document: document);
        }
      }
    }).catchError((Object error) {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _pdfController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final localization = AppLocalization.of(context);
    final invoice = widget.invoice;

    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: widget.showAppBar
            ? AppBar(
                centerTitle: false,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Row(
                  children: [
                    Text(localization.invoice + ' ' + (invoice.number ?? '')),
                    if (_activityId != null && isDesktop(context)) ...[
                      Spacer(),
                      Flexible(
                        child: IgnorePointer(
                          ignoring: _isLoading,
                          child: AppDropdownButton<String>(
                              value: widget.activityId,
                              onChanged: (dynamic activityId) {
                                setState(() {
                                  _activityId = activityId;
                                  loadPdf();
                                });
                              },
                              items: invoice.history
                                  .map((history) => DropdownMenuItem(
                                        child: Text(formatNumber(
                                                history.amount, context,
                                                clientId: invoice.clientId) +
                                            ' • ' +
                                            formatDate(
                                                convertTimestampToDateString(
                                                    history.createdAt),
                                                context,
                                                showTime: true)),
                                        value: history.activityId,
                                      ))
                                  .toList()),
                        ),
                      ),
                      Spacer(),
                    ],
                    if (!kIsWeb && _pageCount > 1) ...[
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.navigate_before),
                        onPressed: _pageNumber > 1
                            ? () => _pdfController.previousPage(
                                  duration: Duration(
                                      milliseconds: kDefaultAnimationDuration),
                                  curve: Curves.easeInOutCubic,
                                )
                            : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(localization.pdfPageInfo
                            .replaceFirst(':current', '$_pageNumber')
                            .replaceFirst(':total', '$_pageCount')),
                      ),
                      IconButton(
                        icon: Icon(Icons.navigate_next),
                        onPressed: _pageNumber < _pageCount
                            ? () => _pdfController.nextPage(
                                  duration: Duration(
                                      milliseconds: kDefaultAnimationDuration),
                                  curve: Curves.easeInOutCubic,
                                )
                            : null,
                      ),
                      Spacer(),
                    ]
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      localization.download,
                      style: TextStyle(color: store.state.headerTextColor),
                    ),
                    onPressed: _response == null
                        ? null
                        : () async {
                            final fileName = '${invoice.number}.pdf';
                            if (kIsWeb) {
                              WebUtils.downloadBinaryFile(
                                  fileName, _response.bodyBytes);
                            } else {
                              final directory =
                                  await getExternalStorageDirectory();
                              final filePath =
                                  '${directory.path}/${invoice.invoiceId}.pdf';
                              final pdfData = file.File(filePath);
                              pdfData.writeAsBytes(_response.bodyBytes);
                              await FlutterShare.shareFile(
                                  title: fileName, filePath: filePath);
                            }
                          },
                  ),
                ],
              )
            : null,
        body: _isLoading
            ? LoadingIndicator()
            : kIsWeb
                ? HtmlElementView(viewType: _pdfString)
                : Padding(
                    padding: const EdgeInsets.all(8),
                    child: PdfView(
                      controller: _pdfController,
                      onDocumentLoaded: (document) {
                        setState(() {
                          _pageCount = document.pagesCount;
                        });
                      },
                      onPageChanged: (page) {
                        setState(() {
                          _pageNumber = page;
                        });
                      },
                    ),
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
