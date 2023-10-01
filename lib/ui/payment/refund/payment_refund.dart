// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/payment/refund/payment_refund_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class PaymentRefund extends StatefulWidget {
  const PaymentRefund({
    Key? key,
    required this.viewModel,
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
        formatNumberType: FormatNumberType.inputMoney)!;
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
    final localization = AppLocalization.of(context)!;

    final paymentables = payment.invoices.toList();
    final needsEmpty =
        paymentables.where((paymentable) => paymentable.isEmpty).isEmpty;
    final hasMultipleInvoices = payment.invoicePaymentables.length > 1;
    final addBlank = needsEmpty && hasMultipleInvoices;
    if (addBlank) {
      paymentables.add(PaymentableEntity());
    }

    final state = viewModel.state;
    final companyGateway =
        state.companyGatewayState.get(payment.companyGatewayId);
    final GatewayEntity gateway =
        state.staticState.gatewayMap[companyGateway.gatewayId] ??
            GatewayEntity();

    final body = Form(
      key: _formKey,
      child: Column(
        key: ValueKey(viewModel.payment.id),
        children: <Widget>[
          FormCard(
            children: <Widget>[
              if (payment.paymentables.isEmpty)
                DecoratedFormField(
                  controller: _amountController,
                  autocorrect: false,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: true),
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
                    ? AppLocalization.of(context)!.pleaseSelectADate
                    : null,
                autoValidate: autoValidate,
                labelText: localization.refundDate,
                selectedDate: payment.date,
                onSelected: (date, _) {
                  viewModel.onChanged(payment.rebuild((b) => b..date = date));
                },
              ),
            ],
          ),
          FormCard(
            children: <Widget>[
              SwitchListTile(
                activeColor: Theme.of(context).colorScheme.secondary,
                title: Text(localization.sendEmail),
                value: payment.sendEmail ?? false,
                subtitle: Text(localization.emailReceipt),
                onChanged: (value) => viewModel
                    .onChanged(payment.rebuild((b) => b..sendEmail = value)),
              ),
              if (gateway.supportsRefunds(payment.gatewayTypeId))
                SwitchListTile(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  title: Text(localization.gatewayRefund),
                  value: payment.gatewayRefund ?? false,
                  subtitle: Text(localization.gatewayRefundHelp),
                  onChanged: (value) => viewModel.onChanged(
                      payment.rebuild((b) => b..gatewayRefund = value)),
                ),
            ],
          ),
        ],
      ),
    );

    void onSavePressed(BuildContext context) {
      final bool isValid = _formKey.currentState!.validate();

      setState(() {
        autoValidate = !isValid;
      });

      if (!isValid) {
        return;
      }

      final Completer<PaymentEntity> completer = Completer<PaymentEntity>();
      completer.future.then((value) {
        Navigator.of(context).pop();
      });

      viewModel.onRefundPressed(context, completer);
    }

    if (isMobile(context)) {
      return EditScaffold(
        entity: payment,
        title: localization.refundPayment,
        saveLabel: localization.refund,
        onCancelPressed: (context) => viewModel.onCancelPressed(context),
        onSavePressed: (context) => onSavePressed(context),
        body: body,
      );
    } else {
      return AlertDialog(
          backgroundColor: Theme.of(context).canvasColor,
          contentPadding: const EdgeInsets.all(0),
          actionsPadding: const EdgeInsets.only(right: 4),
          title: Text(localization.refundPayment),
          content: SingleChildScrollView(
            child: SizedBox(
              child: body,
              width: kDialogWidth,
            ),
          ),
          actions: <Widget>[
            if (viewModel.state.isSaving)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 30,
                  width: 30,
                ),
              )
            else ...[
              TextButton(
                child: Text(localization.cancel.toUpperCase()),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text(localization.refund.toUpperCase()),
                onPressed: () => onSavePressed(context),
              ),
            ],
          ]);
    }
  }
}

class PaymentableEditor extends StatefulWidget {
  const PaymentableEditor({
    Key? key,
    required this.viewModel,
    required this.paymentable,
    required this.onChanged,
    required this.index,
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
  String? _invoiceId = '';
  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _amountController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    _invoiceId = widget.paymentable.invoiceId;
    _amountController.text = formatNumber(widget.paymentable.amount, context,
        formatNumberType: FormatNumberType.inputMoney)!;

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

  void _onChanged([String? clientId]) {
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
    final hasMultipleInvoices = payment.invoicePaymentables.length > 1;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: EntityDropdown(
            allowClearing: false,
            entityType: EntityType.invoice,
            labelText: AppLocalization.of(context)!.invoice,
            entityId: paymentable.invoiceId,
            entityList: payment.paymentables
                .map((payment) => payment.invoiceId)
                .toList(),
            overrideSuggestedAmount: (entity) {
              final invoice = entity as InvoiceEntity;
              return formatNumber(invoice.amount, context,
                  clientId: invoice.clientId);
            },
            onSelected: (selected) {
              final invoice = selected as InvoiceEntity;
              /*
              _amountController.text = formatNumber(invoice.balance, context,
                  formatNumberType: FormatNumberType.input);
               */
              _onChanged(invoice.clientId);
              setState(() {
                _invoiceId = invoice.id;
              });
            },
          ),
        ),
        if ((_invoiceId ?? '').isNotEmpty) ...[
          SizedBox(
            width: kTableColumnGap,
          ),
          Expanded(
            child: DecoratedFormField(
              showClear: false,
              enabled: (_invoiceId ?? '').isNotEmpty,
              controller: _amountController,
              autocorrect: false,
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
              label: localization!.amount,
              autofocus: !hasMultipleInvoices,
              validator: (value) => !hasMultipleInvoices &&
                      (value.trim().isEmpty || parseDouble(value) == 0)
                  ? localization.pleaseEnterAValue
                  : null,
            ),
          ),
        ],
        if (hasMultipleInvoices && _invoiceId != null) ...[
          SizedBox(
            width: kTableColumnGap,
          ),
          IconButton(
            icon: Icon(Icons.clear),
            tooltip: localization!.remove,
            onPressed: paymentable.isEmpty
                ? null
                : () {
                    viewModel.onChanged(payment
                        .rebuild((b) => b..invoices.removeAt(widget.index)));
                  },
          ),
        ]
      ],
    );
  }
}
