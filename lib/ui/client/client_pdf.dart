// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/multiselect.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/files.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:printing/printing.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
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
    Key? key,
    required this.viewModel,
    this.showAppBar = true,
  }) : super(key: key);

  final ClientPdfVM viewModel;
  final bool showAppBar;

  @override
  _ClientPdfViewState createState() => _ClientPdfViewState();
}

class _ClientPdfViewState extends State<ClientPdfView> {
  bool _isLoading = false;
  http.Response? _response;
  //int _pageCount = 1;
  //int _currentPage = 1;

  DateRange _dateRange = DateRange.thisQuarter;
  String? _startDate =
      convertDateTimeToSqlDate(DateTime.now().subtract(Duration(days: 365)));
  String? _endDate = convertDateTimeToSqlDate();
  String _status = kStatementStatusAll;
  String? _pdfString;

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

    loadPDF();
  }

  void loadPDF({bool sendEmail = false}) {
    if (_isLoading) {
      return;
    }

    final localization = AppLocalization.of(context);
    final state = widget.viewModel.state;

    setState(() {
      _isLoading = true;
    });

    _loadPDF(sendEmail: sendEmail).then((response) {
      setState(() {
        if (sendEmail) {
          if (response!.statusCode >= 200) {
            showToast(localization!.emailedStatement);
          }
        } else {
          _response = response;

          if (kIsWeb && state.prefState.enableNativeBrowser) {
            _pdfString = 'data:application/pdf;base64,' +
                base64Encode(response!.bodyBytes);
            WebUtils.registerWebView(_pdfString);
          }
        }

        _isLoading = false;
      });
    }).catchError((Object error) {
      setState(() {
        _isLoading = false;
      });

      showDialog<void>(
          context: navigatorKey.currentContext!,
          builder: (BuildContext context) {
            return ErrorDialog(error);
          });
    });
  }

  Future<Response?> _loadPDF({bool sendEmail = false}) async {
    final client = widget.viewModel.client!;
    http.Response? response;

    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    final webClient = WebClient();
    String url = '${state.credentials.url}/client_statement';
    if (sendEmail) {
      url += '?send_email=true';
    }

    String? startDate = '';
    String? endDate = '';

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

    if (_dateRange != DateRange.custom) {
      _startDate = startDate;
      _endDate = endDate;
    }

    final includes = state.prefState.statementIncludes;
    final data = json.encode({
      'client_id': client.id,
      'start_date': startDate,
      'end_date': endDate,
      'show_payments_table': includes.contains(kStatementIncludePayments),
      'show_credits_table': includes.contains(kStatementIncludeCredits),
      'show_aging_table': includes.contains(kStatementIncludeAging),
      'status': _status,
    });

    response = await webClient.post(
      url,
      state.credentials.token,
      data: data,
      rawResponse: true,
    );

    return response;
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context)!;
    final client = widget.viewModel.client!;

    final datePicker = Flexible(
      child: Theme(
        data: state.prefState.enableDarkMode || state.hasAccentColor
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
              loadPDF();
            }
          },
          items: DateRange.values
              .where((value) => value != DateRange.allTime)
              .map((dateRange) => DropdownMenuItem<DateRange>(
                    child: Text(localization.lookup(dateRange.toString())),
                    value: dateRange,
                  ))
              .toList(),
        ),
      ),
    );

    final statusPicker = Flexible(
      child: Theme(
        data: state.prefState.enableDarkMode || state.hasAccentColor
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
              loadPDF();
            },
            items: [
              kStatementStatusAll,
              kStatementStatusPaid,
              kStatementStatusUnpaid,
            ]
                .map((value) => DropdownMenuItem<String>(
                      child: Text(localization.lookup(value)),
                      value: value,
                    ))
                .toList()),
      ),
    );

    final sectionPicker = Flexible(
        child: DropDownMultiSelect(
      onChanged: (List<dynamic> selected) {
        //_selectedOptions = selected;
        store.dispatch(UpdateUserPreferences(
            statementIncludes: BuiltList<String>(selected)));
        loadPDF();
      },
      selectedValues: state.prefState.statementIncludes.toList(),
      menuItembuilder: (dynamic option) => Text(
        localization.lookup(option),
        style: TextStyle(fontSize: 14),
      ),
      isDense: true,
      options: <String>[
        kStatementIncludePayments,
        kStatementIncludeCredits,
        kStatementIncludeAging,
      ],
      whenEmpty: '',
    ));

    /*
    final pageSelector = _pageCount == 1
        ? <Widget>[]
        : [
            IconButton(
              icon: Icon(Icons.navigate_before),
              onPressed: _currentPage > 1
                  ? () {
                      setState(() {
                        _currentPage++;
                      });
                    }
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(localization.pdfPageInfo
                  .replaceFirst(':current', '$_currentPage')
                  .replaceFirst(':total', '$_pageCount')),
            ),
            IconButton(
              icon: Icon(Icons.navigate_next),
              onPressed: _currentPage < _pageCount
                  ? () {
                      setState(() {
                        _currentPage++;
                      });
                    }
                  : null,
            ),
          ];
    */

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: widget.showAppBar
          ? AppBar(
              centerTitle: false,
              automaticallyImplyLeading: isMobile(context),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      EntityPresenter().initialize(client, context).title()!,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
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
                          saveDownloadedFile(_response!.bodyBytes, fileName);
                        },
                ),
                AppTextButton(
                  isInHeader: true,
                  label: localization.email,
                  onPressed: _response == null
                      ? null
                      : () async {
                          if (!client.hasEmailAddress) {
                            showMessageDialog(
                                message: localization.clientEmailNotSet,
                                secondaryActions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        editEntity(
                                            entity: state.clientState
                                                .get(client.id));
                                      },
                                      child: Text(localization.editClient
                                          .toUpperCase()))
                                ]);
                            return;
                          }

                          confirmCallback(
                              message: localization.sendEmail,
                              context: context,
                              callback: (_) => loadPDF(sendEmail: true));
                        },
                ),
                TextButton(
                    onPressed: () {
                      if (!state.isProPlan) {
                        showMessageDialog(
                            message: localization.upgradeToPaidPlanToSchedule,
                            secondaryActions: [
                              TextButton(
                                  onPressed: () {
                                    store.dispatch(ViewSettings(
                                        section: kSettingsAccountManagement));
                                    Navigator.of(context).pop();
                                  },
                                  child:
                                      Text(localization.upgrade.toUpperCase())),
                            ]);
                        return;
                      }

                      final includes = state.prefState.statementIncludes;
                      createEntity(
                          entity: ScheduleEntity(
                                  ScheduleEntity.TEMPLATE_EMAIL_STATEMENT)
                              .rebuild((b) => b
                                ..parameters.clients.add(client.id)
                                ..parameters.showAgingTable =
                                    includes.contains(localization.aging)
                                ..parameters.showPaymentsTable =
                                    includes.contains(localization.payments)
                                ..parameters.showCreditsTable =
                                    includes.contains(localization.credits)
                                ..parameters.status = _status
                                ..parameters.dateRange = _dateRange.snakeCase));
                    },
                    child: Text(localization.schedule,
                        style: TextStyle(color: state.headerTextColor))),
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
          Material(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: isDesktop(context)
                  ? Row(
                      children: [
                        datePicker,
                        statusPicker,
                        sectionPicker,
                      ],
                    )
                  : Placeholder(),
            ),
          ),
          if (_dateRange == DateRange.custom)
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.background,
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
                      onPressed: () => loadPDF(),
                    ),
                  )
                ],
              ),
            ),
          Expanded(
            child: _isLoading || _response == null
                ? LoadingIndicator()
                : (kIsWeb && state.prefState.enableNativeBrowser)
                    ? HtmlElementView(viewType: _pdfString!)
                    : PdfPreview(
                        build: (format) => _response!.bodyBytes,
                        canChangeOrientation: false,
                        canChangePageFormat: false,
                        canDebug: false,
                        maxPageWidth: 600,
                        pdfFileName: localization.statement +
                            '_' +
                            client.number +
                            '.pdf',
                      ),
          ),
        ],
      ),
    );
  }
}
