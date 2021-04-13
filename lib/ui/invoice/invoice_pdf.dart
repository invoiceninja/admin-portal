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
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/app_text_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_pdf_vm.dart';

class InvoicePdfView extends StatefulWidget {
  const InvoicePdfView({
    Key key,
    @required this.viewModel,
    this.showAppBar = true,
  }) : super(key: key);

  final EntityPdfVM viewModel;
  final bool showAppBar;

  @override
  _InvoicePdfViewState createState() => _InvoicePdfViewState();
}

class _InvoicePdfViewState extends State<InvoicePdfView> {
  bool _isLoading = true;
  bool _isDeliveryNote = false;
  String _activityId;
  String _pdfString;
  http.Response _response;
  PdfController _pdfController;
  int _pageNumber = 1, _pageCount = 1;

  @override
  void initState() {
    super.initState();

    _activityId = widget.viewModel.activityId;
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

    _loadPDF(
      context,
      widget.viewModel.invoice,
      _isDeliveryNote,
      _activityId,
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
    final invoice = widget.viewModel.invoice;
    final client = state.clientState.get(invoice.clientId);

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

    final activitySelector = _activityId == null || kIsWeb
        ? <Widget>[]
        : [
            Flexible(
              child: IgnorePointer(
                ignoring: _isLoading,
                child: AppDropdownButton<String>(
                    value: _activityId,
                    onChanged: (dynamic activityId) {
                      setState(() {
                        _activityId = activityId;
                        loadPdf();
                      });
                    },
                    items: invoice.history
                        .map((history) => DropdownMenuItem(
                              child: Text(formatNumber(history.amount, context,
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
          ];

    final deliveryNote = Theme(
      data: ThemeData(
        unselectedWidgetColor: state.headerTextColor,
      ),
      child: Container(
        width: 200,
        child: CheckboxListTile(
          title: Text(
            localization.deliveryNote,
            style: TextStyle(
              color: state.headerTextColor,
            ),
          ),
          value: _isDeliveryNote,
          onChanged: (value) {
            setState(() {
              _isDeliveryNote = !_isDeliveryNote;
              loadPdf();
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: state.accentColor,
        ),
      ),
    );

    bool showEmail =
        isDesktop(context) && _activityId == null && !invoice.isRecurring;

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
                      child: Text(
                          EntityPresenter().initialize(invoice, context).title),
                    ),
                    if (isDesktop(context)) ...activitySelector,
                    if (isDesktop(context)) ...pageSelector,
                    if (isDesktop(context) && _activityId == null) deliveryNote,
                  ],
                ),
                actions: <Widget>[
                  if (showEmail)
                    TextButton(
                      child: Text(localization.email,
                          style: TextStyle(color: state.headerTextColor)),
                      onPressed: () {
                        handleEntityAction(context.getAppContext(), invoice,
                            EntityAction.emailEntityType(invoice.entityType));
                      },
                    ),
                  AppTextButton(
                    isInHeader: true,
                    label: localization.download,
                    onPressed: _response == null
                        ? null
                        : () async {
                            final fileName =
                                localization.lookup('${invoice.entityType}') +
                                    '_' +
                                    (invoice.number.isEmpty
                                        ? localization.pending
                                        : invoice.number) +
                                    '.pdf';
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
                  if (isDesktop(context))
                    TextButton(
                      child: Text(localization.close,
                          style: TextStyle(color: state.headerTextColor)),
                      onPressed: () {
                        viewEntity(
                            appContext: context.getAppContext(),
                            entity: invoice);
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
  InvoiceEntity invoice,
  bool isDeliveryNote,
  String activityId,
) async {
  http.Response response;

  if (activityId != null || isDeliveryNote) {
    final store = StoreProvider.of<AppState>(context);
    final credential = store.state.credentials;
    final url = isDeliveryNote
        ? '/invoices/${invoice.id}/delivery_note'
        : '/activities/download_entity/$activityId';
    response = await WebClient()
        .get('${credential.url}$url', credential.token, rawResponse: true);
  } else {
    final invitation = invoice.invitations.first;
    final url = invitation.downloadLink;
    response = await http.Client().get(url);
  }

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
