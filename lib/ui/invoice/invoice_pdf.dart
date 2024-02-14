// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/utils/files.dart';
import 'package:printing/printing.dart';

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
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class InvoicePdfView extends StatefulWidget {
  const InvoicePdfView({
    Key? key,
    required this.viewModel,
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
  String? _designId;
  String? _activityId;
  http.Response? _response;
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
    final invoice = viewModel.invoice!;

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
      _designId,
    ).then((response) async {
      setState(() {
        _response = response;
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

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context)!;
    final invoice = widget.viewModel.invoice!;
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

    final activityPicker = _activityId == null
        ? SizedBox()
        : Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 17),
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
                    items: invoice.balanceHistory
                        .map((history) => DropdownMenuItem(
                              child: Text(formatNumber(history.amount, context,
                                      clientId: invoice.clientId)! +
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
          );

    /*
    final designPicker = _activityId != null ||
            !hasDesignTemplatesForEntityType(
                state.designState.map, invoice.entityType!)
        ? SizedBox()
        : Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 17),
              child: IgnorePointer(
                ignoring: _isLoading,
                child: DesignPicker(
                  initialValue: _designId,
                  onSelected: (design) {
                    setState(() {
                      _designId = design?.id;
                      loadPdf();
                    });
                  },
                  label: localization.design,
                  showBlank: true,
                  entityType: invoice.entityType,
                ),
              ),
            ),
          );
    */

    final deliveryNote = Flexible(
      child: CheckboxListTile(
        title: Text(
          localization.deliveryNote,
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
              title:
                  Text(EntityPresenter().initialize(invoice, context).title()!),
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
                            final fileName = (invoice.number.isEmpty
                                    ? localization.pending
                                    : invoice.number) +
                                '.pdf';
                            saveDownloadedFile(
                              _response!.bodyBytes,
                              fileName,
                              prefix: invoice.entityType!.apiValue,
                              languageId: client.languageId,
                            );
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
      body: Column(
        children: [
          if (widget.showAppBar)
            Material(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    //if (supportsDesignTemplates()) designPicker,
                    activityPicker,
                    if (invoice.isInvoice && _activityId == null) deliveryNote,
                  ],
                ),
              ),
            ),
          Expanded(
            child: _isLoading || _response == null
                ? LoadingIndicator()
                : PdfPreview(
                    build: (format) => _response!.bodyBytes,
                    canChangeOrientation: false,
                    canChangePageFormat: false,
                    canDebug: false,
                    maxPageWidth: 800,
                    pdfFileName:
                        localization.lookup(invoice.entityType!.snakeCase) +
                            '_' +
                            invoice.number +
                            '.pdf',
                  ),
          ),
        ],
      ),
    );
  }
}

Future<Response?> _loadPDF(
  BuildContext context,
  InvoiceEntity invoice,
  bool isDeliveryNote,
  String? activityId,
  String? designId,
) async {
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final credentials = store.state.credentials;
  final invitation = invoice.invitations.first;

  var url = '';

  if ((activityId ?? '').isNotEmpty) {
    url = '${credentials.url}/activities/download_entity/$activityId';
  } else {
    if (isDeliveryNote) {
      url = '${credentials.url}/invoices/${invoice.id}/delivery_note';
    } else {
      url = invitation.downloadLink;
    }

    if ((designId ?? '').isNotEmpty) {
      url += '&design_id=$designId';
    }
  }

  return await WebClient().get(url, state.token, rawResponse: true);
}
