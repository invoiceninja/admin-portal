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

import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';
import 'package:printing/printing.dart';

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
  http.Response _response;

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
        _response = response;
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

    if (_response == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Center(
      child: PdfPreview(
        build: (format) => _response.bodyBytes,
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
      ),
    );
  }
}
