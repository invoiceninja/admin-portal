import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/payment/refund/payment_refund_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';

class PaymentRefund extends StatefulWidget {
  const PaymentRefund({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final PaymentRefundVM viewModel;

  @override
  _PaymentRefundState createState() => _PaymentRefundState();
}

class _PaymentRefundState extends State<PaymentRefund> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_paymentRefund');

  final _amountController = TextEditingController();

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();
  bool autoValidate = false;

  @override
  void didChangeDependencies() {
    _controllers = [
      _amountController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final payment = widget.viewModel.payment;

    _amountController.text = formatNumber(payment.amount, context,
        formatNumberType: FormatNumberType.input);
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
      final payment = widget.viewModel.payment
          .rebuild((b) => b..amount = parseDouble(_amountController.text));
      if (payment != widget.viewModel.payment) {
        widget.viewModel.onChanged(payment);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final payment = viewModel.payment;
    final localization = AppLocalization.of(context);

    final paymentables = payment.invoices.toList();
    if (paymentables.where((paymentable) => paymentable.isEmpty).isEmpty) {
      paymentables.add(PaymentableEntity());
    }

    return EditScaffold(
      entity: payment,
      title: localization.refund,
      saveLabel: localization.refund,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

        setState(() {
          autoValidate = !isValid;
        });

        if (!isValid) {
          return;
        }

        viewModel.onRefundPressed(context);
      },
      body: Form(
        key: _formKey,
        child: ListView(
          key: ValueKey(viewModel.payment.id),
          children: <Widget>[
            FormCard(
              children: <Widget>[
                if (payment.paymentables.isEmpty)
                  DecoratedFormField(
                    controller: _amountController,
                    autocorrect: false,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    label: localization.amount,
                  ),
                if (payment.paymentables.isNotEmpty)
                  for (var index = 0; index < paymentables.length; index++)
                    PaymentableEditor(
                      key: ValueKey(
                          '__paymentable_${index}_${paymentables[index].id}__'),
                      viewModel: viewModel,
                      paymentable: paymentables[index],
                      index: index,
                      onChanged: () {},
                    ),
                DatePicker(
                  validator: (String val) => val.trim().isEmpty
                      ? AppLocalization.of(context).pleaseSelectADate
                      : null,
                  autoValidate: autoValidate,
                  labelText: localization.refundDate,
                  selectedDate: payment.date,
                  onSelected: (date) {
                    viewModel.onChanged(payment.rebuild((b) => b..date = date));
                  },
                ),
              ],
            ),
            FormCard(children: <Widget>[
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.sendEmail),
                value: viewModel.prefState.emailPayment,
                subtitle: Text(localization.emailReceipt),
                onChanged: (value) => viewModel.onEmailChanged(value),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class PaymentableEditor extends StatefulWidget {
  const PaymentableEditor({
    Key key,
    @required this.viewModel,
    @required this.paymentable,
    @required this.onChanged,
    @required this.index,
  }) : super(key: key);

  final PaymentRefundVM viewModel;
  final PaymentableEntity paymentable;
  final Function onChanged;
  final int index;

  @override
  _PaymentableEditorState createState() => _PaymentableEditorState();
}

class _PaymentableEditorState extends State<PaymentableEditor> {
  final _amountController = TextEditingController();
  String _invoiceId = '';
  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _amountController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    _amountController.text = formatNumber(widget.paymentable.amount, context,
        formatNumberType: FormatNumberType.input);

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

  void _onChanged([String clientId]) {
    final paymentable = widget.paymentable.rebuild((b) => b
      ..invoiceId = _invoiceId
      ..amount = parseDouble(_amountController.text));

    if (paymentable == widget.paymentable || paymentable.isEmpty) {
      return;
    }

    PaymentEntity payment;

    if (widget.index == widget.viewModel.payment.invoices.length) {
      payment =
          widget.viewModel.payment.rebuild((b) => b..invoices.add(paymentable));
    } else {
      payment = widget.viewModel.payment
          .rebuild((b) => b..invoices[widget.index] = paymentable);
    }

    if (clientId != null) {
      payment = payment.rebuild((b) => b..clientId = clientId);
    }

    widget.viewModel.onChanged(payment);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final payment = viewModel.payment;
    final paymentable = widget.paymentable;
    final localization = AppLocalization.of(context);

    return Row(
      children: <Widget>[
        Expanded(
          child: EntityDropdown(
            key: Key('__invoice_${payment.clientId}__'),
            entityType: EntityType.invoice,
            labelText: AppLocalization.of(context).invoice,
            entityId: paymentable.invoiceId,
            entityList: payment.paymentables
                .map((payment) => payment.invoiceId)
                .toList(),
            onSelected: (selected) {
              final invoice = selected as InvoiceEntity;
              _amountController.text = formatNumber(invoice.balance, context,
                  formatNumberType: FormatNumberType.input);
              _invoiceId = invoice.id;
              _onChanged(invoice.clientId);
            },
          ),
        ),
        SizedBox(
          width: kTableColumnGap,
        ),
        Expanded(
          child: DecoratedFormField(
            controller: _amountController,
            label: localization.amount,
          ),
        ),
        SizedBox(
          width: kTableColumnGap,
        ),
        IconButton(
          icon: Icon(Icons.clear),
          tooltip: localization.remove,
          onPressed: paymentable.isEmpty
              ? null
              : () {
                  viewModel.onChanged(payment
                      .rebuild((b) => b..invoices.removeAt(widget.index)));
                },
        ),
      ],
    );
  }
}
