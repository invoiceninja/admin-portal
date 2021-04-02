import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/payment_term/edit/payment_term_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class PaymentTermEdit extends StatefulWidget {
  const PaymentTermEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final PaymentTermEditVM viewModel;

  @override
  _PaymentTermEditState createState() => _PaymentTermEditState();
}

class _PaymentTermEditState extends State<PaymentTermEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_paymentTermEdit');
  final _debouncer = Debouncer();

  List<TextEditingController> _controllers = [];

  final _numDaysController = TextEditingController();

  @override
  void didChangeDependencies() {
    _controllers = [
      _numDaysController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final paymentTerm = widget.viewModel.paymentTerm;
    _numDaysController.text = formatNumber(
        paymentTerm.numDays.toDouble(), context,
        formatNumberType: FormatNumberType.inputAmount);

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
    final paymentTerm = widget.viewModel.paymentTerm
        .rebuild((b) => b..numDays = parseInt(_numDaysController.text));
    if (paymentTerm != widget.viewModel.paymentTerm) {
      _debouncer.run(() {
        widget.viewModel.onChanged(paymentTerm);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);

    return EditScaffold(
      title: viewModel.paymentTerm.isNew
          ? localization.newPaymentTerm
          : localization.editPaymentTerm,
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
            return ScrollableListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    DecoratedFormField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      controller: _numDaysController,
                      label: localization.numberOfDays,
                      validator: (value) => value == null || value.isEmpty
                          ? localization.pleaseEnterAValue
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
