// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:io' as file;

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/app_text_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/client/client_pdf_vm.dart';
import 'package:invoiceninja_flutter/utils/dates.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

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

  DateRange _dateRange = DateRange.thisQuarter;
  //String _startDate;
  //String _endDate;
  bool _showPayments = true;
  bool _showAging = true;

  @override
  void initState() {
    super.initState();

    //final state = widget.viewModel.state;
    //final settings = state.dashboardUIState.settings;
    //_dateRange = settings.dateRange;
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

    _loadPDF().then((response) {
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

  Future<Response> _loadPDF() async {
    final client = widget.viewModel.client;
    http.Response response;

    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    final url = '${state.credentials.url}/client_statement';
    final webClient = WebClient();

    String startDate = '';
    String endDate = '';
    if (_dateRange != null) {
      startDate =
          calculateStartDate(company: state.company, dateRange: _dateRange);
      endDate = calculateEndDate(company: state.company, dateRange: _dateRange);
    }

    response = await webClient.post(
      url,
      state.credentials.token,
      data: json.encode({
        'client_id': client.id,
        'start_date': kIsWeb ? '2021-01-01' : startDate,
        'end_date': kIsWeb ? '2023-01-01' : endDate,
        'show_payments_table': _showPayments,
        'show_aging_table': _showAging,
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

    final showPayments = Theme(
      data: ThemeData(
        unselectedWidgetColor: state.headerTextColor,
      ),
      child: Flexible(
        child: CheckboxListTile(
          title: Text(
            localization.payments,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: state.headerTextColor,
            ),
          ),
          value: _showPayments,
          onChanged: (value) {
            setState(() {
              _showPayments = !_showPayments;
              loadPdf();
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: state.accentColor,
        ),
      ),
    );

    final showAging = Theme(
      data: ThemeData(
        unselectedWidgetColor: state.headerTextColor,
      ),
      child: Flexible(
        child: CheckboxListTile(
          title: Text(
            localization.aging,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: state.headerTextColor,
            ),
          ),
          value: _showAging,
          onChanged: (value) {
            setState(() {
              _showAging = !_showAging;
              loadPdf();
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: state.accentColor,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: widget.showAppBar
          ? AppBar(
              centerTitle: false,
              automaticallyImplyLeading: isMobile(context),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /*
                  Expanded(
                    child: Text(
                      EntityPresenter().initialize(client, context).title(),
                    ),
                  ),
                  */
                  if (!kIsWeb)
                    Flexible(
                      child: AppDropdownButton<DateRange>(
                        labelText: localization.dateRange,
                        blankValue: null,
                        //showBlank: true,
                        value: _dateRange,
                        onChanged: (dynamic value) {
                          setState(() {
                            _dateRange = value;
                          });
                          loadPdf();
                        },
                        items: DateRange.values
                            .where((dateRange) => dateRange != DateRange.custom)
                            .map((dateRange) => DropdownMenuItem<DateRange>(
                                  child: Text(localization
                                      .lookup(dateRange.toString())),
                                  value: dateRange,
                                ))
                            .toList(),
                      ),
                    ),
                  if (isDesktop(context)) ...[
                    showPayments,
                    showAging,
                    ...pageSelector,
                  ]
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
                            await Share.shareFiles([filePath]);
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
      body: _isLoading || _response == null
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
                      setState(
                        () {
                          _pageNumber = page;
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
