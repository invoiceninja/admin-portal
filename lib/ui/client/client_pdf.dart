import 'dart:async';
import 'dart:convert';
import 'dart:io' as file;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/app_text_button.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/ui/client/client_pdf_vm.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

class ClientPdfView extends StatefulWidget {
  const ClientPdfView({
    Key key,
    @required this.viewModel,
    this.showAppBar = true,
  }) : super(key: key);

  final ClientPdfVM viewModel;
  final bool showAppBar;

  @override
  _ClientPdfViewState createState() => _ClientPdfViewState();
}

class _ClientPdfViewState extends State<ClientPdfView> {
  bool _isLoading = true;
  String _pdfString;
  http.Response _response;
  PdfController _pdfController;
  int _pageNumber = 1, _pageCount = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadPdf();
  }

  void loadPdf() {
    setState(() {
      _isLoading = true;
    });

    _loadPDF(
      context,
      widget.viewModel.client,
    ).then((response) {
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
    final state = store.state;
    final localization = AppLocalization.of(context);
    final client = widget.viewModel.client;

    final pageSelector = _pageCount == 1
        ? <Widget>[]
        : [
            IconButton(
              icon: Icon(Icons.navigate_before),
              onPressed: _pageNumber > 1
                  ? () => _pdfController.previousPage(
                        duration:
                            Duration(milliseconds: kDefaultAnimationDuration),
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
                        duration:
                            Duration(milliseconds: kDefaultAnimationDuration),
                        curve: Curves.easeInOutCubic,
                      )
                  : null,
            ),
          ];

    bool showEmail = false; //isDesktop(context);

    // TODO: remove this code
    // hide email option on web to prevent dialog problem
    if (kIsWeb && !client.hasEmailAddress) {
      showEmail = false;
    }

    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: widget.showAppBar
            ? AppBar(
                centerTitle: false,
                automaticallyImplyLeading: isMobile(context),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(EntityPresenter()
                          .initialize(client, context)
                          .title()),
                    ),
                    if (isDesktop(context)) ...pageSelector,
                  ],
                ),
                actions: <Widget>[
                  if (showEmail)
                    TextButton(
                      child: Text(localization.email,
                          style: TextStyle(color: state.headerTextColor)),
                      onPressed: () {
                        handleEntityAction(client,
                            EntityAction.emailEntityType(client.entityType));
                      },
                    ),
                  AppTextButton(
                    isInHeader: true,
                    label: localization.download,
                    onPressed: _response == null
                        ? null
                        : () async {
                            final fileName = localization.statement +
                                '_' +
                                (client.number) +
                                '.pdf';
                            if (kIsWeb) {
                              WebUtils.downloadBinaryFile(
                                  fileName, _response.bodyBytes);
                            } else {
                              final directory =
                                  await getExternalStorageDirectory();
                              final filePath =
                                  '${directory.path}/${client.number}.pdf';
                              final pdfData = file.File(filePath);
                              pdfData.writeAsBytes(_response.bodyBytes);
                              await FlutterShare.shareFile(
                                  title: fileName, filePath: filePath);
                            }
                          },
                  ),
                  if (isDesktop(context))
                    TextButton(
                      child: Text(localization.close,
                          style: TextStyle(color: state.headerTextColor)),
                      onPressed: () {
                        viewEntity(entity: client);
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
                          _pageCount = document?.pagesCount ?? 0;
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
  BuildContext context,
  ClientEntity client,
) async {
  http.Response response;

  final store = StoreProvider.of<AppState>(context);
  final state = store.state;

  final url = '${state.credentials.url}/client_statement';
  final webClient = WebClient();

  response = await webClient.post(
    url,
    state.credentials.token,
    data: json.encode({
      'client_id': client.id,
      'start_date': '2020-01-01',
      'end_date': '2030-01-01',
      'show_payments': false,
      'show_aging_table': false,
    }),
    rawResponse: true,
  );

  if (response.statusCode >= 400) {
    String errorMessage =
        '${response.statusCode}: ${response.reasonPhrase}\n\n';

    try {
      errorMessage += jsonDecode(response.body)['message'];
    } catch (error) {
      errorMessage += response.body;
    }

    showErrorDialog(context: context, message: errorMessage);
    throw errorMessage;
  }

  return response;
}
