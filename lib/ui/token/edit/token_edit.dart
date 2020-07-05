import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/token/edit/token_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class TokenEdit extends StatefulWidget {
  const TokenEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final TokenEditVM viewModel;

  @override
  _TokenEditState createState() => _TokenEditState();
}

class _TokenEditState extends State<TokenEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_tokenEdit');
  final _debouncer = Debouncer();

  // STARTER: controllers - do not remove comment

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      // STARTER: array - do not remove comment
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    //final token = widget.viewModel.token;
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
      final token = widget.viewModel.token.rebuild((b) => b
          // STARTER: set value - do not remove comment
          );
      if (token != widget.viewModel.token) {
        widget.viewModel.onChanged(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final token = viewModel.token;

    return EditScaffold(
      title: token.isNew ? localization.newToken : localization.editToken,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

        /*
          setState(() {
            _autoValidate = !isValid;
          });
            */

        if (!isValid) {
          return;
        }

        viewModel.onSavePressed(context);
      },
      body: Form(
          key: _formKey,
          child: Builder(builder: (BuildContext context) {
            return ListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    // STARTER: widgets - do not remove comment
                  ],
                ),
              ],
            );
          })),
    );
  }
}
