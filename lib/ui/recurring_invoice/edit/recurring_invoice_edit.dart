import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/edit/recurring_invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class RecurringInvoiceEdit extends StatefulWidget {
  const RecurringInvoiceEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final RecurringInvoiceEditVM viewModel;

  @override
  _RecurringInvoiceEditState createState() => _RecurringInvoiceEditState();
}

class _RecurringInvoiceEditState extends State<RecurringInvoiceEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_recurringInvoiceEdit');
  final _debouncer = Debouncer();

  // STARTER: controllers - do not remove comment

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      // STARTER: array - do not remove comment
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    //final recurringInvoice = widget.viewModel.recurringInvoice;
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
      final recurringInvoice =
          widget.viewModel.recurringInvoice.rebuild((b) => b
              // STARTER: set value - do not remove comment
              );
      if (recurringInvoice != widget.viewModel.recurringInvoice) {
        widget.viewModel.onChanged(recurringInvoice);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final recurringInvoice = viewModel.recurringInvoice;

    return EditScaffold(
      title: recurringInvoice.isNew
          ? localization.newRecurringInvoice
          : localization.editRecurringInvoice,
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
