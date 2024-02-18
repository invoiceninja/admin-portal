// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/settings_model.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/autobill_dropdown_menu_item.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/payment_settings_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentSettings extends StatefulWidget {
  const PaymentSettings({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final PaymentSettingsVM viewModel;

  @override
  _PaymentSettingsState createState() => _PaymentSettingsState();
}

class _PaymentSettingsState extends State<PaymentSettings> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_paymentSettings');
  FocusScopeNode? _focusNode;
  final _minimumUnderPaymentAmountController = TextEditingController();
  final _minimumPaymentAmountController = TextEditingController();
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _minimumPaymentAmountController,
      _minimumUnderPaymentAmountController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    _minimumUnderPaymentAmountController.text = formatNumber(
        widget.viewModel.settings.clientPortalUnderPaymentMinimum, context,
        formatNumberType: FormatNumberType.inputMoney)!;

    _minimumPaymentAmountController.text = formatNumber(
        widget.viewModel.settings.clientInitiatedPaymentsMinimum, context,
        formatNumberType: FormatNumberType.inputMoney)!;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    super.dispose();
  }

  void _onChanged() {
    final viewModel = widget.viewModel;
    final settings = viewModel.settings.rebuild((b) => b
      ..clientPortalUnderPaymentMinimum =
          parseDouble(_minimumUnderPaymentAmountController.text)
      ..clientInitiatedPaymentsMinimum =
          parseDouble(_minimumPaymentAmountController.text));
    if (settings != viewModel.settings) {
      viewModel.onSettingsChanged(settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final settings = viewModel.settings;
    final company = viewModel.company;

    return EditScaffold(
      title: localization.paymentSettings,
      onSavePressed: viewModel.onSavePressed,
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          FormCard(
            children: <Widget>[
              AppDropdownButton<bool>(
                  blankValue: null,
                  showBlank: true,
                  labelText: localization.autoBillStandardInvoices,
                  value: state.settingsUIState.isFiltered
                      ? settings.autoBillStandardInvoices
                      : settings.autoBillStandardInvoices ?? false,
                  onChanged: (dynamic value) => viewModel.onSettingsChanged(
                      settings
                          .rebuild((b) => b..autoBillStandardInvoices = value)),
                  items: [
                    DropdownMenuItem<bool>(
                        child: Text(localization.enabled), value: true),
                    DropdownMenuItem<bool>(
                        child: Text(localization.off), value: false),
                  ]),
              AppDropdownButton<String>(
                  labelText: localization.autoBillRecurringInvoices,
                  value: settings.autoBill,
                  onChanged: (dynamic value) => viewModel.onSettingsChanged(
                      settings.rebuild((b) => b..autoBill = value)),
                  selectedItemBuilder: (settings.autoBill ?? '').isEmpty
                      ? null
                      : (context) => [
                            SettingsEntity.AUTO_BILL_ALWAYS,
                            SettingsEntity.AUTO_BILL_OPT_OUT,
                            SettingsEntity.AUTO_BILL_OPT_IN,
                            SettingsEntity.AUTO_BILL_OFF,
                          ]
                              .map((type) => Text(localization.lookup(type)))
                              .toList(),
                  items: [
                    SettingsEntity.AUTO_BILL_ALWAYS,
                    SettingsEntity.AUTO_BILL_OPT_OUT,
                    SettingsEntity.AUTO_BILL_OPT_IN,
                    SettingsEntity.AUTO_BILL_OFF
                  ]
                      .map((value) => DropdownMenuItem(
                            child: AutobillDropdownMenuItem(type: value),
                            value: value,
                          ))
                      .toList()),
              AppDropdownButton<String>(
                labelText: localization.autoBillOn,
                value: settings.autoBillDate,
                onChanged: (dynamic value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..autoBillDate = value)),
                items: [
                  DropdownMenuItem(
                    child: Text(localization.sendDate),
                    value: SettingsEntity.AUTO_BILL_ON_SEND_DATE,
                  ),
                  DropdownMenuItem(
                    child: Text(localization.dueDate),
                    value: SettingsEntity.AUTO_BILL_ON_DUE_DATE,
                  ),
                ],
              ),
              AppDropdownButton<String>(
                  labelText: localization.useAvailablePayments,
                  value: settings.useUnappliedPayment,
                  onChanged: (dynamic value) {
                    viewModel.onSettingsChanged(settings
                        .rebuild((b) => b..useUnappliedPayment = value));
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text(localization.always),
                      value: CompanyEntity.USE_ALWAYS,
                    ),
                    DropdownMenuItem(
                      child: Text(localization.showOption),
                      value: CompanyEntity.USE_OPTION,
                    ),
                    DropdownMenuItem(
                      child: Text(localization.off),
                      value: CompanyEntity.USE_OFF,
                    ),
                  ]),
              AppDropdownButton<String>(
                  labelText: localization.useAvailableCredits,
                  value: settings.useCreditsPayment,
                  onChanged: (dynamic value) {
                    viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..useCreditsPayment = value));
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text(localization.always),
                      value: CompanyEntity.USE_ALWAYS,
                    ),
                    DropdownMenuItem(
                      child: Text(localization.showOption),
                      value: CompanyEntity.USE_OPTION,
                    ),
                    DropdownMenuItem(
                      child: Text(localization.off),
                      value: CompanyEntity.USE_OFF,
                    ),
                  ]),
              EntityDropdown(
                entityType: EntityType.paymentType,
                entityList:
                    memoizedPaymentTypeList(state.staticState.paymentTypeMap),
                labelText: localization.defaultPaymentType,
                entityId: settings.defaultPaymentTypeId,
                onSelected: (paymentType) => viewModel.onSettingsChanged(
                    settings.rebuild(
                        (b) => b..defaultPaymentTypeId = paymentType?.id)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AppButton(
              iconData: Icons.settings,
              label: localization.configureGateways.toUpperCase(),
              onPressed: () => viewModel.onConfigureGatewaysPressed(context),
            ),
          ),
          SizedBox(height: 8),
          FormCard(children: [
            if (!state.uiState.settingsUIState.isFiltered)
              BoolDropdownButton(
                label: localization.adminInitiatedPayments,
                value: company.enableApplyingPayments,
                helpLabel: localization.adminInitiatedPaymentsHelp,
                onChanged: (value) => viewModel.onCompanyChanged(
                    company.rebuild((b) => b..enableApplyingPayments = value)),
              ),
            BoolDropdownButton(
              label: localization.clientInitiatedPayments,
              value: settings.clientInitiatedPayments,
              helpLabel: localization.clientInitiatedPaymentsHelp,
              onChanged: (value) => viewModel.onSettingsChanged(
                  settings.rebuild((b) => b..clientInitiatedPayments = value)),
            ),
            if (settings.clientInitiatedPayments == true)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: DecoratedFormField(
                  label: localization.minimumPaymentAmount,
                  controller: _minimumPaymentAmountController,
                  isMoney: true,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: true),
                ),
              ),
            BoolDropdownButton(
              label: localization.allowOverPayment,
              value: settings.clientPortalAllowOverPayment,
              helpLabel: localization.allowOverPaymentHelp,
              onChanged: (value) => viewModel.onSettingsChanged(settings
                  .rebuild((b) => b..clientPortalAllowOverPayment = value)),
            ),
            BoolDropdownButton(
              label: localization.allowUnderPayment,
              value: settings.clientPortalAllowUnderPayment,
              helpLabel: localization.allowUnderPaymentHelp,
              onChanged: (value) => viewModel.onSettingsChanged(settings
                  .rebuild((b) => b..clientPortalAllowUnderPayment = value)),
            ),
            if (settings.clientPortalAllowUnderPayment == true)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: DecoratedFormField(
                  label: localization.minimumUnderPaymentAmount,
                  controller: _minimumUnderPaymentAmountController,
                  isMoney: true,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: true),
                ),
              ),
            if (!state.uiState.settingsUIState.isFiltered)
              BoolDropdownButton(
                label: localization.convertCurrency,
                value: company.convertPaymentCurrency,
                helpLabel: localization.convertPaymentCurrencyHelp,
                onChanged: (value) => viewModel.onCompanyChanged(
                    company.rebuild((b) => b..convertPaymentCurrency = value)),
              ),
          ]),
          FormCard(
            isLast: true,
            children: [
              BoolDropdownButton(
                value: settings.clientOnlinePaymentNotification,
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild(
                        (b) => b..clientOnlinePaymentNotification = value)),
                label: localization.onlinePaymentEmail,
                helpLabel: localization.onlinePaymentEmailHelp,
                iconData: Icons.email,
              ),
              BoolDropdownButton(
                value: settings.clientManualPaymentNotification,
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild(
                        (b) => b..clientManualPaymentNotification = value)),
                label: localization.manualPaymentEmail,
                helpLabel: localization.manualPaymentEmailHelp,
                iconData: Icons.email,
              ),
              BoolDropdownButton(
                value: settings.clientMarkPaidPaymentNotification,
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild(
                        (b) => b..clientMarkPaidPaymentNotification = value)),
                label: localization.markPaidPaymentEmail,
                helpLabel: localization.markPaidPaymentEmailHelp,
                iconData: Icons.email,
              ),
              if (!state.settingsUIState.isFiltered) SizedBox(height: 10),
              BoolDropdownButton(
                value: state.settingsUIState.isFiltered
                    ? settings.paymentEmailAllContacts
                    : settings.paymentEmailAllContacts ?? false,
                onChanged: (value) => viewModel.onSettingsChanged(settings
                    .rebuild((b) => b..paymentEmailAllContacts = value)),
                label: localization.sendEmailsTo,
                iconData: Icons.email,
                enabledLabel: localization.primaryContact,
                disabledLabel: localization.allContacts,
              ),
            ],
          )
        ],
      ),
    );
  }
}
