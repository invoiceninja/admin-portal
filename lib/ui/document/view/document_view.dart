import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/document/view/document_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

class DocumentView extends StatefulWidget {
  const DocumentView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DocumentViewVM viewModel;

  @override
  _DocumentViewState createState() => new _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final document = viewModel.document;

    return ViewScaffold(
      entity: document,
      body: FormCard(children: [
        // STARTER: widgets - do not remove comment
      ]),
    );
  }
}
