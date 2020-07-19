import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_selectors.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/payment/edit/payment_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';

class PaymentEdit extends StatefulWidget {
  const PaymentEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final PaymentEditVM viewModel;

  @override
  _PaymentEditState createState() => _PaymentEditState();
}

class _PaymentEditState extends State<PaymentEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_paymentEdit');

  final _amountController = TextEditingController();
  final _transactionReferenceController = TextEditingController();
  final _privateNotesController = TextEditingController();

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();
  bool autoValidate = false;

  @override
  void didChangeDependencies() {
    _controllers = [
      _amountController,
      _transactionReferenceController,
      _privateNotesController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final payment = widget.viewModel.payment;

    _amountController.text = formatNumber(payment.amount, context,
        formatNumberType: FormatNumberType.input);
    _transactionReferenceController.text = payment.transactionReference;
    _privateNotesController.text = payment.privateNotes;
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
      final payment = widget.viewModel.payment.rebuild((b) => b
        ..amount = parseDouble(_amountController.text)
        ..transactionReference = _transactionReferenceController.text.trim()
        ..privateNotes = _privateNotesController.text.trim());
      if (payment != widget.viewModel.payment) {
        widget.viewModel.onChanged(payment);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final payment = viewModel.payment;
    final state = viewModel.state;
    final localization = AppLocalization.of(context);

    final invoicePaymentables = payment.invoices.toList();
    if ((payment.isForInvoice != true || invoicePaymentables.isEmpty) &&
        invoicePaymentables
            .where((paymentable) => paymentable.isEmpty)
            .isEmpty) {
      invoicePaymentables.add(PaymentableEntity());
    }

    final creditPaymentables = payment.credits.toList();
    if ((payment.isForCredit != true || creditPaymentables.isEmpty) &&
        creditPaymentables
            .where((paymentable) => paymentable.isEmpty)
            .isEmpty) {
      creditPaymentables.add(PaymentableEntity());
    }

    double paymentTotal = 0;
    invoicePaymentables.forEach((invoice) {
      paymentTotal += invoice.amount;
    });

    return EditScaffold(
      entity: payment,
      title: viewModel.payment.isNew
          ? localization.enterPayment
          : localization.editPayment,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

        setState(() {
          autoValidate = !isValid;
        });

        if (!isValid) {
          return;
        }

        viewModel.onSavePressed(context);
      },
      body: Form(
        key: _formKey,
        child: ListView(
          key: ValueKey(viewModel.payment.id),
          children: <Widget>[
            FormCard(
              children: <Widget>[
                if (payment.isNew) ...[
                  EntityDropdown(
                    key: Key('__client_${payment.clientId}__'),
                    entityType: EntityType.client,
                    labelText: AppLocalization.of(context).client,
                    entityId: payment.clientId,
                    autoValidate: autoValidate,
                    validator: (String val) => val.trim().isEmpty
                        ? AppLocalization.of(context).pleaseSelectAClient
                        : null,
                    onSelected: (client) {
                      viewModel.onChanged(payment.rebuild((b) => b
                        ..clientId = client.id
                        ..invoices.clear()));
                    },
                    entityList: memoizedDropdownClientList(
                        state.clientState.map,
                        state.clientState.list,
                        state.userState.map,
                        state.staticState),
                  ),
                  if (payment.isForInvoice != true &&
                      payment.isForCredit != true)
                    DecoratedFormField(
                      controller: _amountController,
                      autocorrect: false,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      label: paymentTotal == 0
                          ? localization.amount
                          : '${localization.amount} • ${formatNumber(paymentTotal, context, clientId: payment.clientId)}',
                    ),
                ],
                if (payment.isForCredit != true)
                  for (var index = 0;
                      index < invoicePaymentables.length;
                      index++)
                    PaymentableEditor(
                      key: ValueKey(
                          '__paymentable_${index}_${invoicePaymentables[index].id}__'),
                      viewModel: viewModel,
                      paymentable: invoicePaymentables[index],
                      index: index,
                      entityType: EntityType.invoice,
                      limit: payment.amount == 0
                          ? null
                          : payment.amount - paymentTotal,
                    ),
                DatePicker(
                  validator: (String val) => val.trim().isEmpty
                      ? AppLocalization.of(context).pleaseSelectADate
                      : null,
                  autoValidate: autoValidate,
                  labelText: localization.paymentDate,
                  selectedDate: payment.date,
                  onSelected: (date) {
                    viewModel.onChanged(payment.rebuild((b) => b..date = date));
                  },
                ),
                EntityDropdown(
                  key: ValueKey('__payment_type_${payment.typeId}__'),
                  entityType: EntityType.paymentType,
                  entityList: memoizedPaymentTypeList(
                      viewModel.staticState.paymentTypeMap),
                  labelText: localization.paymentType,
                  entityId: payment.typeId,
                  onSelected: (paymentType) => viewModel.onChanged(
                      payment.rebuild((b) => b..typeId = paymentType.id)),
                ),
                if (payment.isForInvoice != true)
                  if (state.company.isModuleEnabled(EntityType.credit))
                    for (var index = 0;
                        index < creditPaymentables.length;
                        index++)
                      PaymentableEditor(
                        key: ValueKey(
                            '__paymentable_${index}_${creditPaymentables[index].id}__'),
                        viewModel: viewModel,
                        paymentable: creditPaymentables[index],
                        index: index,
                        entityType: EntityType.credit,
                        limit: 0,
                      ),
                DecoratedFormField(
                  controller: _transactionReferenceController,
                  label: localization.transactionReference,
                ),
                DecoratedFormField(
                  controller: _privateNotesController,
                  label: localization.privateNotes,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                ),
              ],
            ),
            payment.isNew
                ? FormCard(children: <Widget>[
                    SwitchListTile(
                      activeColor: Theme.of(context).accentColor,
                      title: Text(localization.sendEmail),
                      value: viewModel.prefState.emailPayment,
                      subtitle: Text(localization.emailReceipt),
                      onChanged: (value) => viewModel.onEmailChanged(value),
                    ),
                  ])
                : Container(),
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
    @required this.index,
    @required this.entityType,
    @required this.limit,
  }) : super(key: key);

  final PaymentEditVM viewModel;
  final PaymentableEntity paymentable;
  final int index;
  final EntityType entityType;
  final double limit;

  @override
  _PaymentableEditorState createState() => _PaymentableEditorState();
}

class _PaymentableEditorState extends State<PaymentableEditor> {
  final _amountController = TextEditingController();
  String _invoiceId;
  String _creditId;
  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _amountController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final paymentable = widget.paymentable;
    _amountController.text = formatNumber(paymentable.amount, context,
        formatNumberType: FormatNumberType.input);
    if (paymentable.entityType == EntityType.invoice) {
      _invoiceId = paymentable.invoiceId;
    } else {
      _creditId = paymentable.creditId;
    }

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
    PaymentableEntity paymentable;
    if (widget.entityType == EntityType.invoice) {
      paymentable = widget.paymentable.rebuild((b) => b
        ..invoiceId = _invoiceId ?? widget.paymentable.invoiceId
        ..amount = parseDouble(_amountController.text));
    } else {
      paymentable = widget.paymentable.rebuild((b) => b
        ..creditId = _creditId ?? widget.paymentable.creditId
        ..amount = parseDouble(_amountController.text));
    }

    if (paymentable == widget.paymentable || paymentable.isEmpty) {
      return;
    }

    PaymentEntity payment;

    if (widget.entityType == EntityType.invoice) {
      if (widget.index == widget.viewModel.payment.invoices.length) {
        payment = widget.viewModel.payment
            .rebuild((b) => b..invoices.add(paymentable));
      } else {
        payment = widget.viewModel.payment
            .rebuild((b) => b..invoices[widget.index] = paymentable);
      }
    } else {
      if (widget.index == widget.viewModel.payment.credits.length) {
        payment = widget.viewModel.payment
            .rebuild((b) => b..credits.add(paymentable));
      } else {
        payment = widget.viewModel.payment
            .rebuild((b) => b..credits[widget.index] = paymentable);
      }
    }

    if (clientId != null) {
      payment = payment.rebuild((b) => b..clientId = clientId);
    }

    widget.viewModel.onChanged(payment);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final payment = viewModel.payment;
    final paymentable = widget.paymentable;
    final localization = AppLocalization.of(context);

    final paymentList = memoizedDropdownInvoiceList(
      state.invoiceState.map,
      state.clientState.map,
      state.invoiceState.list,
      payment.clientId,
      state.staticState,
      state.userState.map,
      payment.invoices.map((p) => p.invoiceId).toList(),
    );

    final creditList = memoizedDropdownCreditList(
        state.creditState.map,
        state.clientState.map,
        state.creditState.list,
        payment.clientId,
        state.staticState,
        state.userState.map,
        payment.credits.map((p) => p.creditId).toList());

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.entityType == EntityType.invoice)
          Expanded(
            child: EntityDropdown(
              key: Key('__invoice_${payment.clientId}__'),
              entityType: EntityType.invoice,
              labelText: AppLocalization.of(context).invoice,
              entityId: paymentable.invoiceId,
              entityList: paymentList,
              onSelected: (selected) {
                final invoice = selected as InvoiceEntity;
                final amount = widget.limit != null
                    ? min(widget.limit, invoice.balance)
                    : invoice.balance;
                _amountController.text = formatNumber(amount, context,
                    formatNumberType: FormatNumberType.input);
                _invoiceId = invoice.id;
                _onChanged(invoice.clientId);
              },
            ),
          ),
        if (widget.entityType == EntityType.credit &&
            creditList.isNotEmpty &&
            (payment.clientId ?? '').isNotEmpty)
          Expanded(
            child: EntityDropdown(
              key: Key('__credit_${payment.clientId}__'),
              entityType: EntityType.credit,
              labelText: AppLocalization.of(context).credit,
              entityId: paymentable.creditId,
              entityList: creditList,
              onSelected: (selected) {
                final credit = selected as InvoiceEntity;
                _amountController.text = formatNumber(credit.balance, context,
                    formatNumberType: FormatNumberType.input);
                _creditId = credit.id;
                _onChanged(credit.clientId);
              },
            ),
          ),
        if ((_creditId ?? '').isNotEmpty || (_invoiceId ?? '').isNotEmpty) ...[
          SizedBox(
            width: kTableColumnGap,
          ),
          Expanded(
            child: DecoratedFormField(
              controller: _amountController,
              label: payment.isForInvoice == true
                  ? localization.amount
                  : localization.applied,
            ),
          ),
        ],
        if ((widget.entityType == EntityType.invoice &&
                payment.invoices.isNotEmpty &&
                payment.isForInvoice != true &&
                _invoiceId != null) ||
            (widget.entityType == EntityType.credit &&
                payment.credits.isNotEmpty &&
                payment.isForCredit != true &&
                _creditId != null)) ...[
          SizedBox(
            width: kTableColumnGap,
          ),
          IconButton(
            icon: Icon(Icons.clear),
            tooltip: localization.remove,
            onPressed: paymentable.isEmpty
                ? null
                : () {
                    if (widget.entityType == EntityType.invoice) {
                      viewModel.onChanged(payment
                          .rebuild((b) => b..invoices.removeAt(widget.index)));
                    } else {
                      viewModel.onChanged(payment
                          .rebuild((b) => b..credits.removeAt(widget.index)));
                    }
                  },
          ),
        ],
      ],
    );
  }
}
