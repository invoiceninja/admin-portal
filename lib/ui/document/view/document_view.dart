// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/document/view/document_view_vm.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:printing/printing.dart';

class DocumentView extends StatefulWidget {
  const DocumentView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final DocumentViewVM viewModel;
  final bool isFilter;

  @override
  _DocumentViewState createState() => new _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final document = viewModel.document;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: document,
      body: Column(children: [
        document.data == null
            ? LoadingIndicator()
            : SizedBox(
                height: 600,
                child: document.isImage
                    ? PinchZoom(
                        child: Image.memory(document.data),
                      )
                    : PdfPreview(
                        build: (format) => document.data,
                        canChangeOrientation: false,
                        canChangePageFormat: false,
                        allowPrinting: false,
                        allowSharing: false,
                        canDebug: false,
                      ),
              )
      ]),
    );
  }
}
