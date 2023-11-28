// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:http/http.dart' as http;
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_pdf_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:printing/printing.dart';
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

class InvoiceEditPDF extends StatefulWidget {
  const InvoiceEditPDF({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final EntityEditPDFVM viewModel;

  @override
  InvoiceEditPDFState createState() => InvoiceEditPDFState();
}

class InvoiceEditPDFState extends State<InvoiceEditPDF> {
  bool _isLoading = false;
  String? _pdfString;
  http.Response? _response;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final viewModel = widget.viewModel;
    if (!viewModel.invoice!.hasClient || _isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final invoice = viewModel.invoice!;
    final state = viewModel.state;
    final credentials = state.credentials;
    final webClient = WebClient();

    String url = '';
    if (state.isHosted && !state.isStaging) {
      url = 'https://preview.invoicing.co/api/v1/live_preview';
    } else {
      url = '${credentials.url}/live_preview';
    }

    if (invoice.isPurchaseOrder) {
      url += '/purchase_order';
    }

    url += '?entity=${invoice.entityType!.snakeCase}';

    if (invoice.isOld) {
      url += '&entity_id=${invoice.id}';
    }

    final data = serializers.serializeWith(InvoiceEntity.serializer, invoice);
    webClient
        .post(url, credentials.token,
            data: json.encode(data), rawResponse: true)
        .then((dynamic response) {
      setState(() {
        _isLoading = false;
        _response = response;

        if (kIsWeb && state.prefState.enableNativeBrowser) {
          _pdfString =
              'data:application/pdf;base64,' + base64Encode(response.bodyBytes);
          WebUtils.registerWebView(_pdfString);
        }
      });
    }).catchError((dynamic error) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.viewModel.state;

    if (!widget.viewModel.invoice!.hasClient) {
      return HelpText(AppLocalization.of(context)!.noClientSelected);
    }

    if (_response == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Center(
      child: kIsWeb && state.prefState.enableNativeBrowser
          ? HtmlElementView(viewType: _pdfString!)
          : PdfPreview(
              build: (format) => _response!.bodyBytes,
              canChangeOrientation: false,
              canChangePageFormat: false,
              allowPrinting: false,
              allowSharing: false,
              canDebug: false,
              maxPageWidth: 800,
            ),
    );
  }
}
