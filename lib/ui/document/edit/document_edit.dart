// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/document/edit/document_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DocumentEdit extends StatefulWidget {
  const DocumentEdit({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final DocumentEditVM viewModel;

  @override
  _DocumentEditState createState() => _DocumentEditState();
}

class _DocumentEditState extends State<DocumentEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_documentEdit');
  final _debouncer = Debouncer();

  final _nameController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _nameController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final document = widget.viewModel.document;
    _nameController.text = document.name;

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    final document = widget.viewModel.document
        .rebuild((b) => b..name = _nameController.text.trim());
    if (document != widget.viewModel.document) {
      _debouncer.run(() {
        widget.viewModel.onChanged(document);
      });
    }
  }

  void _onSavePressed() {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    widget.viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final document = viewModel.document;

    return EditScaffold(
      entity: document,
      title: document.isNew
          ? localization!.newDocument
          : localization!.editDocument,
      onSavePressed: (_) => _onSavePressed(),
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      body: Form(
          key: _formKey,
          child: Builder(builder: (BuildContext context) {
            return ScrollableListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    DecoratedFormField(
                      autofocus: true,
                      label: localization.name,
                      keyboardType: TextInputType.text,
                      controller: _nameController,
                      onSavePressed: (_) => _onSavePressed(),
                      validator: (value) => value.trim().isEmpty
                          ? localization.pleaseEnterAName
                          : null,
                    ),
                  ],
                ),
              ],
            );
          })),
    );
  }
}
