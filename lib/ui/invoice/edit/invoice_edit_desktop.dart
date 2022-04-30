// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:http/http.dart' as http;

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/models/settings_model.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/app_scrollbar.dart';
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
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
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
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:printing/printing.dart';

import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

class InvoiceEditDesktop extends StatefulWidget {
  const InvoiceEditDesktop({
    Key key,
    @required this.viewModel,
    @required this.entityViewModel,
  }) : super(key: key);

  final EntityEditDetailsVM viewModel;
  final AbstractInvoiceEditVM entityViewModel;

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

  ScrollController _scrollController;
  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();

  @override
  void initState() {
    super.initState();

    final invoice = widget.viewModel.invoice;
    _showTasksTable = invoice.hasTasks && !invoice.hasProducts;

    _focusNode = FocusScopeNode();
    _optionTabController = TabController(vsync: this, length: 5);
    _tableTabController = TabController(
        vsync: this, length: 2, initialIndex: _showTasksTable ? 1 : 0);
    _scrollController = ScrollController();
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
    _scrollController.dispose();

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

    final settings = getClientSettings(state, client);
    final terms = entityType == EntityType.quote
        ? settings.defaultValidUntil
        : settings.defaultPaymentTerms;
    String termsString;
    if ((terms ?? '').isNotEmpty) {
      termsString = '${localization.net} $terms';
    }

    return AppScrollbar(
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
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
                        ClientPicker(
                          autofocus: true,
                          clientId: invoice.clientId,
                          clientState: state.clientState,
                          onSelected: (client) {
                            viewModel.onClientChanged(context, invoice, client);
                          },
                          onAddPressed: (completer) =>
                              viewModel.onAddClientPressed(context, completer),
                        )
                      else
                        InkWell(
                          onTap: () {
                            filterByEntity(context: context, entity: client);
                          },
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minWidth: double.infinity, minHeight: 40),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text(
                                EntityPresenter()
                                    .initialize(client, context)
                                    .title(),
                                style: Theme.of(context).textTheme.headline6,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
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
                              viewModel.onChanged(invoice
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
                          labelText: (invoice.lastSentDate ?? '').isNotEmpty
                              ? localization.nextSendDate
                              : localization.startDate,
                          onSelected: (date, _) {
                            viewModel.onChanged(
                                invoice.rebuild((b) => b..nextSendDate = date));
                          },
                          selectedDate: invoice.nextSendDate,
                          firstDate: DateTime.now(),
                        ),
                        AppDropdownButton<int>(
                          labelText: localization.remainingCycles,
                          value: invoice.remainingCycles,
                          blankValue: null,
                          onChanged: (dynamic value) => viewModel.onChanged(
                              invoice
                                  .rebuild((b) => b..remainingCycles = value)),
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
                            viewModel.onChanged(
                                invoice.rebuild((b) => b..dueDateDays = value));
                          },
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
                              ? AppLocalization.of(context).pleaseSelectADate
                              : null,
                          labelText: entityType == EntityType.credit
                              ? localization.creditDate
                              : entityType == EntityType.quote
                                  ? localization.quoteDate
                                  : localization.invoiceDate,
                          selectedDate: invoice.date,
                          onSelected: (date, _) {
                            viewModel.onChanged(
                                invoice.rebuild((b) => b..date = date));
                          },
                        ),
                        DatePicker(
                          key: ValueKey('__terms_${client.id}__'),
                          labelText: entityType == EntityType.invoice
                              ? localization.dueDate
                              : localization.validUntil,
                          selectedDate: invoice.dueDate,
                          message: termsString,
                          onSelected: (date, _) {
                            viewModel.onChanged(
                                invoice.rebuild((b) => b..dueDate = date));
                          },
                        ),
                        DecoratedFormField(
                          label: localization.partialDeposit,
                          controller: _partialController,
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true, signed: true),
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
                            onSelected: (date, _) {
                              viewModel.onChanged(invoice
                                  .rebuild((b) => b..partialDueDate = date));
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
                            ? AppLocalization.of(context)
                                .pleaseEnterAnInvoiceNumber
                            : null,
                        keyboardType: TextInputType.text,
                        onSavePressed: widget.entityViewModel.onSavePressed,
                      ),
                      DecoratedFormField(
                        label: localization.poNumber,
                        controller: _poNumberController,
                        onSavePressed: widget.entityViewModel.onSavePressed,
                        keyboardType: TextInputType.text,
                      ),
                      DiscountField(
                        controller: _discountController,
                        value: invoice.discount,
                        isAmountDiscount: invoice.isAmountDiscount,
                        onTypeChanged: (value) => viewModel.onChanged(invoice
                            .rebuild((b) => b..isAmountDiscount = value)),
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
                              .toList(),
                        ),
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
                        controller: _optionTabController,
                        tabs: [
                          Tab(text: localization.terms),
                          Tab(text: localization.footer),
                          Tab(text: localization.publicNotes),
                          Tab(text: localization.privateNotes),
                          Tab(text: localization.settings),
                        ],
                      ),
                      SizedBox(
                        height: 171,
                        child: TabBarView(
                          controller: _optionTabController,
                          children: <Widget>[
                            DecoratedFormField(
                              maxLines: 7,
                              controller: _termsController,
                              keyboardType: TextInputType.multiline,
                              label: entityType == EntityType.credit
                                  ? localization.creditTerms
                                  : entityType == EntityType.quote
                                      ? localization.quoteTerms
                                      : localization.invoiceTerms,
                              hint: invoice.isOld && !invoice.isRecurringInvoice
                                  ? ''
                                  : settings
                                      .getDefaultTerms(invoice.entityType),
                            ),
                            DecoratedFormField(
                              maxLines: 7,
                              controller: _footerController,
                              keyboardType: TextInputType.multiline,
                              label: entityType == EntityType.credit
                                  ? localization.creditFooter
                                  : entityType == EntityType.quote
                                      ? localization.quoteFooter
                                      : localization.invoiceFooter,
                              hint: invoice.isOld && !invoice.isRecurringInvoice
                                  ? ''
                                  : settings
                                      .getDefaultFooter(invoice.entityType),
                            ),
                            DecoratedFormField(
                              maxLines: 7,
                              controller: _publicNotesController,
                              keyboardType: TextInputType.multiline,
                              label: localization.publicNotes,
                              hint: client.publicNotes,
                            ),
                            DecoratedFormField(
                              maxLines: 7,
                              controller: _privateNotesController,
                              keyboardType: TextInputType.multiline,
                              label: localization.privateNotes,
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
                                  UserPicker(
                                    userId: invoice.assignedUserId,
                                    onChanged: (userId) => viewModel.onChanged(
                                        invoice.rebuild(
                                            (b) => b..assignedUserId = userId)),
                                  ),
                                  if (company
                                      .isModuleEnabled(EntityType.project))
                                    ProjectPicker(
                                      clientId: invoice.clientId,
                                      projectId: invoice.projectId,
                                      onChanged: (projectId) {
                                        final project =
                                            state.projectState.get(projectId);
                                        final client = state.clientState
                                            .get(project.clientId);

                                        if (project.isOld &&
                                            project.clientId !=
                                                invoice.clientId) {
                                          viewModel.onClientChanged(
                                            context,
                                            invoice.rebuild((b) =>
                                                b..projectId = projectId),
                                            client,
                                          );
                                        } else {
                                          viewModel.onChanged(invoice.rebuild(
                                              (b) => b..projectId = projectId));
                                        }
                                      },
                                    ),
                                  if (company
                                      .isModuleEnabled(EntityType.vendor))
                                    EntityDropdown(
                                      entityType: EntityType.vendor,
                                      entityId: invoice.vendorId,
                                      labelText: localization.vendor,
                                      entityList: memoizedDropdownVendorList(
                                          state.vendorState.map,
                                          state.vendorState.list,
                                          state.userState.map,
                                          state.staticState),
                                      onSelected: (vendor) =>
                                          viewModel.onChanged(
                                        invoice.rebuild(
                                            (b) => b.vendorId = vendor.id),
                                      ),
                                    ),
                                  DecoratedFormField(
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
                                  if (company.hasTaxes)
                                    SwitchListTile(
                                      activeColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      title: Text(localization.inclusiveTaxes),
                                      value: invoice.usesInclusiveTaxes,
                                      onChanged: (value) {
                                        viewModel.onChanged(invoice.rebuild(
                                            (b) =>
                                                b..usesInclusiveTaxes = value));
                                      },
                                    ),
                                  if (invoice.isInvoice)
                                    SwitchListTile(
                                      activeColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      title: Text(localization.autoBillEnabled),
                                      value: invoice.autoBillEnabled,
                                      onChanged: (value) {
                                        viewModel.onChanged(invoice.rebuild(
                                            (b) => b..autoBillEnabled = value));
                                      },
                                    ),
                                ],
                              );
                            }),
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
                                      precision:
                                          precisionForInvoice(state, invoice)),
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
                                onSelected: (taxRate) {
                                  viewModel
                                      .onChanged(invoice.applyTax(taxRate));
                                },
                                labelText: localization.tax +
                                    (company.settings.enableInclusiveTaxes
                                        ? ' - ${localization.inclusive}'
                                        : ''),
                                initialTaxName: invoice.taxName1,
                                initialTaxRate: invoice.taxRate1,
                              ),
                            if (company.enableSecondInvoiceTaxRate ||
                                invoice.taxName2.isNotEmpty)
                              TaxRateDropdown(
                                onSelected: (taxRate) {
                                  viewModel.onChanged(invoice.applyTax(taxRate,
                                      isSecond: true));
                                },
                                labelText: localization.tax +
                                    (company.settings.enableInclusiveTaxes
                                        ? ' - ${localization.inclusive}'
                                        : ''),
                                initialTaxName: invoice.taxName2,
                                initialTaxRate: invoice.taxRate2,
                              ),
                            if (company.enableThirdInvoiceTaxRate ||
                                invoice.taxName3.isNotEmpty)
                              TaxRateDropdown(
                                onSelected: (taxRate) {
                                  final updatedInvoice =
                                      invoice.applyTax(taxRate, isThird: true);
                                  print(
                                      '## UPDATED\nRate 3: ${updatedInvoice.taxName3} => ${updatedInvoice.taxRate3}');
                                  viewModel.onChanged(
                                      invoice.applyTax(taxRate, isThird: true));
                                },
                                labelText: localization.tax +
                                    (company.settings.enableInclusiveTaxes
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
                                onSavePressed:
                                    widget.entityViewModel.onSavePressed,
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
                                          precision: precisionForInvoice(
                                              state, invoice)) -
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
                                initialValue: formatNumber(
                                    invoice.partial, context,
                                    clientId: invoice.clientId),
                              ),
                          ]),
                      FormCard(
                        padding: const EdgeInsets.only(
                            top: kMobileDialogPadding,
                            right: kMobileDialogPadding,
                            left: kMobileDialogPadding / 2),
                        children: [
                          DesignPicker(
                            initialValue: invoice.designId,
                            onSelected: (value) {
                              viewModel.onChanged(invoice
                                  .rebuild((b) => b..designId = value.id));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (state.prefState.showPdfPreview)
              Padding(
                padding: const EdgeInsets.all(16),
                child: _PdfPreview(invoice: invoice),
              ),
          ],
        ),
      ),
    );
  }
}

class _PdfPreview extends StatefulWidget {
  const _PdfPreview({Key key, @required this.invoice}) : super(key: key);

  final InvoiceEntity invoice;

  @override
  __PdfPreviewState createState() => __PdfPreviewState();
}

class __PdfPreviewState extends State<_PdfPreview> {
  final _pdfDebouncer = Debouncer(milliseconds: kMillisecondsToDebounceSave);

  int _pageCount = 1;
  int _currentPage = 1;
  String _pdfString;
  http.Response _response;
  bool _isLoading = false;

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
    if (!widget.invoice.hasClient || _isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final credentials = state.credentials;
    final webClient = WebClient();
    String url =
        '${credentials.url}/live_preview?entity=${widget.invoice.entityType.snakeCase}';
    if (widget.invoice.isOld) {
      url += '&entity_id=${widget.invoice.id}';
    }
    if (state.isProduction) {
      url = url.replaceFirst('//', '//preview.');
    }

    final data =
        serializers.serializeWith(InvoiceEntity.serializer, widget.invoice);
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

        if (kIsWeb && !state.prefState.enableJSPDF) {
          _pdfString =
              'data:application/pdf;base64,' + base64Encode(response.bodyBytes);
          WebUtils.registerWebView(_pdfString);
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
      height: 1200,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_pageCount > 1 && state.prefState.enableJSPDF)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                          width: 180,
                          label: localization.previousPage,
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
                    ? SizedBox()
                    : state.prefState.enableJSPDF
                        ? PdfPreview(
                            build: (format) => _response.bodyBytes,
                            canChangeOrientation: false,
                            canChangePageFormat: false,
                            canDebug: false,
                            pages: [_currentPage - 1],
                            maxPageWidth: 800,
                          )
                        : HtmlElementView(viewType: _pdfString),
              ),
            ],
          ),
          if (_isLoading)
            Container(
              color: Colors.grey.shade300,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }
}
