// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:native_pdf_view/native_pdf_view.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_pdf_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

class InvoiceEditPDF extends StatefulWidget {
  const InvoiceEditPDF({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EntityEditPDFVM viewModel;

  @override
  InvoiceEditPDFState createState() => InvoiceEditPDFState();
}

class InvoiceEditPDFState extends State<InvoiceEditPDF> {
  bool _isLoading = false;
  String _pdfString;
  PdfController _pdfController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final viewModel = widget.viewModel;
    if (!viewModel.invoice.hasClient || _isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final credentials = viewModel.state.credentials;
    final webClient = WebClient();
    String url =
        '${credentials.url}/live_preview?entity=${viewModel.invoice.entityType.snakeCase}';
    if (viewModel.invoice.isOld) {
      url += '&entity_id=${viewModel.invoice.id}';
    }
    if (viewModel.state.isProduction) {
      url = url.replaceFirst('//', '//preview.');
    }

    final data =
        serializers.serializeWith(InvoiceEntity.serializer, viewModel.invoice);
    webClient
        .post(url, credentials.token,
            data: json.encode(data), rawResponse: true)
        .then((dynamic response) {
      setState(() {
        _isLoading = false;

        if (kIsWeb) {
          _pdfString =
              'data:application/pdf;base64,' + base64Encode(response.bodyBytes);
          WebUtils.registerWebView(_pdfString);
        } else {
          final document = PdfDocument.openData(response.bodyBytes);
          _pdfController?.dispose();
          _pdfController = PdfController(document: document);
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
    if (!widget.viewModel.invoice.hasClient) {
      return HelpText(AppLocalization.of(context).noClientSelected);
    }

    if (_pdfString == null && _pdfController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Center(
      child: kIsWeb
          ? HtmlElementView(viewType: _pdfString)
          : PdfView(controller: _pdfController),
    );
  }
}
