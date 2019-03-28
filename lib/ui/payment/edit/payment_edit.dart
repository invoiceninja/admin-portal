import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/payment/edit/payment_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_icon_button.dart';
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
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _amountController = TextEditingController();
  final _transactionReferenceController = TextEditingController();
  final _privateNotesController = TextEditingController();

  List<TextEditingController> _controllers = [];

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
    final payment = widget.viewModel.payment.rebuild((b) => b
      ..amount = parseDouble(_amountController.text)
      ..transactionReference = _transactionReferenceController.text.trim()
      ..privateNotes = _privateNotesController.text.trim());
    if (payment != widget.viewModel.payment) {
      widget.viewModel.onChanged(payment);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final payment = viewModel.payment;
    final localization = AppLocalization.of(context);

    return WillPopScope(
        onWillPop: () async {
          viewModel.onBackPressed();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(viewModel.payment.isNew
                ? localization.enterPayment
                : localization.editPayment),
            actions: <Widget>[
              Builder(builder: (BuildContext context) {
                return ActionIconButton(
                  icon: Icons.cloud_upload,
                  tooltip: AppLocalization.of(context).save,
                  isVisible: !payment.isDeleted,
                  isSaving: viewModel.isSaving,
                  isDirty: payment.isNew || payment != viewModel.origPayment,
                  onPressed: () {
                    final bool isValid = _formKey.currentState.validate();

                    setState(() {
                      autoValidate = !isValid;
                    });

                    if (!isValid) {
                      return;
                    }

                    viewModel.onSavePressed(context);
                  },
                );
              }),
            ],
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    payment.isNew
                        ? EntityDropdown(
                            key: Key('__client_${payment.clientId}__'),
                            entityType: EntityType.client,
                            labelText: AppLocalization.of(context).client,
                            entityMap: viewModel.clientMap,
                            initialValue:
                                (viewModel.clientMap[payment.clientId] ??
                                        ClientEntity())
                                    .listDisplayName,
                            onSelected: (client) {
                              viewModel.onChanged(payment.rebuild((b) => b
                                ..clientId = client.id
                                ..invoiceId = 0));
                            },
                            entityList: memoizedDropdownClientList(
                                viewModel.clientMap, viewModel.clientList),
                          )
                        : Container(),
                    payment.isNew
                        ? EntityDropdown(
                            key: Key('__invoice_${payment.clientId}__'),
                            entityType: EntityType.invoice,
                            labelText: AppLocalization.of(context).invoice,
                            entityMap: viewModel.invoiceMap,
                            initialValue: viewModel
                                .invoiceMap[payment.invoiceId]?.listDisplayName,
                            autoValidate: autoValidate,
                            validator: (String val) => val.trim().isEmpty
                                ? AppLocalization.of(context)
                                    .pleaseSelectAnInvoice
                                : null,
                            entityList: memoizedDropdownInvoiceList(
                                viewModel.invoiceMap,
                                viewModel.clientMap,
                                viewModel.invoiceList,
                                payment.clientId),
                            onSelected: (selected) {
                              final invoice = selected as InvoiceEntity;
                              _amountController.text = formatNumber(
                                  invoice.balance, context,
                                  formatNumberType: FormatNumberType.input);
                              viewModel.onChanged(payment.rebuild((b) => b
                                ..invoiceId = invoice.id
                                ..clientId = invoice.clientId
                                ..amount = invoice.balance));
                            },
                          )
                        : Container(),
                    payment.isNew
                        ? TextFormField(
                            controller: _amountController,
                            autocorrect: false,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: localization.amount,
                            ),
                          )
                        : Container(),
                    EntityDropdown(
                      entityType: EntityType.paymentType,
                      entityMap: viewModel.staticState.paymentTypeMap,
                      entityList: memoizedPaymentTypeList(
                          viewModel.staticState.paymentTypeMap),
                      labelText: localization.paymentType,
                      initialValue: viewModel.staticState
                          .paymentTypeMap[payment.paymentTypeId]?.name,
                      onSelected: (paymentType) => viewModel.onChanged(payment
                          .rebuild((b) => b..paymentTypeId = paymentType.id)),
                    ),
                    DatePicker(
                      validator: (String val) => val.trim().isEmpty
                          ? AppLocalization.of(context).pleaseSelectADate
                          : null,
                      autoValidate: autoValidate,
                      labelText: localization.paymentDate,
                      selectedDate: payment.paymentDate,
                      onSelected: (date) {
                        viewModel.onChanged(
                            payment.rebuild((b) => b..paymentDate = date));
                      },
                    ),
                    TextFormField(
                      controller: _transactionReferenceController,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: localization.transactionReference,
                      ),
                    ),
                    TextFormField(
                      controller: _privateNotesController,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: localization.privateNotes,
                      ),
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
                          value: viewModel.uiState.emailPayment,
                          subtitle: Text(localization.emailReceipt),
                          onChanged: (value) => viewModel.onEmailChanged(value),
                        ),
                      ])
                    : Container(),
              ],
            ),
          ),
        ));
  }
}
