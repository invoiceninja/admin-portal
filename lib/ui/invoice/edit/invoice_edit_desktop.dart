import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/settings_model.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_tab_bar.dart';
import 'package:invoiceninja_flutter/ui/app/forms/client_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_surcharges.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/design_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/discount_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/user_picker.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_contacts_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/edit/recurring_invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceEditDesktop extends StatefulWidget {
  const InvoiceEditDesktop({
    Key key,
    @required this.viewModel,
    @required this.entityViewModel,
  }) : super(key: key);

  final EntityEditDetailsVM viewModel;
  final EntityEditVM entityViewModel;

  @override
  InvoiceEditDesktopState createState() => InvoiceEditDesktopState();
}

class InvoiceEditDesktopState extends State<InvoiceEditDesktop>
    with TickerProviderStateMixin {
  TabController _optionTabController;
  TabController _tableTabController;

  bool _showTasksTable = false;
  FocusNode _focusNode;

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
  final _publicNotesController = TextEditingController();
  final _privateNotesController = TextEditingController();
  final _termsController = TextEditingController();
  final _footerController = TextEditingController();

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();

  @override
  void initState() {
    super.initState();

    final invoice = widget.viewModel.invoice;
    _showTasksTable = invoice.hasTasks;

    _focusNode = FocusScopeNode();
    _optionTabController = TabController(vsync: this, length: 5);
    _tableTabController = TabController(
        vsync: this, length: 2, initialIndex: _showTasksTable ? 1 : 0);
  }

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
      _publicNotesController,
      _privateNotesController,
      _termsController,
      _footerController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final invoice = widget.viewModel.invoice;
    _invoiceNumberController.text = invoice.number;
    _poNumberController.text = invoice.poNumber;
    _discountController.text = formatNumber(invoice.discount, context,
        formatNumberType: FormatNumberType.inputMoney);
    _partialController.text = formatNumber(invoice.partial, context,
        formatNumberType: FormatNumberType.inputMoney);
    _custom1Controller.text = invoice.customValue1;
    _custom2Controller.text = invoice.customValue2;
    _custom3Controller.text = invoice.customValue3;
    _custom4Controller.text = invoice.customValue4;
    _surcharge1Controller.text = formatNumber(invoice.customSurcharge1, context,
        formatNumberType: FormatNumberType.inputMoney);
    _surcharge2Controller.text = formatNumber(invoice.customSurcharge2, context,
        formatNumberType: FormatNumberType.inputMoney);
    _surcharge3Controller.text = formatNumber(invoice.customSurcharge3, context,
        formatNumberType: FormatNumberType.inputMoney);
    _surcharge4Controller.text = formatNumber(invoice.customSurcharge4, context,
        formatNumberType: FormatNumberType.inputMoney);
    _publicNotesController.text = invoice.publicNotes;
    _privateNotesController.text = invoice.privateNotes;
    _termsController.text = invoice.terms;
    _footerController.text = invoice.footer;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _optionTabController.dispose();
    _tableTabController.dispose();
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    final invoice = widget.viewModel.invoice.rebuild((b) => b
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
      ..customSurcharge4 = parseDouble(_surcharge4Controller.text)
      ..publicNotes = _publicNotesController.text.trim()
      ..privateNotes = _privateNotesController.text.trim()
      ..terms = _termsController.text.trim()
      ..footer = _footerController.text.trim());
    if (invoice != widget.viewModel.invoice) {
      _debouncer.run(() {
        widget.viewModel.onChanged(invoice);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final invoice = viewModel.invoice;
    final company = viewModel.company;
    final client = state.clientState.get(invoice.clientId);
    final entityType = invoice.entityType;
    final originalInvoice =
        state.getEntity(invoice.entityType, invoice.id) as InvoiceEntity;

    final countProducts = invoice.lineItems
        .where((item) =>
            !item.isEmpty && item.typeId != InvoiceItemEntity.TYPE_TASK)
        .length;
    final countTasks = invoice.lineItems
        .where((item) =>
            !item.isEmpty && item.typeId == InvoiceItemEntity.TYPE_TASK)
        .length;

    final settings = SettingsEntity(
      clientSettings: client.settings,
      groupSettings: state.groupState.get(client.groupId).settings,
      companySettings: state.company.settings,
    );

    final terms = entityType == EntityType.quote
        ? settings.defaultValidUntil
        : settings.defaultPaymentTerms;
    String termsString;
    if ((terms ?? '').isNotEmpty) {
      termsString = '${localization.net} $terms';
    }

    return ScrollableListView(
      key: ValueKey('__invoice_${invoice.id}__'),
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: FormCard(
                crossAxisAlignment: CrossAxisAlignment.start,
                padding: const EdgeInsets.only(
                    top: kMobileDialogPadding,
                    right: kMobileDialogPadding / 2,
                    bottom: kMobileDialogPadding,
                    left: kMobileDialogPadding),
                children: <Widget>[
                  if (invoice.isNew)
                    ClientPicker(
                      //autofocus: true,
                      clientId: invoice.clientId,
                      clientState: state.clientState,
                      onSelected: (client) =>
                          viewModel.onClientChanged(context, invoice, client),
                      onAddPressed: (completer) =>
                          viewModel.onAddClientPressed(context, completer),
                    )
                  else if (client.name.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        EntityPresenter().initialize(client, context).title,
                        style: Theme.of(context).textTheme.headline6,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 186),
                    child: InvoiceEditContactsScreen(
                      entityType: invoice.entityType,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FormCard(
                padding: const EdgeInsets.only(
                    top: kMobileDialogPadding,
                    right: kMobileDialogPadding / 2,
                    bottom: kMobileDialogPadding,
                    left: kMobileDialogPadding / 2),
                children: <Widget>[
                  if (entityType == EntityType.recurringInvoice) ...[
                    AppDropdownButton<String>(
                        labelText: localization.frequency,
                        value: invoice.frequencyId,
                        onChanged: (dynamic value) {
                          viewModel.onChanged(
                              invoice.rebuild((b) => b..frequencyId = value));
                        },
                        items: kFrequencies.entries
                            .map((entry) => DropdownMenuItem(
                                  value: entry.key,
                                  child: Text(localization.lookup(entry.value)),
                                ))
                            .toList()),
                    DatePicker(
                      labelText: (invoice.lastSentDate ?? '').isNotEmpty
                          ? localization.nextSendDate
                          : localization.startDate,
                      onSelected: (date) => viewModel.onChanged(
                          invoice.rebuild((b) => b..nextSendDate = date)),
                      selectedDate: invoice.nextSendDate,
                      firstDate: DateTime.now(),
                    ),
                    AppDropdownButton<int>(
                      showUseDefault: true,
                      labelText: localization.remainingCycles,
                      value: invoice.remainingCycles,
                      blankValue: null,
                      onChanged: (dynamic value) => viewModel.onChanged(
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
                      onChanged: (dynamic value) => viewModel.onChanged(
                          invoice.rebuild((b) => b..dueDateDays = value)),
                      items: [
                        DropdownMenuItem(
                          child: Text(localization.usePaymentTerms),
                          value: 'terms',
                        ),
                        ...List<int>.generate(31, (i) => i + 1)
                            .map((value) => DropdownMenuItem(
                                  child: Text(value == 1
                                      ? localization.firstDayOfTheMonth
                                      : value == 31
                                          ? localization.lastDayOfTheMonth
                                          : localization.dayCount.replaceFirst(
                                              ':count', '$value')),
                                  value: '$value',
                                ))
                            .toList()
                      ],
                    ),
                  ] else ...[
                    DatePicker(
                      validator: (String val) => val.trim().isEmpty
                          ? AppLocalization.of(context).pleaseSelectADate
                          : null,
                      labelText: entityType == EntityType.credit
                          ? localization.creditDate
                          : entityType == EntityType.quote
                              ? localization.quoteDate
                              : localization.invoiceDate,
                      selectedDate: invoice.date,
                      onSelected: (date) {
                        viewModel
                            .onChanged(invoice.rebuild((b) => b..date = date));
                      },
                    ),
                    if (entityType != EntityType.credit)
                      DatePicker(
                        key: ValueKey('__terms_${client.id}__'),
                        labelText: entityType == EntityType.quote
                            ? localization.validUntil
                            : localization.dueDate,
                        selectedDate: invoice.dueDate,
                        message: termsString,
                        onSelected: (date) {
                          viewModel.onChanged(
                              invoice.rebuild((b) => b..dueDate = date));
                        },
                      ),
                    DecoratedFormField(
                      label: localization.partialDeposit,
                      controller: _partialController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onSavePressed: widget.entityViewModel.onSavePressed,
                      validator: (String value) {
                        final amount = parseDouble(_partialController.text);
                        final total = invoice.calculateTotal(
                            precision: precisionForInvoice(state, invoice));
                        if (amount < 0 || (amount != 0 && amount > total)) {
                          return localization.partialValue;
                        } else {
                          return null;
                        }
                      },
                    ),
                    if (invoice.partial != null && invoice.partial > 0)
                      DatePicker(
                        labelText: localization.partialDueDate,
                        selectedDate: invoice.partialDueDate,
                        onSelected: (date) {
                          viewModel.onChanged(
                              invoice.rebuild((b) => b..partialDueDate = date));
                        },
                      ),
                  ],
                  CustomField(
                    controller: _custom1Controller,
                    field: CustomFieldType.invoice1,
                    value: invoice.customValue1,
                    onSavePressed: widget.entityViewModel.onSavePressed,
                  ),
                  CustomField(
                    controller: _custom3Controller,
                    field: CustomFieldType.invoice3,
                    value: invoice.customValue3,
                    onSavePressed: widget.entityViewModel.onSavePressed,
                  ),
                ],
              ),
            ),
            Expanded(
              child: FormCard(
                padding: const EdgeInsets.only(
                    top: kMobileDialogPadding,
                    right: kMobileDialogPadding,
                    bottom: kMobileDialogPadding,
                    left: kMobileDialogPadding / 2),
                children: <Widget>[
                  DecoratedFormField(
                    controller: _invoiceNumberController,
                    label: entityType == EntityType.credit
                        ? localization.creditNumber
                        : entityType == EntityType.quote
                            ? localization.quoteNumber
                            : localization.invoiceNumber,
                    validator: (String val) => val.trim().isEmpty &&
                            invoice.isOld &&
                            originalInvoice.number.isNotEmpty
                        ? AppLocalization.of(context).pleaseEnterAnInvoiceNumber
                        : null,
                    onSavePressed: widget.entityViewModel.onSavePressed,
                  ),
                  DecoratedFormField(
                    label: localization.poNumber,
                    controller: _poNumberController,
                    onSavePressed: widget.entityViewModel.onSavePressed,
                  ),
                  DiscountField(
                    controller: _discountController,
                    value: invoice.discount,
                    isAmountDiscount: invoice.isAmountDiscount,
                    onTypeChanged: (value) => viewModel.onChanged(
                        invoice.rebuild((b) => b..isAmountDiscount = value)),
                  ),
                  if (entityType == EntityType.recurringInvoice)
                    AppDropdownButton<String>(
                        labelText: localization.autoBill,
                        value: invoice.autoBill,
                        onChanged: (dynamic value) => viewModel.onChanged(
                            invoice.rebuild((b) => b..autoBill = value)),
                        items: [
                          SettingsEntity.AUTO_BILL_ALWAYS,
                          SettingsEntity.AUTO_BILL_OPT_OUT,
                          SettingsEntity.AUTO_BILL_OPT_IN,
                          SettingsEntity.AUTO_BILL_OFF,
                        ]
                            .map((value) => DropdownMenuItem(
                                  child: Text(localization.lookup(value)),
                                  value: value,
                                ))
                            .toList()),
                  CustomField(
                    controller: _custom2Controller,
                    field: CustomFieldType.invoice2,
                    value: invoice.customValue2,
                    onSavePressed: widget.entityViewModel.onSavePressed,
                  ),
                  CustomField(
                    controller: _custom4Controller,
                    field: CustomFieldType.invoice4,
                    value: invoice.customValue4,
                    onSavePressed: widget.entityViewModel.onSavePressed,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (invoice.isInvoice &&
            (invoice.hasTasks ||
                invoice.lineItems.any((item) => item.isTask) ||
                (company.showTasksTable ?? false)))
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: AppTabBar(
              onTap: (index) {
                setState(() => _showTasksTable = index == 1);
              },
              controller: _tableTabController,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(getEntityIcon(EntityType.product)),
                      SizedBox(width: 8),
                      Text(localization.products +
                          (countProducts > 0 ? ' ($countProducts)' : '')),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(getEntityIcon(EntityType.task)),
                      SizedBox(width: 8),
                      Text(localization.tasks +
                          (countTasks > 0 ? ' ($countTasks)' : '')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        if (entityType == EntityType.credit)
          CreditEditItemsScreen(
            viewModel: widget.entityViewModel,
            isTasks: _showTasksTable,
          )
        else if (entityType == EntityType.quote)
          QuoteEditItemsScreen(
            viewModel: widget.entityViewModel,
          )
        else if (entityType == EntityType.invoice)
          InvoiceEditItemsScreen(
            viewModel: widget.entityViewModel,
            isTasks: _showTasksTable,
          )
        else if (entityType == EntityType.recurringInvoice)
          RecurringInvoiceEditItemsScreen(
            viewModel: widget.entityViewModel,
            isTasks: _showTasksTable,
          )
        else
          SizedBox(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: FormCard(
                padding: const EdgeInsets.only(
                    top: kMobileDialogPadding,
                    right: kMobileDialogPadding / 2,
                    bottom: kMobileDialogPadding,
                    left: kMobileDialogPadding),
                children: <Widget>[
                  AppTabBar(
                    isScrollable: true,
                    controller: _optionTabController,
                    tabs: [
                      Tab(
                          text: entityType == EntityType.credit
                              ? localization.creditTerms
                              : entityType == EntityType.quote
                                  ? localization.quoteTerms
                                  : localization.invoiceTerms),
                      Tab(
                          text: entityType == EntityType.credit
                              ? localization.creditFooter
                              : entityType == EntityType.quote
                                  ? localization.quoteFooter
                                  : localization.invoiceFooter),
                      Tab(text: localization.publicNotes),
                      Tab(text: localization.privateNotes),
                      Tab(text: localization.settings),
                    ],
                  ),
                  SizedBox(
                    height: 125,
                    child: TabBarView(
                      controller: _optionTabController,
                      children: <Widget>[
                        DecoratedFormField(
                          maxLines: 6,
                          controller: _termsController,
                          keyboardType: TextInputType.multiline,
                          label: '',
                          hint: invoice.isOld
                              ? ''
                              : settings.getDefaultTerms(invoice.entityType),
                        ),
                        DecoratedFormField(
                          maxLines: 6,
                          controller: _footerController,
                          keyboardType: TextInputType.multiline,
                          label: '',
                          hint: invoice.isOld
                              ? ''
                              : settings.getDefaultFooter(invoice.entityType),
                        ),
                        DecoratedFormField(
                          maxLines: 6,
                          controller: _publicNotesController,
                          keyboardType: TextInputType.multiline,
                          label: '',
                          hint: client.publicNotes,
                        ),
                        DecoratedFormField(
                          maxLines: 6,
                          controller: _privateNotesController,
                          keyboardType: TextInputType.multiline,
                          label: '',
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: DesignPicker(
                                    initialValue: invoice.designId,
                                    onSelected: (value) => viewModel.onChanged(
                                        invoice.rebuild(
                                            (b) => b..designId = value.id)),
                                  ),
                                ),
                                SizedBox(
                                  width: 38,
                                ),
                                Expanded(
                                  child: UserPicker(
                                    userId: invoice.assignedUserId,
                                    onChanged: (userId) => viewModel.onChanged(
                                        invoice.rebuild(
                                            (b) => b..assignedUserId = userId)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: DecoratedFormField(
                                    key: ValueKey(
                                        '__exchange_rate_${invoice.clientId}__'),
                                    label: localization.exchangeRate,
                                    initialValue: formatNumber(
                                        invoice.exchangeRate, context,
                                        formatNumberType:
                                            FormatNumberType.inputMoney),
                                    onChanged: (value) => viewModel.onChanged(
                                        invoice.rebuild((b) => b
                                          ..exchangeRate = parseDouble(value))),
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    onSavePressed:
                                        widget.entityViewModel.onSavePressed,
                                  ),
                                ),
                                SizedBox(
                                  width: 38,
                                ),
                                Expanded(
                                  child: SizedBox(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  FormCard(
                    padding: const EdgeInsets.only(
                        top: kMobileDialogPadding,
                        right: kMobileDialogPadding,
                        left: kMobileDialogPadding / 2),
                    children: <Widget>[
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: localization.subtotal,
                        ),
                        textAlign: TextAlign.end,
                        key: ValueKey(
                            '__invoice_subtotal_${invoice.calculateSubtotal(precision: precisionForInvoice(state, invoice))}_${invoice.clientId}__'),
                        initialValue: formatNumber(
                            invoice.calculateSubtotal(
                                precision: precisionForInvoice(state, invoice)),
                            context,
                            clientId: invoice.clientId),
                      ),
                      if (invoice.isOld &&
                          (invoice.isInvoice || invoice.isQuote))
                        TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: localization.paidToDate,
                          ),
                          textAlign: TextAlign.end,
                          key: ValueKey(
                              '__invoice_paid_to_date_${invoice.paidToDate}_${invoice.clientId}__'),
                          initialValue: formatNumber(
                              invoice.paidToDate, context,
                              clientId: invoice.clientId),
                        ),
                      if (company.hasCustomSurcharge)
                        CustomSurcharges(
                          surcharge1Controller: _surcharge1Controller,
                          surcharge2Controller: _surcharge2Controller,
                          surcharge3Controller: _surcharge3Controller,
                          surcharge4Controller: _surcharge4Controller,
                        ),
                      if (company.enableFirstInvoiceTaxRate ||
                          invoice.taxName1.isNotEmpty)
                        TaxRateDropdown(
                          onSelected: (taxRate) =>
                              viewModel.onChanged(invoice.applyTax(taxRate)),
                          labelText: localization.tax,
                          initialTaxName: invoice.taxName1,
                          initialTaxRate: invoice.taxRate1,
                        ),
                      if (company.enableSecondInvoiceTaxRate ||
                          invoice.taxName2.isNotEmpty)
                        TaxRateDropdown(
                          onSelected: (taxRate) => viewModel.onChanged(
                              invoice.applyTax(taxRate, isSecond: true)),
                          labelText: localization.tax,
                          initialTaxName: invoice.taxName2,
                          initialTaxRate: invoice.taxRate2,
                        ),
                      if (company.enableThirdInvoiceTaxRate ||
                          invoice.taxName3.isNotEmpty)
                        TaxRateDropdown(
                          onSelected: (taxRate) => viewModel.onChanged(
                              invoice.applyTax(taxRate, isThird: true)),
                          labelText: localization.tax,
                          initialTaxName: invoice.taxName3,
                          initialTaxRate: invoice.taxRate3,
                        ),
                      if (company.hasCustomSurcharge)
                        CustomSurcharges(
                          surcharge1Controller: _surcharge1Controller,
                          surcharge2Controller: _surcharge2Controller,
                          surcharge3Controller: _surcharge3Controller,
                          surcharge4Controller: _surcharge4Controller,
                          isAfterTaxes: true,
                          onSavePressed: widget.entityViewModel.onSavePressed,
                        ),
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: invoice.isQuote
                              ? localization.total
                              : localization.balanceDue,
                        ),
                        textAlign: TextAlign.end,
                        key: ValueKey(
                            '__invoice_total_${invoice.calculateTotal(precision: precisionForInvoice(state, invoice))}_${invoice.clientId}__'),
                        initialValue: formatNumber(
                            invoice.calculateTotal(
                                    precision:
                                        precisionForInvoice(state, invoice)) -
                                invoice.paidToDate,
                            context,
                            clientId: invoice.clientId),
                      ),
                      if (invoice.partial != 0)
                        TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: localization.partialDue,
                          ),
                          textAlign: TextAlign.end,
                          key: ValueKey(
                              '__invoice_total_${invoice.partial}_${invoice.clientId}__'),
                          initialValue: formatNumber(invoice.partial, context,
                              clientId: invoice.clientId),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
