// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/autobill_dropdown_menu_item.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/client_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/design_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/discount_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/project_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/user_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/vendor_picker.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_tax_details.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceEditDetails extends StatefulWidget {
  const InvoiceEditDetails({
    Key? key,
    required this.viewModel,
    this.entityType = EntityType.invoice,
  }) : super(key: key);

  final EntityEditDetailsVM viewModel;
  final EntityType entityType;

  @override
  InvoiceEditDetailsState createState() => InvoiceEditDetailsState();
}

class InvoiceEditDetailsState extends State<InvoiceEditDetails> {
  final _invoiceNumberController = TextEditingController();
  final _poNumberController = TextEditingController();
  final _discountController = TextEditingController();
  final _partialController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();
  final _custom3Controller = TextEditingController();
  final _custom4Controller = TextEditingController();
  final _surcharge1Controller = TextEditingController();
  final _surcharge2Controller = TextEditingController();
  final _surcharge3Controller = TextEditingController();
  final _surcharge4Controller = TextEditingController();

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    _controllers = [
      _invoiceNumberController,
      _poNumberController,
      _discountController,
      _partialController,
      _custom1Controller,
      _custom2Controller,
      _custom3Controller,
      _custom4Controller,
      _surcharge1Controller,
      _surcharge2Controller,
      _surcharge3Controller,
      _surcharge4Controller,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final invoice = widget.viewModel.invoice!;
    _invoiceNumberController.text = invoice.number;
    _poNumberController.text = invoice.poNumber;
    _discountController.text = formatNumber(invoice.discount, context,
        formatNumberType: FormatNumberType.inputMoney)!;
    _partialController.text = formatNumber(invoice.partial, context,
        formatNumberType: FormatNumberType.inputMoney)!;
    _custom1Controller.text = invoice.customValue1;
    _custom2Controller.text = invoice.customValue2;
    _custom3Controller.text = invoice.customValue3;
    _custom4Controller.text = invoice.customValue4;
    _surcharge1Controller.text = formatNumber(invoice.customSurcharge1, context,
        formatNumberType: FormatNumberType.inputMoney)!;
    _surcharge2Controller.text = formatNumber(invoice.customSurcharge2, context,
        formatNumberType: FormatNumberType.inputMoney)!;
    _surcharge3Controller.text = formatNumber(invoice.customSurcharge3, context,
        formatNumberType: FormatNumberType.inputMoney)!;
    _surcharge4Controller.text = formatNumber(invoice.customSurcharge4, context,
        formatNumberType: FormatNumberType.inputMoney)!;
    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

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
    final invoice = widget.viewModel.invoice!.rebuild((b) => b
      ..number = _invoiceNumberController.text.trim()
      ..poNumber = _poNumberController.text.trim()
      ..discount = parseDouble(_discountController.text)
      ..partial = parseDouble(_partialController.text)
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim()
      ..customValue3 = _custom3Controller.text.trim()
      ..customValue4 = _custom4Controller.text.trim()
      ..customSurcharge1 = parseDouble(_surcharge1Controller.text)
      ..customSurcharge2 = parseDouble(_surcharge2Controller.text)
      ..customSurcharge3 = parseDouble(_surcharge3Controller.text)
      ..customSurcharge4 = parseDouble(_surcharge4Controller.text));
    if (invoice != widget.viewModel.invoice) {
      _debouncer.run(() {
        widget.viewModel.onChanged!(invoice);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state!;
    final invoice = viewModel.invoice!;
    final company = viewModel.company!;
    final originalInvoice =
        state.getEntity(invoice.entityType, invoice.id) as InvoiceEntity?;

    final client = state.clientState.get(invoice.clientId);
    final settings = getClientSettings(state, client);
    final terms = widget.entityType == EntityType.quote
        ? settings.defaultValidUntil
        : settings.defaultPaymentTerms;
    String? termsString;
    if ((terms ?? '').isNotEmpty) {
      termsString = '${localization.net} $terms';
    }

    return ScrollableListView(
      children: <Widget>[
        FormCard(
          isLast: !company.calculateTaxes,
          children: <Widget>[
            invoice.isNew
                ? invoice.isPurchaseOrder
                    ? VendorPicker(
                        autofocus: true,
                        vendorId: invoice.vendorId,
                        vendorState: state.vendorState,
                        onSelected: (vendor) {
                          viewModel.onVendorChanged!(
                              context, invoice, vendor as VendorEntity?);
                        },
                        onAddPressed: (completer) =>
                            viewModel.onAddVendorPressed!(context, completer),
                      )
                    : ClientPicker(
                        clientId: invoice.clientId,
                        clientState: state.clientState,
                        onSelected: (client) => viewModel.onClientChanged!(
                            context, invoice, client as ClientEntity?),
                        onAddPressed: (completer) =>
                            viewModel.onAddClientPressed!(context, completer),
                      )
                : DecoratedFormField(
                    controller: _invoiceNumberController,
                    label: widget.entityType == EntityType.purchaseOrder
                        ? localization.poNumber
                        : widget.entityType == EntityType.credit
                            ? localization.creditNumber
                            : widget.entityType == EntityType.quote
                                ? localization.quoteNumber
                                : localization.invoiceNumber,
                    keyboardType: TextInputType.text,
                    validator: (String val) => val.trim().isEmpty &&
                            invoice.isOld &&
                            originalInvoice!.number.isNotEmpty
                        ? AppLocalization.of(context)!
                            .pleaseEnterAnInvoiceNumber
                        : null,
                  ),
            UserPicker(
              userId: invoice.assignedUserId,
              onChanged: (userId) => viewModel.onChanged!(
                  invoice.rebuild((b) => b..assignedUserId = userId)),
            ),
            if (invoice.isRecurringInvoice) ...[
              AppDropdownButton<String>(
                  labelText: localization.frequency,
                  value: invoice.frequencyId,
                  onChanged: (dynamic value) {
                    viewModel.onChanged!(
                        invoice.rebuild((b) => b..frequencyId = value));
                  },
                  items: kFrequencies.entries
                      .map((entry) => DropdownMenuItem(
                            value: entry.key,
                            child: Text(localization.lookup(entry.value)),
                          ))
                      .toList()),
              DatePicker(
                labelText: invoice.lastSentDate.isNotEmpty
                    ? localization.nextSendDate
                    : localization.startDate,
                onSelected: (date, _) => viewModel
                    .onChanged!(invoice.rebuild((b) => b..nextSendDate = date)),
                selectedDate: invoice.nextSendDate,
                firstDate: DateTime.now(),
              ),
              AppDropdownButton<int>(
                labelText: localization.remainingCycles,
                value: invoice.remainingCycles,
                blankValue: null,
                onChanged: (dynamic value) => viewModel.onChanged!(
                    invoice.rebuild((b) => b..remainingCycles = value)),
                items: [
                  DropdownMenuItem(
                    child: Text(localization.endless),
                    value: -1,
                  ),
                  ...List<int>.generate(37, (i) => i)
                      .map((value) => DropdownMenuItem(
                            child: Text('$value'),
                            value: value,
                          ))
                      .toList()
                ],
              ),
              AppDropdownButton<String>(
                labelText: localization.dueDate,
                value: invoice.dueDateDays ?? '',
                onChanged: (dynamic value) => viewModel
                    .onChanged!(invoice.rebuild((b) => b..dueDateDays = value)),
                items: [
                  DropdownMenuItem(
                    child: Text(localization.usePaymentTerms),
                    value: 'terms',
                  ),
                  DropdownMenuItem(
                    child: Text(localization.dueOnReceipt),
                    value: 'on_receipt',
                  ),
                  ...List<int>.generate(31, (i) => i + 1)
                      .map((value) => DropdownMenuItem(
                            child: Text(value == 1
                                ? localization.firstDayOfTheMonth
                                : value == 31
                                    ? localization.lastDayOfTheMonth
                                    : localization.dayCount
                                        .replaceFirst(':count', '$value')),
                            value: '$value',
                          ))
                      .toList()
                ],
              ),
            ] else ...[
              DatePicker(
                validator: (String val) => val.trim().isEmpty
                    ? AppLocalization.of(context)!.pleaseSelectADate
                    : null,
                labelText: widget.entityType == EntityType.purchaseOrder
                    ? localization.purchaseOrderDate
                    : widget.entityType == EntityType.credit
                        ? localization.creditDate
                        : widget.entityType == EntityType.quote
                            ? localization.quoteDate
                            : localization.invoiceDate,
                selectedDate: invoice.date,
                onSelected: (date, _) {
                  viewModel.onChanged!(invoice.rebuild((b) => b..date = date));
                },
              ),
              DatePicker(
                labelText: widget.entityType == EntityType.invoice ||
                        widget.entityType == EntityType.purchaseOrder
                    ? localization.dueDate
                    : localization.validUntil,
                selectedDate: invoice.dueDate,
                message: termsString,
                onSelected: (date, _) {
                  viewModel
                      .onChanged!(invoice.rebuild((b) => b..dueDate = date));
                },
              ),
              DecoratedFormField(
                label: localization.partialDeposit,
                controller: _partialController,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                validator: (String value) {
                  final amount = parseDouble(_partialController.text)!;
                  final total = invoice.calculateTotal(
                      precision: precisionForInvoice(state, invoice));
                  if (amount < 0 || (amount != 0 && amount > total)) {
                    return localization.partialValue;
                  } else {
                    return null;
                  }
                },
              ),
              if (invoice.partial > 0)
                DatePicker(
                  labelText: localization.partialDueDate,
                  selectedDate: invoice.partialDueDate,
                  onSelected: (date, _) {
                    viewModel.onChanged!(
                        invoice.rebuild((b) => b..partialDueDate = date));
                  },
                ),
            ],
            if (!invoice.isPurchaseOrder)
              DecoratedFormField(
                label: localization.poNumber,
                controller: _poNumberController,
                keyboardType: TextInputType.text,
              ),
            DiscountField(
              controller: _discountController,
              value: invoice.discount,
              isAmountDiscount: invoice.isAmountDiscount,
              onTypeChanged: (value) => viewModel.onChanged!(
                  invoice.rebuild((b) => b..isAmountDiscount = value)),
            ),
            if (invoice.isRecurringInvoice)
              AppDropdownButton<String>(
                  labelText: localization.autoBill,
                  value: invoice.autoBill,
                  selectedItemBuilder: (invoice.autoBill ?? '').isEmpty
                      ? null
                      : (context) => [
                            SettingsEntity.AUTO_BILL_ALWAYS,
                            SettingsEntity.AUTO_BILL_OPT_OUT,
                            SettingsEntity.AUTO_BILL_OPT_IN,
                            SettingsEntity.AUTO_BILL_OFF,
                          ]
                              .map((type) => Text(localization.lookup(type)))
                              .toList(),
                  onChanged: (dynamic value) => viewModel
                      .onChanged!(invoice.rebuild((b) => b..autoBill = value)),
                  items: [
                    SettingsEntity.AUTO_BILL_ALWAYS,
                    SettingsEntity.AUTO_BILL_OPT_OUT,
                    SettingsEntity.AUTO_BILL_OPT_IN,
                    SettingsEntity.AUTO_BILL_OFF,
                  ]
                      .map((value) => DropdownMenuItem(
                            child: AutobillDropdownMenuItem(type: value),
                            value: value,
                          ))
                      .toList()),
            CustomField(
              controller: _custom1Controller,
              field: CustomFieldType.invoice1,
              value: invoice.customValue1,
            ),
            CustomField(
              controller: _custom2Controller,
              field: CustomFieldType.invoice2,
              value: invoice.customValue2,
            ),
            CustomField(
              controller: _custom3Controller,
              field: CustomFieldType.invoice3,
              value: invoice.customValue3,
            ),
            CustomField(
              controller: _custom4Controller,
              field: CustomFieldType.invoice4,
              value: invoice.customValue4,
            ),
            if (company.hasCustomField(CustomFieldType.surcharge1))
              DecoratedFormField(
                label: company.getCustomFieldLabel(CustomFieldType.surcharge1),
                controller: _surcharge1Controller,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
              ),
            if (company.hasCustomField(CustomFieldType.surcharge2))
              DecoratedFormField(
                controller: _surcharge2Controller,
                label: company.getCustomFieldLabel(CustomFieldType.surcharge2),
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
              ),
            if (company.hasCustomField(CustomFieldType.surcharge3))
              DecoratedFormField(
                label: company.getCustomFieldLabel(CustomFieldType.surcharge3),
                controller: _surcharge3Controller,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
              ),
            if (company.hasCustomField(CustomFieldType.surcharge4))
              DecoratedFormField(
                controller: _surcharge4Controller,
                label: company.getCustomFieldLabel(CustomFieldType.surcharge4),
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
              ),
            if (company.enableFirstInvoiceTaxRate ||
                invoice.taxName1.isNotEmpty)
              TaxRateDropdown(
                onSelected: (taxRate) =>
                    viewModel.onChanged!(invoice.applyTax(taxRate)),
                labelText: localization.tax +
                    (invoice.usesInclusiveTaxes
                        ? ' - ${localization.inclusive}'
                        : ''),
                initialTaxName: invoice.taxName1,
                initialTaxRate: invoice.taxRate1,
              ),
            if (company.enableSecondInvoiceTaxRate ||
                invoice.taxName2.isNotEmpty)
              TaxRateDropdown(
                onSelected: (taxRate) => viewModel
                    .onChanged!(invoice.applyTax(taxRate, isSecond: true)),
                labelText: localization.tax +
                    (invoice.usesInclusiveTaxes
                        ? ' - ${localization.inclusive}'
                        : ''),
                initialTaxName: invoice.taxName2,
                initialTaxRate: invoice.taxRate2,
              ),
            if (company.enableThirdInvoiceTaxRate ||
                invoice.taxName3.isNotEmpty)
              TaxRateDropdown(
                onSelected: (taxRate) => viewModel
                    .onChanged!(invoice.applyTax(taxRate, isThird: true)),
                labelText: localization.tax +
                    (invoice.usesInclusiveTaxes
                        ? ' - ${localization.inclusive}'
                        : ''),
                initialTaxName: invoice.taxName3,
                initialTaxRate: invoice.taxRate3,
              ),
            DesignPicker(
              initialValue: invoice.designId,
              onSelected: (value) => viewModel
                  .onChanged!(invoice.rebuild((b) => b..designId = value!.id)),
            ),
            if (company.isModuleEnabled(EntityType.project))
              ProjectPicker(
                clientId: invoice.clientId,
                projectId: invoice.projectId,
                onChanged: (projectId) {
                  final project = state.projectState.get(projectId);
                  final client = state.clientState.get(project.clientId);

                  if (project.isOld && project.clientId != invoice.clientId) {
                    viewModel.onClientChanged!(
                      context,
                      invoice.rebuild((b) => b..projectId = projectId),
                      client,
                    );
                  } else {
                    viewModel.onChanged!(
                        invoice.rebuild((b) => b..projectId = projectId));
                  }
                },
              ),
            if (invoice.isPurchaseOrder)
              ClientPicker(
                clientId: invoice.clientId,
                clientState: state.clientState,
                onSelected: (client) {
                  viewModel.onChanged!(
                      invoice.rebuild((b) => b..clientId = client?.id ?? ''));
                },
              )
            else if (company.isModuleEnabled(EntityType.vendor))
              EntityDropdown(
                entityType: EntityType.vendor,
                entityId: invoice.vendorId,
                labelText: localization.vendor,
                entityList: memoizedDropdownVendorList(
                    state.vendorState.map,
                    state.vendorState.list,
                    state.userState.map,
                    state.staticState),
                onSelected: (vendor) => viewModel.onChanged!(
                  invoice.rebuild((b) => b.vendorId = vendor?.id ?? ''),
                ),
                onCreateNew: (completer, name) {
                  store.dispatch(SaveVendorRequest(
                      vendor: VendorEntity().rebuild((b) => b..name = name),
                      completer: completer));
                },
              ),
            DecoratedFormField(
              key: ValueKey('__exchange_rate_${invoice.clientId}__'),
              label: localization.exchangeRate,
              initialValue: formatNumber(invoice.exchangeRate, context,
                  formatNumberType: FormatNumberType.inputAmount),
              onChanged: (value) => viewModel.onChanged!(
                  invoice.rebuild((b) => b..exchangeRate = parseDouble(value))),
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
            ),
            if (company.hasTaxes)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SwitchListTile(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  title: Text(localization.inclusiveTaxes),
                  dense: true,
                  value: invoice.usesInclusiveTaxes,
                  onChanged: (value) {
                    viewModel.onChanged!(
                        invoice.rebuild((b) => b..usesInclusiveTaxes = value));
                  },
                ),
              ),
            if (invoice.isInvoice)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SwitchListTile(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  title: Text(localization.autoBillEnabled),
                  dense: true,
                  value: invoice.autoBillEnabled,
                  onChanged: (value) {
                    viewModel.onChanged!(
                        invoice.rebuild((b) => b..autoBillEnabled = value));
                  },
                ),
              ),
          ],
        ),
        if (company.calculateTaxes)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
            child: AppButton(
              label: localization.taxDetails.toUpperCase(),
              onPressed: invoice.hasClient
                  ? () {
                      showDialog<void>(
                          context: context,
                          builder: (context) => InvoiceTaxDetails(
                                invoice: invoice,
                              ));
                    }
                  : null,
            ),
          ),
      ],
    );
  }
}
