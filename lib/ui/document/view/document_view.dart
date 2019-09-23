import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/document/view/document_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: EntityStateTitle(entity: document),
        actions: document.isNew
            ? []
            : [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    viewModel.onEditPressed(context);
                  },
                ),
                ActionMenuButton(
                  isSaving: viewModel.isSaving,
                  entity: document,
                  onSelected: viewModel.onEntityAction,
                ),
              ],
      ),
      body: FormCard(children: [
        // STARTER: widgets - do not remove comment
      ]),
    );
  }
}
