// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/token/edit/token_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TokenEdit extends StatefulWidget {
  const TokenEdit({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final TokenEditVM viewModel;

  @override
  _TokenEditState createState() => _TokenEditState();
}

class _TokenEditState extends State<TokenEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_tokenEdit');
  final _debouncer = Debouncer();

  final _nameController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _nameController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final token = widget.viewModel.token;
    _nameController.text = token.name;

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
    final token = widget.viewModel.token
        .rebuild((b) => b..name = _nameController.text.trim());
    if (token != widget.viewModel.token) {
      _debouncer.run(() {
        widget.viewModel.onChanged(token);
      });
    }
  }

  void _onSavePressed(BuildContext context) {
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
    final token = viewModel.token;

    return EditScaffold(
      entity: token,
      title: token.isNew ? localization!.newToken : localization!.editToken,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: _onSavePressed,
      body: Form(
          key: _formKey,
          child: Builder(builder: (BuildContext context) {
            return ScrollableListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    DecoratedFormField(
                      autofocus: true,
                      controller: _nameController,
                      label: localization.name,
                      validator: (value) =>
                          value.isEmpty || value.trim().isEmpty
                              ? localization.pleaseEnterAName
                              : null,
                      onSavePressed: _onSavePressed,
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ],
            );
          })),
    );
  }
}
