// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/credit_model.dart';
import 'package:invoiceninja_flutter/data/models/design_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/multiselect_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/color_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/design_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/learn_more.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/invoice_design_vm.dart';
import 'package:invoiceninja_flutter/utils/fonts.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceDesign extends StatefulWidget {
  const InvoiceDesign({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final InvoiceDesignVM viewModel;

  @override
  _InvoiceDesignState createState() => _InvoiceDesignState();
}

class _InvoiceDesignState extends State<InvoiceDesign>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_invoiceDesign');

  TabController _controller;
  FocusScopeNode _focusNode;

  bool _wasInvoiceDesignChanged = false;
  bool _wasQuoteDesignChanged = false;
  bool _wasCreditDesignChanged = false;

  bool _updateAllInvoiceDesigns = false;
  bool _updateAllQuoteDesigns = false;
  bool _updateAllCreditDesigns = false;

  @override
  void initState() {
    super.initState();
    final settingsUIState = widget.viewModel.state.settingsUIState;
    _focusNode = FocusScopeNode();
    _controller = TabController(
        vsync: this, length: 10, initialIndex: settingsUIState.tabIndex);
    _controller.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateSettingsTab(tabIndex: _controller.index));
  }

  @override
  void dispose() {
    _controller.removeListener(_onTabChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final settings = viewModel.settings;
    final company = viewModel.company;
    final isFiltered = state.uiState.settingsUIState.isFiltered;

    return EditScaffold(
      title: localization.invoiceDesign,
      onSavePressed: (context) {
        viewModel.onSavePressed(context, [
          if (_updateAllInvoiceDesigns) EntityType.invoice,
          if (_updateAllQuoteDesigns) EntityType.quote,
          if (_updateAllCreditDesigns) EntityType.credit,
        ]);
      },
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        isScrollable: true,
        tabs: [
          Tab(text: localization.generalSettings),
          Tab(text: localization.clientDetails),
          Tab(text: localization.companyDetails),
          Tab(text: localization.companyAddress),
          Tab(text: localization.invoiceDetails),
          Tab(text: localization.quoteDetails),
          Tab(text: localization.creditDetails),
          Tab(text: localization.productColumns),
          Tab(text: localization.taskColumns),
          Tab(text: localization.totalFields),
        ],
      ),
      body: AppTabForm(
        tabController: _controller,
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          ScrollableListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 10, left: 16),
                child: AppButton(
                  label: localization.customizeAndPreview.toUpperCase(),
                  iconData: Icons.settings,
                  onPressed: () => state.designState.customDesigns.isEmpty
                      ? createEntity(
                          context: context,
                          entity: DesignEntity(state: state),
                        )
                      : store.dispatch(ViewSettings(
                          section: kSettingsCustomDesigns,
                        )),
                ),
              ),
              FormCard(
                children: <Widget>[
                  if (company.isModuleEnabled(EntityType.invoice)) ...[
                    DesignPicker(
                      label: localization.invoiceDesign,
                      initialValue: settings.defaultInvoiceDesignId,
                      onSelected: (value) {
                        setState(() {
                          _wasInvoiceDesignChanged = true;
                        });
                        viewModel.onSettingsChanged(settings.rebuild(
                            (b) => b..defaultInvoiceDesignId = value.id));
                      },
                    ),
                    if (!isFiltered &&
                        _wasInvoiceDesignChanged &&
                        state.userCompany.isAdmin)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: CheckboxListTile(
                          activeColor: Theme.of(context).colorScheme.secondary,
                          title: Text(localization.updateAllRecords),
                          value: _updateAllInvoiceDesigns,
                          onChanged: (value) => setState(
                            () => _updateAllInvoiceDesigns = value,
                          ),
                        ),
                      ),
                  ],
                  if (company.isModuleEnabled(EntityType.quote)) ...[
                    DesignPicker(
                      label: localization.quoteDesign,
                      initialValue: settings.defaultQuoteDesignId,
                      onSelected: (value) {
                        setState(() {
                          _wasQuoteDesignChanged = true;
                        });
                        viewModel.onSettingsChanged(settings.rebuild(
                            (b) => b..defaultQuoteDesignId = value.id));
                      },
                    ),
                    if (!isFiltered &&
                        _wasQuoteDesignChanged &&
                        state.userCompany.isAdmin)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: CheckboxListTile(
                          activeColor: Theme.of(context).colorScheme.secondary,
                          title: Text(localization.updateAllRecords),
                          value: _updateAllQuoteDesigns,
                          onChanged: (value) => setState(
                            () => _updateAllQuoteDesigns = value,
                          ),
                        ),
                      ),
                  ],
                  if (company.isModuleEnabled(EntityType.credit)) ...[
                    DesignPicker(
                      label: localization.creditDesign,
                      initialValue: settings.defaultCreditDesignId,
                      onSelected: (value) {
                        setState(() {
                          _wasCreditDesignChanged = true;
                        });
                        viewModel.onSettingsChanged(settings.rebuild(
                            (b) => b..defaultCreditDesignId = value.id));
                      },
                    ),
                    if (!isFiltered &&
                        _wasCreditDesignChanged &&
                        state.userCompany.isAdmin)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: CheckboxListTile(
                          activeColor: Theme.of(context).colorScheme.secondary,
                          title: Text(localization.updateAllRecords),
                          value: _updateAllCreditDesigns,
                          onChanged: (value) => setState(
                            () => _updateAllCreditDesigns = value,
                          ),
                        ),
                      ),
                  ],
                  AppDropdownButton(
                    labelText: localization.pageLayout,
                    value: settings.pageLayout,
                    onChanged: (dynamic value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..pageLayout = value)),
                    items: kPageLayouts
                        .map((pageLayout) => DropdownMenuItem<String>(
                              value: pageLayout,
                              child: Text(localization.lookup(pageLayout)),
                            ))
                        .toList(),
                  ),
                  AppDropdownButton(
                    labelText: localization.pageSize,
                    value: settings.pageSize,
                    onChanged: (dynamic value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..pageSize = value)),
                    items: kPageSizes
                        .map((pageSize) => DropdownMenuItem<String>(
                              value: pageSize,
                              child: Text(localization.lookup(pageSize)),
                            ))
                        .toList(),
                  ),
                  AppDropdownButton(
                    labelText: localization.fontSize,
                    value:
                        settings.fontSize == null ? '' : '${settings.fontSize}',
                    onChanged: (dynamic value) => viewModel.onSettingsChanged(
                        settings
                            .rebuild((b) => b..fontSize = int.parse(value))),
                    items: [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
                        .map((fontSize) => DropdownMenuItem<String>(
                              value: '$fontSize',
                              child: fontSize == 0
                                  ? SizedBox()
                                  : Text('$fontSize'),
                            ))
                        .toList(),
                  ),
                ],
              ),
              FormCard(
                  isLast: true,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    LearnMoreUrl(
                      url: 'https://fonts.google.com',
                      child: EntityDropdown(
                        entityType: EntityType.font,
                        labelText: localization.primaryFont,
                        entityId: settings.primaryFont,
                        entityMap: memoizedFontMap(kGoogleFonts),
                        onSelected: (font) => viewModel.onSettingsChanged(
                            settings.rebuild((b) => b..primaryFont = font?.id)),
                      ),
                    ),
                    EntityDropdown(
                      entityType: EntityType.font,
                      labelText: localization.secondaryFont,
                      entityId: settings.secondaryFont,
                      entityMap: memoizedFontMap(kGoogleFonts),
                      onSelected: (font) => viewModel.onSettingsChanged(
                          settings.rebuild((b) => b..secondaryFont = font?.id)),
                    ),
                    FormColorPicker(
                      labelText: localization.primaryColor,
                      onSelected: (value) => viewModel.onSettingsChanged(
                          settings.rebuild((b) => b..primaryColor = value)),
                      initialValue: settings.primaryColor,
                    ),
                    FormColorPicker(
                      labelText: localization.secondaryColor,
                      onSelected: (value) => viewModel.onSettingsChanged(
                          settings.rebuild((b) => b..secondaryColor = value)),
                      initialValue: settings.secondaryColor,
                    ),
                  ]),
              FormCard(
                children: [
                  BoolDropdownButton(
                    label: localization.emptyColumns,
                    value: !(settings.hideEmptyColumnsOnPdf ?? false),
                    iconData: MdiIcons.table,
                    onChanged: (value) => viewModel.onSettingsChanged(
                      settings
                          .rebuild((b) => b..hideEmptyColumnsOnPdf = !value),
                    ),
                    enabledLabel: localization.show,
                    disabledLabel: localization.hide,
                  ),
                  BoolDropdownButton(
                    label: localization.pageNumbering,
                    value: settings.pageNumbering ?? false,
                    iconData: Icons.numbers,
                    onChanged: (value) => viewModel.onSettingsChanged(
                      settings.rebuild((b) => b..pageNumbering = value),
                    ),
                    enabledLabel: localization.show,
                    disabledLabel: localization.hide,
                  ),
                  AppDropdownButton(
                    labelText: localization.pageNumberingAlignment,
                    value: settings.pageNumberingAlignment,
                    onChanged: (dynamic value) => viewModel.onSettingsChanged(
                        settings
                            .rebuild((b) => b..pageNumberingAlignment = value)),
                    items: [
                      DropdownMenuItem<String>(
                        child: Text(localization.left),
                        value: SettingsEntity.PAGE_NUMBER_ALIGN_LEFT,
                      ),
                      DropdownMenuItem<String>(
                        child: Text(localization.center),
                        value: SettingsEntity.PAGE_NUMBER_ALIGN_CENTER,
                      ),
                      DropdownMenuItem<String>(
                          child: Text(localization.right),
                          value: SettingsEntity.PAGE_NUMBER_ALIGN_RIGHT),
                    ],
                    /*
                    items: kPageLayouts
                        .map((pageLayout) => DropdownMenuItem<String>(
                              value: pageLayout,
                              child: Text(localization.lookup(pageLayout)),
                            ))
                        .toList(),
                        */
                  ),
                ],
              ),
            ],
          ),
          /*
          ScrollableListView(
            padding: const EdgeInsets.all(10),
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  BoolDropdownButton(
                    label: localization.allPagesHeader,
                    value: settings.allPagesHeader,
                    iconData: MdiIcons.pageLayoutHeader,
                    onChanged: (value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..allPagesHeader = value)),
                    enabledLabel: localization.allPages,
                    disabledLabel: localization.firstPage,
                  ),
                  BoolDropdownButton(
                    label: localization.allPagesFooter,
                    value: settings.allPagesFooter,
                    iconData: MdiIcons.pageLayoutFooter,
                    onChanged: (value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..allPagesFooter = value)),
                    enabledLabel: localization.allPages,
                    disabledLabel: localization.lastPage,
                  ),
                ],
              ),
              FormCard(
                children: <Widget>[
                  BoolDropdownButton(
                    label: localization.hidePaidToDate,
                    helpLabel: localization.hidePaidToDateHelp,
                    value: settings.hidePaidToDate,
                    iconData: MdiIcons.fileInvoiceDollar,
                    onChanged: (value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..hidePaidToDate = value)),
                  ),
                  BoolDropdownButton(
                    label: localization.invoiceEmbedDocuments,
                    helpLabel: localization.invoiceEmbedDocumentsHelp,
                    value: settings.embedDocuments,
                    iconData: MdiIcons.image,
                    onChanged: (value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..embedDocuments = value)),
                  ),
                ],
              ),               
            ],
          ),
          */
          FormCard(
            isLast: true,
            child: MultiSelectList(
              options: [
                ...[
                  ClientFields.name,
                  ClientFields.number,
                  ClientFields.idNumber,
                  ClientFields.vatNumber,
                  ClientFields.website,
                  ClientFields.phone,
                  ClientFields.address1,
                  ClientFields.address2,
                  ClientFields.cityStatePostal,
                  ClientFields.postalCityState,
                  ClientFields.country,
                  ClientFields.custom1,
                  ClientFields.custom2,
                  ClientFields.custom3,
                  ClientFields.custom4,
                ].map((field) => '\$client.$field'),
                ...[
                  ContactFields.fullName,
                  ContactFields.email,
                  ContactFields.phone,
                  ContactFields.custom1,
                  ContactFields.custom2,
                  ContactFields.custom3,
                  ContactFields.custom4,
                ].map((field) => '\$contact.$field'),
              ],
              defaultSelected: [
                ...[
                  ClientFields.name,
                  ClientFields.number,
                  ClientFields.vatNumber,
                  ClientFields.address1,
                  ClientFields.address2,
                  ClientFields.cityStatePostal,
                  ClientFields.country,
                  ClientFields.phone,
                ].map((field) => '\$client.$field'),
                ...[
                  ContactFields.email,
                ].map((field) => '\$contact.$field'),
              ],
              selected: settings.getFieldsForSection(kPdfFieldsClientDetails),
              onSelected: (values) {
                viewModel.onSettingsChanged(settings.setFieldsForSection(
                    kPdfFieldsClientDetails, values));
              },
              addTitle: localization.addField,
              liveChanges: true,
              prefix: 'client',
            ),
          ),
          FormCard(
            isLast: true,
            child: MultiSelectList(
              options: [
                CompanyFields.name,
                CompanyFields.idNumber,
                CompanyFields.vatNumber,
                CompanyFields.website,
                CompanyFields.email,
                CompanyFields.phone,
                CompanyFields.address1,
                CompanyFields.address2,
                CompanyFields.cityStatePostal,
                CompanyFields.postalCityState,
                CompanyFields.country,
                CompanyFields.custom1,
                CompanyFields.custom2,
                CompanyFields.custom3,
                CompanyFields.custom4,
              ].map((field) => '\$company.$field').toList(),
              defaultSelected: [
                CompanyFields.name,
                CompanyFields.idNumber,
                CompanyFields.vatNumber,
                CompanyFields.website,
                CompanyFields.email,
                CompanyFields.phone,
              ].map((field) => '\$company.$field').toList(),
              selected: settings.getFieldsForSection(kPdfFieldsCompanyDetails),
              onSelected: (values) {
                viewModel.onSettingsChanged(settings.setFieldsForSection(
                    kPdfFieldsCompanyDetails, values));
              },
              addTitle: localization.addField,
              liveChanges: true,
              prefix: 'company',
            ),
          ),
          FormCard(
            isLast: true,
            child: MultiSelectList(
              options: [
                CompanyFields.name,
                CompanyFields.idNumber,
                CompanyFields.vatNumber,
                CompanyFields.website,
                CompanyFields.email,
                CompanyFields.phone,
                CompanyFields.address1,
                CompanyFields.address2,
                CompanyFields.cityStatePostal,
                CompanyFields.postalCityState,
                CompanyFields.country,
                CompanyFields.custom1,
                CompanyFields.custom2,
                CompanyFields.custom3,
                CompanyFields.custom4,
              ].map((field) => '\$company.$field').toList(),
              defaultSelected: [
                CompanyFields.address1,
                CompanyFields.address2,
                CompanyFields.cityStatePostal,
                CompanyFields.country,
              ].map((field) => '\$company.$field').toList(),
              selected: settings.getFieldsForSection(kPdfFieldsCompanyAddress),
              onSelected: (values) {
                viewModel.onSettingsChanged(settings.setFieldsForSection(
                    kPdfFieldsCompanyAddress, values));
              },
              addTitle: localization.addField,
              liveChanges: true,
              prefix: 'company',
            ),
          ),
          FormCard(
            isLast: true,
            child: MultiSelectList(
              options: [
                ...[
                  InvoiceFields.number,
                  InvoiceFields.poNumber,
                  InvoiceFields.date,
                  InvoiceFields.dueDate,
                  InvoiceFields.amount,
                  InvoiceFields.balance,
                  InvoiceFields.balanceDue,
                  InvoiceFields.customValue1,
                  InvoiceFields.customValue2,
                  InvoiceFields.customValue3,
                  InvoiceFields.customValue4,
                  InvoiceFields.project,
                  InvoiceFields.vendor,
                ].map((field) => '\$invoice.$field'),
                ...[
                  ClientFields.balance,
                ].map((field) => '\$client.$field')
              ],
              defaultSelected: [
                InvoiceFields.number,
                InvoiceFields.poNumber,
                InvoiceFields.date,
                InvoiceFields.dueDate,
                InvoiceFields.total,
                InvoiceFields.balanceDue,
              ].map((field) => '\$invoice.$field').toList(),
              selected: settings.getFieldsForSection(kPdfFieldsInvoiceDetails),
              onSelected: (values) {
                viewModel.onSettingsChanged(settings.setFieldsForSection(
                    kPdfFieldsInvoiceDetails, values));
              },
              addTitle: localization.addField,
              liveChanges: true,
              prefix: 'invoice',
            ),
          ),
          FormCard(
            isLast: true,
            child: MultiSelectList(
              options: [
                ...[
                  QuoteFields.number,
                  QuoteFields.poNumber,
                  QuoteFields.date,
                  QuoteFields.validUntil,
                  QuoteFields.total,
                  QuoteFields.customValue1,
                  QuoteFields.customValue2,
                  QuoteFields.customValue3,
                  QuoteFields.customValue4,
                ].map((field) => '\$quote.$field'),
                ...[
                  ClientFields.balance,
                ].map((field) => '\$client.$field')
              ],
              defaultSelected: [
                QuoteFields.number,
                QuoteFields.poNumber,
                QuoteFields.date,
                QuoteFields.validUntil,
                QuoteFields.total,
              ].map((field) => '\$quote.$field').toList(),
              selected: settings.getFieldsForSection(kPdfFieldsQuoteDetails),
              onSelected: (values) {
                viewModel.onSettingsChanged(settings.setFieldsForSection(
                    kPdfFieldsQuoteDetails, values));
              },
              addTitle: localization.addField,
              liveChanges: true,
              prefix: 'quote',
            ),
          ),
          FormCard(
            isLast: true,
            child: MultiSelectList(
              options: [
                ...[
                  CreditFields.number,
                  CreditFields.poNumber,
                  CreditFields.date,
                  CreditFields.total,
                  CreditFields.balance,
                  CreditFields.customValue1,
                  CreditFields.customValue2,
                  CreditFields.customValue3,
                  CreditFields.customValue4,
                ].map((field) => '\$credit.$field'),
                ...[
                  ClientFields.balance,
                ].map((field) => '\$client.$field')
              ],
              defaultSelected: [
                CreditFields.number,
                CreditFields.poNumber,
                CreditFields.date,
                CreditFields.balance,
                CreditFields.total,
              ].map((field) => '\$credit.$field').toList(),
              selected: settings.getFieldsForSection(kPdfFieldsCreditDetails),
              onSelected: (values) {
                viewModel.onSettingsChanged(settings.setFieldsForSection(
                    kPdfFieldsCreditDetails, values));
              },
              addTitle: localization.addField,
              liveChanges: true,
              prefix: 'credit',
            ),
          ),
          FormCard(
            isLast: true,
            child: MultiSelectList(
              options: [
                ProductItemFields.item,
                ProductItemFields.description,
                if (company.enableProductQuantity) ProductItemFields.quantity,
                ProductItemFields.unitCost,
                if (company.hasItemTaxes) ProductItemFields.tax,
                if (company.enableProductDiscount) ProductItemFields.discount,
                ProductItemFields.lineTotal,
                ProductItemFields.custom1,
                ProductItemFields.custom2,
                ProductItemFields.custom3,
                ProductItemFields.custom4,
                ProductItemFields.grossLineTotal,
              ].map((field) => '\$product.$field').toList(),
              defaultSelected: [
                ProductItemFields.item,
                ProductItemFields.description,
                ProductItemFields.unitCost,
                if (company.enableProductQuantity) ProductItemFields.quantity,
                if (company.enableProductDiscount) ProductItemFields.discount,
                if (company.hasItemTaxes) ProductItemFields.tax,
                ProductItemFields.lineTotal,
              ].map((field) => '\$product.$field').toList(),
              selected: settings.getFieldsForSection(kPdfFieldsProductColumns),
              onSelected: (values) {
                viewModel.onSettingsChanged(settings.setFieldsForSection(
                    kPdfFieldsProductColumns, values));
              },
              addTitle: localization.addField,
              liveChanges: true,
              prefix: 'product',
            ),
          ),
          FormCard(
            isLast: true,
            child: MultiSelectList(
              options: [
                TaskItemFields.service,
                TaskItemFields.description,
                TaskItemFields.hours,
                TaskItemFields.rate,
                if (company.hasItemTaxes) TaskItemFields.tax,
                if (company.enableProductDiscount) TaskItemFields.discount,
                TaskItemFields.lineTotal,
                TaskItemFields.custom1,
                TaskItemFields.custom2,
                TaskItemFields.custom3,
                TaskItemFields.custom4,
                TaskItemFields.grossLineTotal,
              ].map((field) => '\$task.$field').toList(),
              defaultSelected: [
                TaskItemFields.service,
                TaskItemFields.description,
                TaskItemFields.rate,
                TaskItemFields.hours,
                if (company.enableProductDiscount) TaskItemFields.discount,
                if (company.hasItemTaxes) TaskItemFields.tax,
                TaskItemFields.lineTotal,
              ].map((field) => '\$task.$field').toList(),
              selected: settings.getFieldsForSection(kPdfFieldsTaskColumns),
              onSelected: (values) {
                viewModel.onSettingsChanged(settings.setFieldsForSection(
                    kPdfFieldsTaskColumns, values));
              },
              addTitle: localization.addField,
              liveChanges: true,
              prefix: 'task',
            ),
          ),
          FormCard(
            isLast: true,
            child: MultiSelectList(
              options: [
                InvoiceTotalFields.subtotal,
                InvoiceTotalFields.netSubtotal,
                InvoiceTotalFields.discount,
                InvoiceTotalFields.lineTaxes,
                InvoiceTotalFields.totalTaxes,
                InvoiceTotalFields.customSurcharge1,
                InvoiceTotalFields.customSurcharge2,
                InvoiceTotalFields.customSurcharge3,
                InvoiceTotalFields.customSurcharge4,
                InvoiceTotalFields.paidToDate,
                InvoiceTotalFields.total,
                InvoiceTotalFields.outstanding,
              ].map((field) => '\$$field').toList(),
              defaultSelected: [
                InvoiceTotalFields.subtotal,
                InvoiceTotalFields.discount,
                InvoiceTotalFields.customSurcharge1,
                InvoiceTotalFields.customSurcharge2,
                InvoiceTotalFields.customSurcharge3,
                InvoiceTotalFields.customSurcharge4,
                InvoiceTotalFields.totalTaxes,
                InvoiceTotalFields.lineTaxes,
                InvoiceTotalFields.total,
                InvoiceTotalFields.paidToDate,
                InvoiceTotalFields.outstanding,
              ].map((field) => '\$$field').toList(),
              selected: settings.getFieldsForSection(kPdfFieldsTotalFields),
              onSelected: (values) {
                viewModel.onSettingsChanged(settings.setFieldsForSection(
                    kPdfFieldsTotalFields, values));
              },
              addTitle: localization.addField,
              liveChanges: true,
              prefix: 'total',
            ),
          ),
        ],
      ),
    );
  }
}
