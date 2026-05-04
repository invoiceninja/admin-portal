// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/settings/e_invoice_settings_vm.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/files.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EInvoiceSettings extends StatefulWidget {
  const EInvoiceSettings({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final EInvoiceSettingsVM viewModel;

  @override
  _EInvoiceSettingsState createState() => _EInvoiceSettingsState();
}

class _EInvoiceSettingsState extends State<EInvoiceSettings> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_eInvoiceSettings');

  FocusScopeNode? _focusNode;

  final _eInvoiceCertificatePassphraseController = TextEditingController();
  final _eInvoiceForwardEmailController = TextEditingController();
  String _paymentMeansCode = '';
  final _paymentMeansCodeController = TextEditingController();
  final _paymentMeansCodeFocusNode = FocusNode();
  final _ibanController = TextEditingController();
  final _bicSwiftController = TextEditingController();
  final _accountHolderController = TextEditingController();
  final _payerBankAccountController = TextEditingController();
  final _bsbSortController = TextEditingController();
  final _cardTypeController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();

  // PEPPOL onboarding controllers
  final _partyNameController = TextEditingController();
  final _vatNumberController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _line1Controller = TextEditingController();
  final _line2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _countyController = TextEditingController();
  final _zipController = TextEditingController();

  List<TextEditingController> _controllers = [];

  bool _isBusinessEntity = true;
  bool _actsAsSender = true;
  bool _actsAsReceiver = true;

  List<String> get _visibleFields =>
      kPaymentMeansFormElements[_paymentMeansCode] ?? [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    _paymentMeansCodeController.dispose();
    _paymentMeansCodeFocusNode.dispose();
    _ibanController.dispose();
    _bicSwiftController.dispose();
    _accountHolderController.dispose();
    _payerBankAccountController.dispose();
    _bsbSortController.dispose();
    _cardTypeController.dispose();
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _partyNameController.dispose();
    _vatNumberController.dispose();
    _idNumberController.dispose();
    _line1Controller.dispose();
    _line2Controller.dispose();
    _cityController.dispose();
    _countyController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _eInvoiceCertificatePassphraseController,
      _eInvoiceForwardEmailController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final viewModel = widget.viewModel;
    final company = viewModel.company;
    final settings = viewModel.settings;

    _eInvoiceCertificatePassphraseController.text =
        company.eInvoiceCertificatePassphrase;
    _eInvoiceForwardEmailController.text = settings.eInvoiceForwardEmail ?? '';

    // Pre-populate PEPPOL onboarding from company settings
    _partyNameController.text = settings.name ?? '';
    _line1Controller.text = settings.address1 ?? '';
    _line2Controller.text = settings.address2 ?? '';
    _cityController.text = settings.city ?? '';
    _countyController.text = settings.state ?? '';
    _zipController.text = settings.postalCode ?? '';
    _vatNumberController.text = settings.vatNumber ?? '';
    _idNumberController.text = settings.idNumber ?? '';

    _actsAsSender = company.taxConfig.actsAsSender;
    _actsAsReceiver = company.taxConfig.actsAsReceiver;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    final eInvoiceCertificatePassphrase =
        _eInvoiceCertificatePassphraseController.text.trim();

    final viewModel = widget.viewModel;
    final isFiltered = viewModel.state.settingsUIState.isFiltered;

    final settings = viewModel.settings.rebuild((b) =>
        b..eInvoiceForwardEmail = _eInvoiceForwardEmailController.text.trim());
    if (settings != viewModel.settings) {
      viewModel.onSettingsChanged(settings);
    }

    final company = viewModel.company.rebuild((b) => b
      ..eInvoiceCertificatePassphrase =
          isFiltered && eInvoiceCertificatePassphrase.isEmpty
              ? null
              : eInvoiceCertificatePassphrase);
    if (company != viewModel.company) {
      viewModel.onCompanyChanged(company);
    }
  }

  void _onSavePressed(BuildContext context) {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _savePaymentMeans();

    widget.viewModel.onSavePressed(context);
  }

  void _savePaymentMeans() {
    final code = _paymentMeansCode;

    if (code.isEmpty) {
      return;
    }

    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final url = state.credentials.url + '/einvoice/configurations';

    final data = <String, dynamic>{
      'code': code,
    };
    final fields = _visibleFields;
    if (fields.contains('iban')) 
      data['iban'] = _ibanController.text.trim();
    if (fields.contains('bic_swift'))
      data['bic_swift'] = _bicSwiftController.text.trim();
    if (fields.contains('account_holder'))
      data['account_holder'] = _accountHolderController.text.trim();
    if (fields.contains('payer_bank_account'))
      data['payer_bank_account'] = _payerBankAccountController.text.trim();
    if (fields.contains('bsb_sort'))
      data['bsb_sort'] = _bsbSortController.text.trim();
    if (fields.contains('card_type'))
      data['card_type'] = _cardTypeController.text.trim();
    if (fields.contains('card_number'))
      data['card_number'] = _cardNumberController.text.trim();
    if (fields.contains('card_holder'))
      data['card_holder'] = _cardHolderController.text.trim();

    WebClient()
        .post(
      url,
      state.credentials.token,
      data: json.encode({
        'entity': 'company',
        'payment_means': [data],
      }),
    )
        .then((_) {
      // Saved with the main settings save
    }).catchError((error) {
      showErrorDialog(message: '$error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = viewModel.company;
    final settings = viewModel.settings;
    final settingsUIState = state.settingsUIState;
    final isPeppol = settings.eInvoiceType == kEInvoiceTypePEPPOL;
    final hasPeppolId = company.legalEntityId != 0;

    return EditScaffold(
      title: localization.eInvoiceSettings,
      onSavePressed: _onSavePressed,
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          FormCard(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AppDropdownButton<String>(
                  labelText: localization.eInvoiceType,
                  showBlank: settingsUIState.isFiltered,
                  value: settings.eInvoiceType,
                  onChanged: (dynamic value) {
                    viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..eInvoiceType = value));
                  },
                  items: kEInvoiceTypes
                      .map((type) => DropdownMenuItem<String>(
                            child: Text(type
                                .replaceFirst('_', ' ')
                                .replaceAll('_', '.')),
                            value: type,
                          ))
                      .toList()),
              if (settings.eInvoiceType == kEInvoiceTypeVERIFACTU)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VERIFACTU',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '1. ${localization.lookup('tax_authority_authorization_step_1')}\n'
                        '2. ${localization.lookup('tax_authority_authorization_step_2')}\n'
                        '3. ${localization.lookup('tax_authority_authorization_step_3')}\n'
                        '4. ${localization.lookup('tax_authority_authorization_step_4')}\n'
                        '5. ${localization.lookup('tax_authority_authorization_step_5')}\n'
                        '6. ${localization.lookup('tax_authority_authorization_step_6')}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 8),
                      Text(
                        localization.lookup('contact_email') +
                            ': contact@invoiceninja.com',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              if (!isPeppol) ...[
                BoolDropdownButton(
                  label: localization.enableEInvoice,
                  value: settings.enableEInvoice,
                  iconData: MdiIcons.fileXmlBox,
                  onChanged: (value) => viewModel.onSettingsChanged(
                      settings.rebuild((b) => b..enableEInvoice = value)),
                ),
                if (settings.enableEInvoice == true) ...[
                  BoolDropdownButton(
                    label: localization.mergeToPdf,
                    value: settings.mergeEInvoiceToPdf,
                    iconData: MdiIcons.callMerge,
                    onChanged: (value) => viewModel.onSettingsChanged(
                      settings.rebuild((b) => b..mergeEInvoiceToPdf = value),
                    ),
                  ),
                  BoolDropdownButton(
                    label: localization.skipAutomaticEmails,
                    value: settings.skipAutomaticEmailWithPeppol,
                    iconData: MdiIcons.email,
                    onChanged: (value) => viewModel.onSettingsChanged(
                      settings.rebuild(
                          (b) => b..skipAutomaticEmailWithPeppol = value),
                    ),
                  ),
                  AppDropdownButton<String>(
                      labelText: localization.eQuoteType,
                      showBlank: settingsUIState.isFiltered,
                      value: settings.eQuoteType,
                      onChanged: (dynamic value) {
                        viewModel.onSettingsChanged(
                            settings.rebuild((b) => b..eQuoteType = value));
                      },
                      items: kEQuoteTypes
                          .map((type) => DropdownMenuItem<String>(
                                child: Text(type
                                    .replaceFirst('_', ' ')
                                    .replaceAll('_', '.')),
                                value: type,
                              ))
                          .toList()),
                  if (!settingsUIState.isFiltered) ...[
                    SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: company.hasEInvoiceCertificate
                              ? OutlinedButton.icon(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  label: Text(
                                    localization.lookup('remove'),
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    viewModel.onCompanyChanged(company.rebuild(
                                        (b) =>
                                            b..hasEInvoiceCertificate = false));
                                    viewModel.onSavePressed(context);
                                  },
                                )
                              : OutlinedButton(
                                  onPressed: () async {
                                    final files = await pickFiles(
                                      fileIndex: 'e_invoice_certificate',
                                      allowMultiple: false,
                                      allowedExtensions: [
                                        'p12',
                                        'pfx',
                                        'pem',
                                        'cer',
                                        'crt',
                                        'der',
                                        'txt',
                                        'p7b',
                                        'spc',
                                        'bin',
                                      ],
                                    );

                                    if (files != null && files.isNotEmpty) {
                                      viewModel.onEInvoiceCertificateSelected(
                                          files.first);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(localization.uploadCertificate
                                        .toUpperCase()),
                                  ),
                                ),
                        ),
                        SizedBox(width: kTableColumnGap),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                company.hasEInvoiceCertificate
                                    ? Icons.check_circle_outline
                                    : Icons.circle_outlined,
                                size: 16,
                                color: company.hasEInvoiceCertificate
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  company.hasEInvoiceCertificate
                                      ? localization.certificateSet
                                      : localization.certificateNotSet,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: company.hasEInvoiceCertificatePassphrase
                              ? OutlinedButton.icon(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  label: Text(
                                    localization.lookup('remove'),
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    _eInvoiceCertificatePassphraseController
                                        .text = '';
                                    _onChanged();
                                    viewModel.onSavePressed(context);
                                  },
                                )
                              : DecoratedFormField(
                                  label: localization.certificatePassphrase,
                                  controller:
                                      _eInvoiceCertificatePassphraseController,
                                  keyboardType: TextInputType.text,
                                  onSavePressed: _onSavePressed,
                                ),
                        ),
                        SizedBox(width: kTableColumnGap),
                        Expanded(
                          child: Row(children: [
                            Icon(
                              company.hasEInvoiceCertificatePassphrase
                                  ? Icons.check_circle_outline
                                  : Icons.circle_outlined,
                              size: 16,
                              color: company.hasEInvoiceCertificatePassphrase
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                company.hasEInvoiceCertificatePassphrase
                                    ? localization.passphraseSet
                                    : localization.passphraseNotSet,
                                maxLines: 2,
                              ),
                            ),
                          ]),
                        )
                      ],
                    ),
                    DecoratedFormField(
                      label: localization.forwardEmail,
                      controller: _eInvoiceForwardEmailController,
                      keyboardType: TextInputType.emailAddress,
                      onSavePressed: _onSavePressed,
                    ),
                  ],
                ],
              ],
            ],
          ),
          if (isPeppol) ...[
            if (hasPeppolId)
              _PeppolPreferences(
                company: company,
                localization: localization,
                store: store,
                actsAsSender: _actsAsSender,
                actsAsReceiver: _actsAsReceiver,
                onSenderChanged: (value) =>
                    setState(() => _actsAsSender = value),
                onReceiverChanged: (value) =>
                    setState(() => _actsAsReceiver = value),
              )
            else
              _PeppolOnboarding(
                localization: localization,
                store: store,
                isBusinessEntity: _isBusinessEntity,
                onEntityTypeChanged: (value) =>
                    setState(() => _isBusinessEntity = value),
                partyNameController: _partyNameController,
                vatNumberController: _vatNumberController,
                idNumberController: _idNumberController,
                line1Controller: _line1Controller,
                line2Controller: _line2Controller,
                cityController: _cityController,
                countyController: _countyController,
                zipController: _zipController,
                actsAsSender: _actsAsSender,
                actsAsReceiver: _actsAsReceiver,
                onSenderChanged: (value) =>
                    setState(() => _actsAsSender = value),
                onReceiverChanged: (value) =>
                    setState(() => _actsAsReceiver = value),
                countryId: company.settings.countryId ?? '',
              ),
          ],
          if ((settings.enableEInvoice == true || isPeppol) &&
              !settingsUIState.isFiltered) ...[
            FormCard(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  localization.paymentMeans,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 8),
                RawAutocomplete<String>(
                  textEditingController: _paymentMeansCodeController,
                  focusNode: _paymentMeansCodeFocusNode,
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    final filter = textEditingValue.text.toLowerCase();
                    return kPaymentMeansCodes.entries
                        .where((entry) =>
                            filter.isEmpty ||
                            entry.key.contains(filter) ||
                            entry.value.toLowerCase().contains(filter))
                        .map((entry) => '${entry.key} - ${entry.value}')
                        .toList();
                  },
                  onSelected: (value) {
                    final code = value.split(' - ').first;
                    setState(() => _paymentMeansCode = code);
                    _paymentMeansCodeController.text = value;
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    return DecoratedFormField(
                      label: localization.lookup('code'),
                      controller: textEditingController,
                      focusNode: focusNode,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) => onFieldSubmitted(),
                    );
                  },
                  optionsViewBuilder: (BuildContext context,
                      AutocompleteOnSelected<String> onSelected,
                      Iterable<String> options) {
                    final highlightedIndex =
                        AutocompleteHighlightedOption.of(context);
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 4,
                        child: Container(
                          color: Theme.of(context).cardColor,
                          width: 500,
                          constraints: BoxConstraints(maxHeight: 270),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                color: highlightedIndex == index
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withValues(alpha: 0.1)
                                    : Theme.of(context).cardColor,
                                child: ListTile(
                                  title: Text(
                                    options.elementAt(index),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  onTap: () =>
                                      onSelected(options.elementAt(index)),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (_visibleFields.contains('iban'))
                  DecoratedFormField(
                    label: 'IBAN',
                    controller: _ibanController,
                    keyboardType: TextInputType.text,
                  ),
                if (_visibleFields.contains('bic_swift'))
                  DecoratedFormField(
                    label: 'BIC/SWIFT',
                    controller: _bicSwiftController,
                    keyboardType: TextInputType.text,
                  ),
                if (_visibleFields.contains('account_holder'))
                  DecoratedFormField(
                    label: localization.accountHolder,
                    controller: _accountHolderController,
                    keyboardType: TextInputType.text,
                  ),
                if (_visibleFields.contains('payer_bank_account'))
                  DecoratedFormField(
                    label: localization.lookup('payer_bank_account'),
                    controller: _payerBankAccountController,
                    keyboardType: TextInputType.text,
                  ),
                if (_visibleFields.contains('bsb_sort'))
                  DecoratedFormField(
                    label: localization.lookup('bsb_sort'),
                    controller: _bsbSortController,
                    keyboardType: TextInputType.text,
                  ),
                if (_visibleFields.contains('card_type'))
                  DecoratedFormField(
                    label: localization.lookup('card_type'),
                    controller: _cardTypeController,
                    keyboardType: TextInputType.text,
                  ),
                if (_visibleFields.contains('card_number'))
                  DecoratedFormField(
                    label: localization.lookup('card_number'),
                    controller: _cardNumberController,
                    keyboardType: TextInputType.text,
                  ),
                if (_visibleFields.contains('card_holder'))
                  DecoratedFormField(
                    label: localization.lookup('card_holder'),
                    controller: _cardHolderController,
                    keyboardType: TextInputType.text,
                  ),
              ],
            ),
            _EUTaxDetails(
              company: company,
              localization: localization,
              store: store,
            ),
          ],
        ],
      ),
    );
  }
}

class _PeppolPreferences extends StatefulWidget {
  const _PeppolPreferences({
    required this.company,
    required this.localization,
    required this.store,
    required this.actsAsSender,
    required this.actsAsReceiver,
    required this.onSenderChanged,
    required this.onReceiverChanged,
  });

  final CompanyEntity company;
  final AppLocalization localization;
  final Store<AppState> store;
  final bool actsAsSender;
  final bool actsAsReceiver;
  final Function(bool) onSenderChanged;
  final Function(bool) onReceiverChanged;

  @override
  _PeppolPreferencesState createState() => _PeppolPreferencesState();
}

class _PeppolPreferencesState extends State<_PeppolPreferences> {
  String _quota = '';

  @override
  void initState() {
    super.initState();
    _loadQuota();
  }

  void _loadQuota() {
    final state = widget.store.state;
    final url = state.credentials.url + '/einvoice/quota';
    WebClient().get(url, state.credentials.token).then((response) {
      if (mounted) {
        setState(() {
          _quota = (response['quota'] ?? '').toString();
        });
      }
    }).catchError((_) {});
  }

  void _updatePeppolPreferences({
    required bool actsAsSender,
    required bool actsAsReceiver,
  }) {
    final state = widget.store.state;
    final url = state.credentials.url + '/einvoice/peppol/update';
    WebClient()
        .put(
      url,
      state.credentials.token,
      data: json.encode({
        'acts_as_sender': actsAsSender,
        'acts_as_receiver': actsAsReceiver,
        'legal_entity_id': widget.company.legalEntityId,
        'e_invoicing_token': '',
      }),
    )
        .then((_) {
      showToast(widget.localization.lookup('saved_settings'));
    }).catchError((error) {
      showErrorDialog(message: '$error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.store.state;
    final localization = widget.localization;
    final company = widget.company;

    return FormCard(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 18),
            SizedBox(width: 8),
            Text(
              '${localization.lookup('connected')}: ${company.legalEntityId}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        SizedBox(height: 16),
        BoolDropdownButton(
          label: localization.actAsSender,
          value: widget.actsAsSender,
          onChanged: (value) {
            widget.onSenderChanged(value!);
            _updatePeppolPreferences(
              actsAsSender: value,
              actsAsReceiver: widget.actsAsReceiver,
            );
          },
        ),
        BoolDropdownButton(
          label: localization.actAsReceiver,
          value: widget.actsAsReceiver,
          onChanged: (value) {
            widget.onReceiverChanged(value!);
            _updatePeppolPreferences(
              actsAsSender: widget.actsAsSender,
              actsAsReceiver: value,
            );
          },
        ),
        if (_quota.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              '${localization.lookup('credits')}: $_quota',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        SizedBox(height: 8),
        AppButton(
          label: localization.disconnect.toUpperCase(),
          color: Colors.red,
          onPressed: () {
            confirmCallback(
              context: context,
              message: localization.disconnect,
              callback: (_) {
                final url =
                    state.credentials.url + '/einvoice/peppol/disconnect';
                widget.store.dispatch(StartSaving());
                WebClient().post(url, state.credentials.token).then((_) {
                  widget.store.dispatch(StopSaving());
                  widget.store.dispatch(RefreshData());
                }).catchError((error) {
                  widget.store.dispatch(StopSaving());
                  showErrorDialog(message: '$error');
                });
              },
            );
          },
        ),
      ],
    );
  }
}

class _PeppolOnboarding extends StatelessWidget {
  const _PeppolOnboarding({
    required this.localization,
    required this.store,
    required this.isBusinessEntity,
    required this.onEntityTypeChanged,
    required this.partyNameController,
    required this.vatNumberController,
    required this.idNumberController,
    required this.line1Controller,
    required this.line2Controller,
    required this.cityController,
    required this.countyController,
    required this.zipController,
    required this.actsAsSender,
    required this.actsAsReceiver,
    required this.onSenderChanged,
    required this.onReceiverChanged,
    required this.countryId,
  });

  final AppLocalization localization;
  final Store<AppState> store;
  final bool isBusinessEntity;
  final Function(bool) onEntityTypeChanged;
  final TextEditingController partyNameController;
  final TextEditingController vatNumberController;
  final TextEditingController idNumberController;
  final TextEditingController line1Controller;
  final TextEditingController line2Controller;
  final TextEditingController cityController;
  final TextEditingController countyController;
  final TextEditingController zipController;
  final bool actsAsSender;
  final bool actsAsReceiver;
  final Function(bool) onSenderChanged;
  final Function(bool) onReceiverChanged;
  final String countryId;

  @override
  Widget build(BuildContext context) {
    final state = store.state;

    return FormCard(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'PEPPOL',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 16),
        RadioGroup<bool>(
          groupValue: isBusinessEntity,
          onChanged: (value) => onEntityTypeChanged(value!),
          child: Row(
            children: [
              Expanded(
                child: RadioListTile<bool>(
                  title: Text(localization.lookup('business')),
                  value: true,
                ),
              ),
              Expanded(
                child: RadioListTile<bool>(
                  title: Text(localization.individual),
                  value: false,
                ),
              ),
            ],
          ),
        ),
        DecoratedFormField(
          label: localization.companyName,
          controller: partyNameController,
          keyboardType: TextInputType.text,
        ),
        if (isBusinessEntity)
          DecoratedFormField(
            label: localization.vatNumber,
            controller: vatNumberController,
            keyboardType: TextInputType.text,
          )
        else
          DecoratedFormField(
            label: localization.idNumber,
            controller: idNumberController,
            keyboardType: TextInputType.text,
          ),
        DecoratedFormField(
          label: localization.address1,
          controller: line1Controller,
          keyboardType: TextInputType.text,
        ),
        DecoratedFormField(
          label: localization.address2,
          controller: line2Controller,
          keyboardType: TextInputType.text,
        ),
        DecoratedFormField(
          label: localization.city,
          controller: cityController,
          keyboardType: TextInputType.text,
        ),
        DecoratedFormField(
          label: localization.state,
          controller: countyController,
          keyboardType: TextInputType.text,
        ),
        DecoratedFormField(
          label: localization.postalCode,
          controller: zipController,
          keyboardType: TextInputType.text,
        ),
        BoolDropdownButton(
          label: localization.actAsSender,
          value: actsAsSender,
          onChanged: (value) => onSenderChanged(value!),
        ),
        BoolDropdownButton(
          label: localization.actAsReceiver,
          value: actsAsReceiver,
          onChanged: (value) => onReceiverChanged(value!),
        ),
        AppButton(
          label: localization.lookup('setup').toUpperCase(),
          onPressed: () {
            final company = state.company;
            final url = state.credentials.url + '/einvoice/peppol/setup';
            store.dispatch(StartSaving());
            WebClient()
                .post(
              url,
              state.credentials.token,
              data: json.encode({
                'party_name': partyNameController.text.trim(),
                'line1': line1Controller.text.trim(),
                'line2': line2Controller.text.trim(),
                'city': cityController.text.trim(),
                'county': countyController.text.trim(),
                'zip': zipController.text.trim(),
                'country': countryId,
                if (isBusinessEntity)
                  'vat_number': vatNumberController.text.trim()
                else
                  'id_number': idNumberController.text.trim(),
                'acts_as_sender': actsAsSender,
                'acts_as_receiver': actsAsReceiver,
                'classification': isBusinessEntity ? 'business' : 'individual',
                'tenant_id': company.id,
              }),
            )
                .then((_) {
              store.dispatch(StopSaving());
              showToast(localization.lookup('saved_settings'));
              store.dispatch(RefreshData());
            }).catchError((error) {
              store.dispatch(StopSaving());
              showErrorDialog(message: '$error');
            });
          },
        ),
      ],
    );
  }
}

class _EUTaxDetails extends StatefulWidget {
  const _EUTaxDetails({
    required this.company,
    required this.localization,
    required this.store,
  });

  final CompanyEntity company;
  final AppLocalization localization;
  final Store<AppState> store;

  @override
  _EUTaxDetailsState createState() => _EUTaxDetailsState();
}

class _EUTaxDetailsState extends State<_EUTaxDetails> {
  @override
  Widget build(BuildContext context) {
    final state = widget.store.state;
    final taxConfig = widget.company.taxConfig;
    final localization = widget.localization;
    final countryMap = state.staticState.countryMap;

    // Collect existing VAT identifiers from tax_data.regions
    final existingIdentifiers = <String, String>{};
    for (final regionEntry in taxConfig.regions.entries) {
      for (final subregionEntry in regionEntry.value.subregions.entries) {
        final vatNumber = subregionEntry.value.vatNumber;
        if (vatNumber.isNotEmpty) {
          existingIdentifiers[subregionEntry.key] = vatNumber;
        }
      }
    }

    return FormCard(
      isLast: true,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                localization.lookup('additional_tax_identifiers'),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: () => _showAddDialog(context),
            ),
          ],
        ),
        ...existingIdentifiers.entries.map((entry) {
          final iso2Code = entry.key;
          final vatNumber = entry.value;
          final country = countryMap.values.firstWhere(
            (c) => c.iso2 == iso2Code,
            orElse: () => countryMap.values.first,
          );
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: Text('${country.name}: $vatNumber'),
                ),
                IconButton(
                  icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                  onPressed: () {
                    final url = state.credentials.url +
                        '/einvoice/peppol/remove_additional_legal_identifier';
                    widget.store.dispatch(StartSaving());
                    WebClient()
                        .delete(
                      url,
                      state.credentials.token,
                      data: json.encode({
                        'country': country.id,
                        'vat_number': vatNumber,
                      }),
                    )
                        .then((_) {
                      widget.store.dispatch(StopSaving());
                      widget.store.dispatch(RefreshData());
                    }).catchError((error) {
                      widget.store.dispatch(StopSaving());
                      showErrorDialog(message: '$error');
                    });
                  },
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  void _showAddDialog(BuildContext context) {
    final state = widget.store.state;
    final countryMap = state.staticState.countryMap;
    String selectedCountryId = '';
    String vatNumber = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final peppolCountryList = countryMap.values
                .where((country) => kPeppolCountries.contains(country.id))
                .toList()
              ..sort((a, b) => a.name.compareTo(b.name));

            return AlertDialog(
              title: Text(widget.localization.lookup('add_tax_identifier')),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppDropdownButton<String>(
                    labelText: widget.localization.country,
                    value: selectedCountryId.isEmpty ? null : selectedCountryId,
                    showBlank: true,
                    onChanged: (dynamic value) {
                      setDialogState(() => selectedCountryId = value ?? '');
                    },
                    items: peppolCountryList
                        .map((country) => DropdownMenuItem<String>(
                              value: country.id,
                              child: Text(country.name),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: widget.localization.vatNumber,
                    ),
                    onChanged: (value) => vatNumber = value,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(widget.localization.cancel.toUpperCase()),
                ),
                TextButton(
                  onPressed: () {
                    if (selectedCountryId.isEmpty || vatNumber.isEmpty) {
                      return;
                    }
                    Navigator.pop(context);
                    final url = state.credentials.url +
                        '/einvoice/peppol/add_additional_legal_identifier';
                    widget.store.dispatch(StartSaving());
                    WebClient()
                        .post(
                      url,
                      state.credentials.token,
                      data: json.encode({
                        'country': selectedCountryId,
                        'vat_number': vatNumber,
                      }),
                    )
                        .then((_) {
                      widget.store.dispatch(StopSaving());
                      widget.store.dispatch(RefreshData());
                    }).catchError((error) {
                      widget.store.dispatch(StopSaving());
                      showErrorDialog(message: '$error');
                    });
                  },
                  child: Text(widget.localization.save.toUpperCase()),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
