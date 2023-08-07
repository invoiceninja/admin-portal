// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:io' as file;

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/app_text_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_pdf_vm.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

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
  //int _pageCount = 1;
  //int _currentPage = 1;

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
    final viewModel = widget.viewModel;
    final invoice = viewModel.invoice;
    final state = viewModel.state;

    if (invoice.invitations.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _loadPDF(
      context,
      invoice,
      _isDeliveryNote,
      _activityId,
    ).then((response) async {
      setState(() {
        _response = response;
        _isLoading = false;

        if (kIsWeb && state.prefState.enableNativeBrowser) {
          _pdfString =
              'data:application/pdf;base64,' + base64Encode(response.bodyBytes);
          WebUtils.registerWebView(_pdfString);
        }
      });
    }).catchError((Object error) {
      setState(() {
        _isLoading = false;
      });

      showDialog<void>(
          context: navigatorKey.currentContext,
          builder: (BuildContext context) {
            return ErrorDialog(error);
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context);
    final invoice = widget.viewModel.invoice;
    final client = state.clientState.get(invoice.clientId);

    /*
    final pageSelector = _pageCount == 1
        ? <Widget>[]
        : [
            IconButton(
              icon: Icon(Icons.navigate_before),
              onPressed: _currentPage > 1 ? () => null : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(localization.pdfPageInfo
                  .replaceFirst(':current', '$_currentPage')
                  .replaceFirst(':total', '$_pageCount')),
            ),
            IconButton(
              icon: Icon(Icons.navigate_next),
              onPressed: _currentPage < _pageCount ? () => null : null,
            ),
          ];
    */

    final activitySelector = _activityId == null || kIsWeb
        ? <Widget>[]
        : [
            Theme(
              data: state.prefState.enableDarkMode || state.hasAccentColor
                  ? ThemeData.dark()
                  : ThemeData.light(),
              child: Flexible(
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
        backgroundColor: Colors.grey.shade300,
        appBar: widget.showAppBar
            ? AppBar(
                centerTitle: false,
                automaticallyImplyLeading: isMobile(context),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(EntityPresenter()
                          .initialize(invoice, context)
                          .title()),
                    ),
                    if (isDesktop(context)) ...activitySelector,
                    //if (isDesktop(context)) ...pageSelector,
                    if (isDesktop(context) &&
                        invoice.isInvoice &&
                        _activityId == null)
                      deliveryNote,
                  ],
                ),
                actions: <Widget>[
                  if (showEmail)
                    TextButton(
                      child: Text(localization.email,
                          style: TextStyle(color: state.headerTextColor)),
                      onPressed: () {
                        handleEntityAction(invoice, EntityAction.sendEmail);
                      },
                    ),
                  if (!invoice.isRecurring)
                    AppTextButton(
                      isInHeader: true,
                      label: localization.download,
                      onPressed: _response == null
                          ? null
                          : () async {
                              if (_response == null) {
                                launchUrl(
                                    Uri.parse(invoice.invitationDownloadLink));
                              } else {
                                final fileName = localization
                                        .lookup('${invoice.entityType}') +
                                    '_' +
                                    (invoice.number.isEmpty
                                        ? localization.pending
                                        : invoice.number) +
                                    '.pdf';
                                if (kIsWeb) {
                                  WebUtils.downloadBinaryFile(
                                      fileName, _response.bodyBytes);
                                } else {
                                  final directory = await (isDesktopOS()
                                      ? getDownloadsDirectory()
                                      : getApplicationDocumentsDirectory());
                                  String filePath =
                                      '${directory.path}${file.Platform.pathSeparator}$fileName';

                                  if (file.File(filePath).existsSync()) {
                                    final timestamp =
                                        DateTime.now().millisecondsSinceEpoch;
                                    filePath = filePath.replaceFirst(
                                        '.pdf', '_$timestamp.pdf');
                                  }

                                  final pdfData = file.File(filePath);
                                  await pdfData
                                      .writeAsBytes(_response.bodyBytes);

                                  if (isDesktopOS()) {
                                    showToast(localization.fileSavedInPath
                                        .replaceFirst(':path', directory.path));
                                  } else {
                                    await Share.shareXFiles([XFile(filePath)]);
                                  }
                                }
                              }
                            },
                    ),
                  if (isDesktop(context))
                    TextButton(
                      child: Text(localization.close,
                          style: TextStyle(color: state.headerTextColor)),
                      onPressed: () {
                        viewEntity(entity: invoice);
                      },
                    ),
                ],
              )
            : null,
        body: _isLoading || _response == null
            ? LoadingIndicator()
            : (kIsWeb && state.prefState.enableNativeBrowser)
                ? HtmlElementView(viewType: _pdfString)
                : PdfPreview(
                    build: (format) => _response.bodyBytes,
                    canChangeOrientation: false,
                    canChangePageFormat: false,
                    canDebug: false,
                    maxPageWidth: 800,
                    pdfFileName:
                        localization.lookup(invoice.entityType.snakeCase) +
                            '_' +
                            invoice.number +
                            '.pdf',
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

  if ((activityId ?? '').isNotEmpty || isDeliveryNote) {
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
    response = await WebClient().get(url, '', rawResponse: true);
  }

  if (response.statusCode >= 400) {
    String errorMessage =
        '${response.statusCode}: ${response.reasonPhrase}\n\n';

    try {
      errorMessage += jsonDecode(response.body)['message'];
    } catch (error) {
      errorMessage += response.body;
    }

    showErrorDialog(message: errorMessage);
    throw errorMessage;
  }

  return response;
}
