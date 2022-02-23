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
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
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
  bool _isLoading = false;
  http.Response _response;
  PdfController _pdfController;
  int _pageNumber = 1, _pageCount = 1;

  static const STATUS_ALL = 'all';
  static const STATUS_PAID = 'paid';
  static const STATUS_UNPAID = 'unpaid';

  DateRange _dateRange = DateRange.thisQuarter;
  String _startDate =
      convertDateTimeToSqlDate(DateTime.now().subtract(Duration(days: 365)));
  String _endDate = convertDateTimeToSqlDate();
  String _status = STATUS_ALL;
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
    if (_isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _loadPDF().then((response) {
      setState(() {
        _response = response;
        _isLoading = false;
      });

      final document = PdfDocument.openData(_response.bodyBytes);
      if (_pdfController == null) {
        _pdfController = PdfController(document: document);
      } else {
        // loadDocument is causing an error
        //_pdfController.loadDocument(document);
        _pdfController?.dispose();
        _pdfController = PdfController(document: document);
      }
    }).catchError((Object error) {
      setState(() {
        _isLoading = false;
      });
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
      startDate = calculateStartDate(
          company: state.company,
          dateRange: _dateRange,
          customStartDate: _startDate,
          customEndDate: _endDate);
      endDate = calculateEndDate(
          company: state.company,
          dateRange: _dateRange,
          customStartDate: _startDate,
          customEndDate: _endDate);
    }

    if (_dateRange != DateRange.custom) {
      _startDate = startDate;
      _endDate = endDate;
    }

    final data = json.encode({
      'client_id': client.id,
      'start_date': startDate,
      'end_date': endDate,
      'show_payments_table': _showPayments,
      'show_aging_table': _showAging,
      'status': _status,
    });

    print('## DATA: $data');

    response = await webClient.post(
      url,
      state.credentials.token,
      data: data,
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
                  Flexible(
                    child: Theme(
                      data:
                          state.prefState.enableDarkMode || state.hasAccentColor
                              ? ThemeData.dark()
                              : ThemeData.light(),
                      child: AppDropdownButton<DateRange>(
                        labelText: localization.dateRange,
                        blankValue: null,
                        //showBlank: true,
                        value: _dateRange,
                        onChanged: (dynamic value) {
                          setState(() {
                            _dateRange = value;
                          });

                          if (value != DateRange.custom) {
                            loadPdf();
                          }
                        },
                        items: DateRange.values
                            .map((dateRange) => DropdownMenuItem<DateRange>(
                                  child: Text(localization
                                      .lookup(dateRange.toString())),
                                  value: dateRange,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    child: Theme(
                      data:
                          state.prefState.enableDarkMode || state.hasAccentColor
                              ? ThemeData.dark()
                              : ThemeData.light(),
                      child: AppDropdownButton<String>(
                          labelText: localization.status,
                          blankValue: null,
                          value: _status,
                          onChanged: (dynamic value) {
                            setState(() {
                              _status = value;
                            });
                            loadPdf();
                          },
                          items: [
                            STATUS_ALL,
                            STATUS_PAID,
                            STATUS_UNPAID,
                          ]
                              .map((value) => DropdownMenuItem<String>(
                                    child: Text(localization.lookup(value)),
                                    value: value,
                                  ))
                              .toList()),
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
                            await pdfData.writeAsBytes(_response.bodyBytes);

                            if (isDesktopOS()) {
                              showToast(
                                  localization.fileSavedInDownloadsFolder);
                            } else {
                              await Share.shareFiles([filePath]);
                            }
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
      body: Column(
        children: [
          if (_dateRange == DateRange.custom)
            Container(
              width: double.infinity,
              color: Theme.of(context).backgroundColor,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Container(
                    width: 180,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: DatePicker(
                      labelText: localization.startDate,
                      onSelected: (value, _) {
                        setState(() {
                          _startDate = value;
                        });
                      },
                      selectedDate: _startDate,
                    ),
                  ),
                  Container(
                    width: 180,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: DatePicker(
                      labelText: localization.endDate,
                      onSelected: (value, _) {
                        setState(() {
                          _endDate = value;
                        });
                      },
                      selectedDate: _endDate,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppButton(
                      label: localization.loadPdf,
                      onPressed: () => loadPdf(),
                    ),
                  )
                ],
              ),
            ),
          Expanded(
            child: _isLoading || _response == null
                ? LoadingIndicator()
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
          ),
        ],
      ),
    );
  }
}
