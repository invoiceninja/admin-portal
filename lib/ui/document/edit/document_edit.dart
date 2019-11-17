import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/document/edit/document_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_flat_button.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class DocumentEdit extends StatefulWidget {
  const DocumentEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DocumentEditVM viewModel;

  @override
  _DocumentEditState createState() => _DocumentEditState();
}

class _DocumentEditState extends State<DocumentEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_documentEdit');
  final _debouncer = Debouncer();

  // STARTER: controllers - do not remove comment

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      // STARTER: array - do not remove comment
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    //final document = widget.viewModel.document;
    // STARTER: read value - do not remove comment

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
    _debouncer.run(() {
      final document = widget.viewModel.document.rebuild((b) => b
          // STARTER: set value - do not remove comment
          );
      if (document != widget.viewModel.document) {
        widget.viewModel.onChanged(document);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final document = viewModel.document;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: isMobile(context),
          title: Text(viewModel.document.isNew
              ? localization.newDocument
              : localization.editDocument),
          actions: <Widget>[
            /*
            if (!isMobile(context))
              FlatButton(
                child: Text(
                  localization.cancel,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => viewModel.onCancelPressed(context),
              ),
              */
            ActionFlatButton(
              tooltip: localization.save,
              isVisible: !document.isDeleted,
              isDirty: document.isNew || document != viewModel.origDocument,
              isSaving: viewModel.isSaving,
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }
                viewModel.onSavePressed(context);
              },
            ),
          ],
        ),
        body: Form(
            key: _formKey,
            child: Builder(builder: (BuildContext context) {
              return ListView(
                key: ValueKey(viewModel.document.id),
                children: <Widget>[
                  FormCard(
                    children: <Widget>[
                      // STARTER: widgets - do not remove comment
                    ],
                  ),
                ],
              );
            })),
      ),
    );
  }
}
