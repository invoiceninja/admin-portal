// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/bottom_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/document/view/document_view_vm.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:printing/printing.dart';
import 'dart:convert' show utf8;

class DocumentView extends StatefulWidget {
  const DocumentView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
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
    final state = viewModel.state;
    final document = viewModel.document;
    final entity = state.getEntity(document.parentType, document.parentId);

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: document,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListDivider(),
          if (entity != null)
            EntityListTile(
              isFilter: widget.isFilter,
              entity: entity,
            ),
          Expanded(
            child: document.data == null
                ? LoadingIndicator()
                : document.isImage
                    ? PinchZoom(
                        child: Image.memory(document.data!),
                      )
                    : document.isPdf
                        ? PdfPreview(
                            build: (format) => document.data!,
                            canChangeOrientation: false,
                            canChangePageFormat: false,
                            allowPrinting: false,
                            allowSharing: false,
                            canDebug: false,
                          )
                        : document.isTxt
                            ? FormCard(
                                child:
                                    SelectableText(utf8.decode(document.data!)),
                                isLast: true,
                              )
                            : SizedBox(),
          ),
          BottomButtons(
            entity: document,
            action1: EntityAction.viewDocument,
            action2: EntityAction.download,
          ),
        ],
      ),
    );
  }
}
