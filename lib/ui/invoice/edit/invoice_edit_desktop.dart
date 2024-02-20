// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/vendor_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/autobill_dropdown_menu_item.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:http/http.dart' as http;

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/models/settings_model.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
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
import 'package:invoiceninja_flutter/ui/app/forms/project_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/user_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/vendor_picker.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_contacts_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_tax_details.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/edit/purchase_order_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/edit/recurring_invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:printing/printing.dart';

import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

class InvoiceEditDesktop extends StatefulWidget {
  const InvoiceEditDesktop({
    Key? key,
    required this.viewModel,
    required this.entityViewModel,
  }) : super(key: key);

  final EntityEditDetailsVM viewModel;
  final AbstractInvoiceEditVM entityViewModel;

  @override
  InvoiceEditDesktopState createState() => InvoiceEditDesktopState();
}

class InvoiceEditDesktopState extends State<InvoiceEditDesktop>
    with TickerProviderStateMixin {
  TabController? _optionTabController;
  TabController? _tableTabController;

  bool _selectTasksTable = false;
  bool _showSaveDefault = false;
  late FocusNode _focusNode;

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

    final invoice = widget.viewModel.invoice!;
    final state = widget.viewModel.state!;
    final company = state.company;

    _selectTasksTable = invoice.hasTasks && !invoice.hasProducts;
    _showSaveDefault = invoice.isInvoice ||
        invoice.isQuote ||
        invoice.isCredit ||
        invoice.isPurchaseOrder;

    _focusNode = FocusScopeNode();
    _optionTabController = TabController(
        vsync: this,
        length: company.isModuleEnabled(EntityType.document) ? 6 : 5);
    _tableTabController = TabController(
        vsync: this, length: 2, initialIndex: _selectTasksTable ? 1 : 0);
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
    _optionTabController!.dispose();
    _tableTabController!.dispose();
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
      ..customSurcharge4 = parseDouble(_surcharge4Controller.text)
      ..publicNotes = _publicNotesController.text.trim()
      ..privateNotes = _privateNotesController.text.trim()
      ..terms = _termsController.text.trim()
      ..footer = _footerController.text.trim());
    if (invoice != widget.viewModel.invoice) {
      _debouncer.run(() {
        widget.viewModel.onChanged!(invoice);
      });
    }
  }

  void _onSavePressed(BuildContext context) {
    final viewModel = widget.entityViewModel;
    viewModel.onSavePressed!(context);
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state!;
    final invoice = viewModel.invoice!;
    final company = viewModel.company!;
    final client = state.clientState.get(invoice.clientId);
    final vendor = state.vendorState.get(invoice.vendorId);
    final entityType = invoice.entityType;
    final originalInvoice =
        (state.getEntity(invoice.entityType, invoice.id) as InvoiceEntity?) ??
            invoice;

    final countProducts = invoice.lineItems
        .where((item) =>
            !item.isEmpty && item.typeId != InvoiceItemEntity.TYPE_TASK)
        .length;
    final countTasks = invoice.lineItems
        .where((item) =>
            !item.isEmpty && item.typeId == InvoiceItemEntity.TYPE_TASK)
        .length;

    final showTasksTable = (invoice.hasTasks || company.showTasksTable) &&
        (invoice.isInvoice || invoice.isQuote);

    final settings = getClientSettings(state, client);
    final terms = entityType == EntityType.quote
        ? settings.defaultValidUntil
        : settings.defaultPaymentTerms;
    String? termsString;
    if ((terms ?? '').isNotEmpty) {
      termsString = '${localization.net} $terms';
    }

    return SingleChildScrollView(
      primary: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: Column(
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
                            if (invoice.isPurchaseOrder)
                              VendorPicker(
                                autofocus: true,
                                vendorId: invoice.vendorId,
                                vendorState: state.vendorState,
                                onSelected: (vendor) {
                                  viewModel.onVendorChanged!(context, invoice,
                                      vendor as VendorEntity?);
                                },
                                onAddPressed: (completer) => viewModel
                                    .onAddVendorPressed!(context, completer),
                              )
                            else
                              ClientPicker(
                                autofocus: true,
                                clientId: invoice.clientId,
                                clientState: state.clientState,
                                onSelected: (client) {
                                  viewModel.onClientChanged!(context, invoice,
                                      client as ClientEntity?);
                                },
                                onAddPressed: (completer) => viewModel
                                    .onAddClientPressed!(context, completer),
                              )
                          else
                            InkWell(
                              onLongPress: () => editEntity(
                                  entity: invoice.isPurchaseOrder
                                      ? vendor
                                      : client),
                              onTap: () => viewEntity(
                                  entity: invoice.isPurchaseOrder
                                      ? vendor
                                      : client),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minWidth: double.infinity, minHeight: 40),
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Text(
                                    EntityPresenter()
                                        .initialize(
                                            invoice.isPurchaseOrder
                                                ? vendor
                                                : client,
                                            context)
                                        .title()!,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(height: 12),
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
                                  viewModel.onChanged!(invoice
                                      .rebuild((b) => b..frequencyId = value));
                                },
                                items: kFrequencies.entries
                                    .map((entry) => DropdownMenuItem(
                                          value: entry.key,
                                          child: Text(
                                              localization.lookup(entry.value)),
                                        ))
                                    .toList()),
                            DatePicker(
                              labelText: invoice.lastSentDate.isNotEmpty
                                  ? localization.nextSendDate
                                  : localization.startDate,
                              onSelected: (date, _) {
                                viewModel.onChanged!(invoice
                                    .rebuild((b) => b..nextSendDate = date));
                              },
                              selectedDate: invoice.nextSendDate,
                              firstDate: DateTime.now(),
                            ),
                            AppDropdownButton<int>(
                              labelText: localization.remainingCycles,
                              value: invoice.remainingCycles,
                              blankValue: null,
                              onChanged: (dynamic value) =>
                                  viewModel.onChanged!(invoice.rebuild(
                                      (b) => b..remainingCycles = value)),
                              items: [
                                DropdownMenuItem(
                                  child: Text(localization.endless),
                                  value: -1,
                                ),
                                ...List<int>.generate(61, (i) => i)
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
                              onChanged: (dynamic value) {
                                viewModel.onChanged!(invoice
                                    .rebuild((b) => b..dueDateDays = value));
                              },
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
                                                  ? localization
                                                      .lastDayOfTheMonth
                                                  : localization.dayCount
                                                      .replaceFirst(
                                                          ':count', '$value')),
                                          value: '$value',
                                        ))
                                    .toList()
                              ],
                            ),
                          ] else ...[
                            DatePicker(
                              validator: (String val) => val.trim().isEmpty
                                  ? AppLocalization.of(context)!
                                      .pleaseSelectADate
                                  : null,
                              labelText: entityType == EntityType.purchaseOrder
                                  ? localization.purchaseOrderDate
                                  : entityType == EntityType.credit
                                      ? localization.creditDate
                                      : entityType == EntityType.quote
                                          ? localization.quoteDate
                                          : localization.invoiceDate,
                              selectedDate: invoice.date,
                              onSelected: (date, _) {
                                viewModel.onChanged!(
                                    invoice.rebuild((b) => b..date = date));
                              },
                            ),
                            DatePicker(
                              key: ValueKey('__terms_${client.id}__'),
                              labelText: entityType == EntityType.invoice ||
                                      entityType == EntityType.purchaseOrder
                                  ? localization.dueDate
                                  : localization.validUntil,
                              selectedDate: invoice.dueDate,
                              message: termsString,
                              onSelected: (date, _) {
                                viewModel.onChanged!(
                                    invoice.rebuild((b) => b..dueDate = date));
                              },
                            ),
                            DecoratedFormField(
                              label: localization.partialDeposit,
                              controller: _partialController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true, signed: true),
                              onSavePressed: _onSavePressed,
                              validator: (String value) {
                                final amount =
                                    parseDouble(_partialController.text)!;
                                final total = invoice.calculateTotal(
                                    precision:
                                        precisionForInvoice(state, invoice));
                                if (amount < 0 ||
                                    (amount != 0 && amount > total)) {
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
                                  viewModel.onChanged!(invoice.rebuild(
                                      (b) => b..partialDueDate = date));
                                },
                              ),
                          ],
                          CustomField(
                            controller: _custom1Controller,
                            field: CustomFieldType.invoice1,
                            value: invoice.customValue1,
                            onSavePressed: _onSavePressed,
                          ),
                          CustomField(
                            controller: _custom3Controller,
                            field: CustomFieldType.invoice3,
                            value: invoice.customValue3,
                            onSavePressed: _onSavePressed,
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
                            label: entityType == EntityType.purchaseOrder
                                ? localization.poNumber
                                : entityType == EntityType.credit
                                    ? localization.creditNumber
                                    : entityType == EntityType.quote
                                        ? localization.quoteNumber
                                        : localization.invoiceNumber,
                            validator: (String val) => val.trim().isEmpty &&
                                    invoice.isOld &&
                                    originalInvoice.number.isNotEmpty
                                ? AppLocalization.of(context)!
                                    .pleaseEnterAnInvoiceNumber
                                : null,
                            keyboardType: TextInputType.text,
                            onSavePressed: _onSavePressed,
                          ),
                          if (!invoice.isPurchaseOrder)
                            DecoratedFormField(
                              label: localization.poNumber,
                              controller: _poNumberController,
                              onSavePressed: _onSavePressed,
                              keyboardType: TextInputType.text,
                            ),
                          DiscountField(
                            controller: _discountController,
                            value: invoice.discount,
                            isAmountDiscount: invoice.isAmountDiscount,
                            onTypeChanged: (value) => viewModel.onChanged!(
                                invoice.rebuild(
                                    (b) => b..isAmountDiscount = value)),
                          ),
                          if (entityType == EntityType.recurringInvoice)
                            AppDropdownButton<String>(
                              labelText: localization.autoBill,
                              value: invoice.autoBill,
                              selectedItemBuilder: (invoice.autoBill ?? '')
                                      .isEmpty
                                  ? null
                                  : (context) => [
                                        SettingsEntity.AUTO_BILL_ALWAYS,
                                        SettingsEntity.AUTO_BILL_OPT_OUT,
                                        SettingsEntity.AUTO_BILL_OPT_IN,
                                        SettingsEntity.AUTO_BILL_OFF,
                                      ]
                                          .map((type) =>
                                              Text(localization.lookup(type)))
                                          .toList(),
                              onChanged: (dynamic value) => viewModel
                                      .onChanged!(
                                  invoice.rebuild((b) => b..autoBill = value)),
                              items: [
                                SettingsEntity.AUTO_BILL_ALWAYS,
                                SettingsEntity.AUTO_BILL_OPT_OUT,
                                SettingsEntity.AUTO_BILL_OPT_IN,
                                SettingsEntity.AUTO_BILL_OFF,
                              ]
                                  .map((value) => DropdownMenuItem(
                                        child: AutobillDropdownMenuItem(
                                            type: value),
                                        value: value,
                                      ))
                                  .toList(),
                            ),
                          CustomField(
                            controller: _custom2Controller,
                            field: CustomFieldType.invoice2,
                            value: invoice.customValue2,
                            onSavePressed: _onSavePressed,
                          ),
                          CustomField(
                            controller: _custom4Controller,
                            field: CustomFieldType.invoice4,
                            value: invoice.customValue4,
                            onSavePressed: _onSavePressed,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (showTasksTable)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: AppTabBar(
                      onTap: (index) {
                        setState(() => _selectTasksTable = index == 1);
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
                                  (countProducts > 0
                                      ? ' ($countProducts)'
                                      : '')),
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
                    isTasks: _selectTasksTable,
                  )
                else if (entityType == EntityType.quote)
                  QuoteEditItemsScreen(
                    viewModel: widget.entityViewModel,
                    isTasks: _selectTasksTable,
                  )
                else if (entityType == EntityType.invoice)
                  InvoiceEditItemsScreen(
                    viewModel: widget.entityViewModel,
                    isTasks: _selectTasksTable,
                  )
                else if (entityType == EntityType.recurringInvoice)
                  RecurringInvoiceEditItemsScreen(
                    viewModel: widget.entityViewModel,
                    isTasks: _selectTasksTable,
                  )
                else if (entityType == EntityType.purchaseOrder)
                  PurchaseOrderEditItemsScreen(
                    viewModel: widget.entityViewModel,
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
                              Tab(text: localization.terms),
                              Tab(text: localization.footer),
                              Tab(text: localization.publicNotes),
                              Tab(text: localization.privateNotes),
                              Tab(text: localization.settings),
                              if (company.isModuleEnabled(EntityType.document))
                                Tab(
                                    text: localization.documents +
                                        (invoice.documents.isNotEmpty
                                            ? ' (${invoice.documents.length})'
                                            : '')),
                            ],
                          ),
                          SizedBox(
                            height: 186,
                            child: TabBarView(
                              controller: _optionTabController,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Expanded(
                                      child: DecoratedFormField(
                                        maxLines: _showSaveDefault ? 5 : 8,
                                        controller: _termsController,
                                        keyboardType: TextInputType.multiline,
                                        hint: invoice.isOld &&
                                                !invoice.isRecurringInvoice
                                            ? ''
                                            : settings.getDefaultTerms(
                                                invoice.entityType),
                                      ),
                                    ),
                                    if (_showSaveDefault) ...[
                                      SizedBox(height: 8),
                                      CheckboxListTile(
                                        dense: true,
                                        value: invoice.saveDefaultTerms,
                                        title: Text(
                                            localization.saveAsDefaultTerms),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        onChanged: (value) {
                                          viewModel.onChanged!(invoice.rebuild(
                                              (b) =>
                                                  b..saveDefaultTerms = value));
                                        },
                                      ),
                                    ],
                                  ],
                                ),
                                Column(
                                  children: [
                                    Expanded(
                                      child: DecoratedFormField(
                                        maxLines: _showSaveDefault ? 5 : 8,
                                        controller: _footerController,
                                        keyboardType: TextInputType.multiline,
                                        hint: invoice.isOld &&
                                                !invoice.isRecurringInvoice
                                            ? ''
                                            : settings.getDefaultFooter(
                                                invoice.entityType),
                                      ),
                                    ),
                                    if (_showSaveDefault) ...[
                                      SizedBox(height: 8),
                                      CheckboxListTile(
                                        dense: true,
                                        value: invoice.saveDefaultFooter,
                                        title: Text(
                                            localization.saveAsDefaultFooter),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        onChanged: (value) {
                                          viewModel.onChanged!(invoice.rebuild(
                                              (b) => b
                                                ..saveDefaultFooter = value));
                                        },
                                      ),
                                    ],
                                  ],
                                ),
                                DecoratedFormField(
                                  maxLines: 8,
                                  controller: _publicNotesController,
                                  keyboardType: TextInputType.multiline,
                                  hint: client.publicNotes,
                                ),
                                DecoratedFormField(
                                  maxLines: 8,
                                  controller: _privateNotesController,
                                  keyboardType: TextInputType.multiline,
                                ),
                                LayoutBuilder(builder: (context, constraints) {
                                  return GridView.count(
                                    physics: NeverScrollableScrollPhysics(),
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: kTableColumnGap,
                                    shrinkWrap: true,
                                    primary: true,
                                    crossAxisCount: 2,
                                    childAspectRatio:
                                        ((constraints.maxWidth / 2) - 8) / 50,
                                    children: [
                                      DesignPicker(
                                        initialValue: invoice.designId,
                                        onSelected: (value) {
                                          viewModel.onChanged!(invoice.rebuild(
                                              (b) => b..designId = value!.id));
                                        },
                                      ),
                                      UserPicker(
                                        userId: invoice.assignedUserId,
                                        onChanged: (userId) => viewModel
                                            .onChanged!(invoice.rebuild((b) => b
                                          ..assignedUserId = userId)),
                                      ),
                                      if (company
                                          .isModuleEnabled(EntityType.project))
                                        ProjectPicker(
                                          clientId: invoice.clientId,
                                          projectId: invoice.projectId,
                                          onChanged: (projectId) {
                                            final project = store
                                                .state.projectState
                                                .get(projectId);
                                            final client = state.clientState
                                                .get(project.clientId);

                                            if (project.isOld &&
                                                project.clientId !=
                                                    invoice.clientId) {
                                              viewModel.onClientChanged!(
                                                context,
                                                invoice.rebuild((b) =>
                                                    b..projectId = projectId),
                                                client,
                                              );
                                            } else {
                                              viewModel.onChanged!(
                                                  invoice.rebuild((b) => b
                                                    ..projectId = projectId));
                                            }
                                          },
                                        ),
                                      if (invoice.isPurchaseOrder)
                                        ClientPicker(
                                          clientId: invoice.clientId,
                                          clientState: state.clientState,
                                          onSelected: (client) {
                                            viewModel.onChanged!(
                                                invoice.rebuild((b) => b
                                                  ..clientId =
                                                      client?.id ?? ''));
                                          },
                                        )
                                      else if (company
                                          .isModuleEnabled(EntityType.vendor))
                                        EntityDropdown(
                                          entityType: EntityType.vendor,
                                          entityId: invoice.vendorId,
                                          labelText: localization.vendor,
                                          entityList:
                                              memoizedDropdownVendorList(
                                                  state.vendorState.map,
                                                  state.vendorState.list,
                                                  state.userState.map,
                                                  state.staticState),
                                          onSelected: (vendor) =>
                                              viewModel.onChanged!(
                                            invoice.rebuild((b) =>
                                                b.vendorId = vendor?.id ?? ''),
                                          ),
                                          onCreateNew: (completer, name) {
                                            store.dispatch(SaveVendorRequest(
                                                vendor: VendorEntity().rebuild(
                                                    (b) => b..name = name),
                                                completer: completer));
                                          },
                                        ),
                                      DecoratedFormField(
                                        key: ValueKey(
                                            '__exchange_rate_${invoice.clientId}__'),
                                        label: localization.exchangeRate,
                                        initialValue: formatNumber(
                                            invoice.exchangeRate, context,
                                            formatNumberType:
                                                FormatNumberType.inputMoney),
                                        onChanged: (value) => viewModel
                                            .onChanged!(invoice.rebuild((b) => b
                                          ..exchangeRate = parseDouble(value))),
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        onSavePressed: _onSavePressed,
                                      ),
                                      if (company.hasTaxes || invoice.isInvoice)
                                        Column(
                                          children: [
                                            if (company.hasTaxes)
                                              Expanded(
                                                child: Tooltip(
                                                  message: localization
                                                      .inclusiveTaxes,
                                                  child: SwitchListTile(
                                                    dense: true,
                                                    activeColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                    title: Text(
                                                      localization
                                                          .inclusiveTaxes,
                                                      maxLines: 1,
                                                    ),
                                                    value: invoice
                                                        .usesInclusiveTaxes,
                                                    onChanged: (value) {
                                                      viewModel.onChanged!(
                                                          invoice.rebuild((b) => b
                                                            ..usesInclusiveTaxes =
                                                                value));
                                                    },
                                                  ),
                                                ),
                                              ),
                                            if (invoice.isInvoice)
                                              Expanded(
                                                child: Tooltip(
                                                  message: localization
                                                      .autoBillEnabled,
                                                  child: SwitchListTile(
                                                    dense: true,
                                                    activeColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                    title: Text(
                                                      localization
                                                          .autoBillEnabled,
                                                      maxLines: 1,
                                                    ),
                                                    value:
                                                        invoice.autoBillEnabled,
                                                    onChanged: (value) {
                                                      viewModel.onChanged!(
                                                          invoice.rebuild((b) => b
                                                            ..autoBillEnabled =
                                                                value));
                                                    },
                                                  ),
                                                ),
                                              ),
                                          ],
                                        )
                                    ],
                                  );
                                }),
                                if (company
                                    .isModuleEnabled(EntityType.document))
                                  if (invoice.isNew || state.hasChanges())
                                    HelpText(localization.saveToUploadDocuments)
                                  else
                                    DocumentGrid(
                                      documents:
                                          originalInvoice.documents.toList(),
                                      onUploadDocument: (path, isPrivate) =>
                                          widget.entityViewModel
                                                  .onUploadDocuments!(
                                              context, path, isPrivate),
                                      onRenamedDocument: () => store.dispatch(
                                          LoadInvoice(invoiceId: invoice.id)),
                                    )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                        precision: precisionForInvoice(
                                            state, invoice)),
                                    context,
                                    clientId: invoice.isPurchaseOrder
                                        ? null
                                        : invoice.clientId,
                                    vendorId: invoice.isPurchaseOrder
                                        ? invoice.vendorId
                                        : null,
                                  ),
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
                                        '__invoice_paid_to_date_${originalInvoice.paidToDate}_${invoice.clientId}__'),
                                    initialValue: formatNumber(
                                      originalInvoice.paidToDate,
                                      context,
                                      clientId: invoice.isPurchaseOrder
                                          ? null
                                          : invoice.clientId,
                                      vendorId: invoice.isPurchaseOrder
                                          ? invoice.vendorId
                                          : null,
                                    ),
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
                                    onSelected: (taxRate) {
                                      viewModel.onChanged!(
                                          invoice.applyTax(taxRate));
                                    },
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
                                    onSelected: (taxRate) {
                                      viewModel.onChanged!(invoice
                                          .applyTax(taxRate, isSecond: true));
                                    },
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
                                    onSelected: (taxRate) {
                                      viewModel.onChanged!(invoice
                                          .applyTax(taxRate, isThird: true));
                                    },
                                    labelText: localization.tax +
                                        (invoice.usesInclusiveTaxes
                                            ? ' - ${localization.inclusive}'
                                            : ''),
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
                                    onSavePressed: _onSavePressed,
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
                                      '__invoice_total_${originalInvoice.paidToDate}_${invoice.calculateTotal(precision: precisionForInvoice(state, invoice))}_${invoice.clientId}__'),
                                  initialValue: formatNumber(
                                    invoice.calculateTotal(
                                            precision: precisionForInvoice(
                                                state, invoice)) -
                                        originalInvoice.paidToDate,
                                    context,
                                    clientId: invoice.isPurchaseOrder
                                        ? null
                                        : invoice.clientId,
                                    vendorId: invoice.isPurchaseOrder
                                        ? invoice.vendorId
                                        : null,
                                  ),
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
                                    initialValue: formatNumber(
                                      invoice.partial,
                                      context,
                                      clientId: invoice.isPurchaseOrder
                                          ? null
                                          : invoice.clientId,
                                      vendorId: invoice.isPurchaseOrder
                                          ? invoice.vendorId
                                          : null,
                                    ),
                                  ),
                              ]),
                          if (company.calculateTaxes)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 16),
                              child: AppButton(
                                label: localization.taxDetails.toUpperCase(),
                                onPressed: invoice.hasClient
                                    ? () {
                                        showDialog<void>(
                                            context: context,
                                            builder: (context) =>
                                                InvoiceTaxDetails(
                                                  invoice: invoice,
                                                ));
                                      }
                                    : null,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (state.prefState.showPdfPreview &&
                    !state.prefState.showPdfPreviewSideBySide)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: _PdfPreview(invoice: invoice),
                  ),
              ],
            ),
          ),
          if (state.prefState.showPdfPreview &&
              state.prefState.showPdfPreviewSideBySide)
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 16, top: 2),
                child: _PdfPreview(invoice: invoice),
              ),
            ),
        ],
      ),
    );
  }
}

class _PdfPreview extends StatefulWidget {
  const _PdfPreview({Key? key, required this.invoice}) : super(key: key);

  final InvoiceEntity invoice;

  @override
  __PdfPreviewState createState() => __PdfPreviewState();
}

class __PdfPreviewState extends State<_PdfPreview> {
  final _pdfDebouncer =
      SimpleDebouncer(milliseconds: kMillisecondsToDebounceSave);

  int _pageCount = 1;
  int _currentPage = 1;
  String? _pdfString;
  http.Response? _response;
  bool _isLoading = false;
  bool _pendingLoad = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    loadPdf();
  }

  @override
  void didUpdateWidget(_PdfPreview oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.invoice != oldWidget.invoice) {
      loadPdf();
    }
  }

  void loadPdf() async {
    if (_response == null) {
      _loadPdf();
    } else {
      _pdfDebouncer.run(() {
        _loadPdf();
      });
    }
  }

  void _loadPdf() async {
    final invoice = widget.invoice;

    if (invoice.isPurchaseOrder) {
      if (!invoice.hasVendor) {
        return;
      }
    } else if (!invoice.hasClient) {
      return;
    }

    if (_isLoading) {
      _pendingLoad = true;
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final credentials = state.credentials;
    final webClient = WebClient();

    String url = '';
    if (state.isHosted && !state.isStaging) {
      url = 'https://preview.invoicing.co/api/v1/live_preview';
    } else {
      url = '${credentials.url}/live_preview';
    }

    if (invoice.isPurchaseOrder) {
      url += '/purchase_order';
    }

    url += '?entity=${invoice.entityType!.snakeCase}';

    if (invoice.isOld) {
      url += '&entity_id=${invoice.id}';
    }

    final data = serializers.serializeWith(InvoiceEntity.serializer, invoice);
    webClient
        .post(url, credentials.token,
            data: json.encode(data), rawResponse: true)
        .then((dynamic response) async {
      final pages = await Printing.raster(response.bodyBytes, dpi: 5).toList();
      setState(() {
        _isLoading = false;
        _response = response;
        _pageCount = pages.length;
        if (_currentPage > _pageCount) {
          _currentPage = _pageCount;
        }

        if (kIsWeb && state.prefState.enableNativeBrowser) {
          _pdfString =
              'data:application/pdf;base64,' + base64Encode(response.bodyBytes);
          WebUtils.registerWebView(_pdfString);
        }

        if (_pendingLoad) {
          _pendingLoad = false;
          _loadPdf();
        }
      });
    }).catchError((dynamic error) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    return Container(
      height: state.prefState.showPdfPreviewSideBySide ? 800 : 1150,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_pageCount > 1 &&
                  (!kIsWeb || !state.prefState.enableNativeBrowser))
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                          width: 180,
                          label: localization!.previousPage,
                          iconData: MdiIcons.pagePrevious,
                          onPressed: _currentPage == 1
                              ? null
                              : () {
                                  setState(() {
                                    _currentPage--;
                                  });
                                }),
                      SizedBox(width: kTableColumnGap),
                      AppButton(
                          width: 180,
                          label: localization.nextPage,
                          iconData: MdiIcons.pageNext,
                          onPressed: _currentPage == _pageCount
                              ? null
                              : () {
                                  setState(() {
                                    _currentPage++;
                                  });
                                }),
                    ],
                  ),
                ),
              Expanded(
                child: _response == null
                    ? Container(
                        color: Colors.grey.shade300,
                      )
                    : (kIsWeb && state.prefState.enableNativeBrowser)
                        ? HtmlElementView(viewType: _pdfString!)
                        : PdfPreview(
                            build: (format) => _response!.bodyBytes,
                            canChangeOrientation: false,
                            canChangePageFormat: false,
                            allowPrinting: false,
                            allowSharing: false,
                            canDebug: false,
                            pages: [_currentPage - 1],
                            maxPageWidth: 800,
                          ),
              ),
            ],
          ),
          if (_isLoading && _response == null)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (_isLoading) LinearProgressIndicator(),
        ],
      ),
    );
  }
}
