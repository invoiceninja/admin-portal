import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/settings/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_icon_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class CreditEdit extends StatefulWidget {
  const CreditEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final CreditEditVM viewModel;

  @override
  _CreditEditState createState() => _CreditEditState();
}

class _CreditEditState extends State<CreditEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_creditEdit');
  final _debouncer = Debouncer();

  // STARTER: controllers - do not remove comment

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      // STARTER: array - do not remove comment
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final credit = widget.viewModel.credit;
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
      final credit = widget.viewModel.credit.rebuild((b) => b
          // STARTER: set value - do not remove comment
          );
      if (credit != widget.viewModel.credit) {
        widget.viewModel.onChanged(credit);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final credit = viewModel.credit;

    return EditScaffold(
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

        setState(() {
          _autoValidate = !isValid;
        });

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
