// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:invoiceninja_flutter/ui/settings/e_invoice_settings_vm.dart';
import 'package:invoiceninja_flutter/utils/files.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
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
      GlobalKey<FormState>(debugLabel: '_emailSettings');

  FocusScopeNode? _focusNode;

  final _eInvoiceCertificatePassphraseController = TextEditingController();

  List<TextEditingController> _controllers = [];

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
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _eInvoiceCertificatePassphraseController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final viewModel = widget.viewModel;
    final company = viewModel.company;

    _eInvoiceCertificatePassphraseController.text =
        company.eInvoiceCertificatePassphrase;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    final eInvoiceCertificatePassphrase =
        _eInvoiceCertificatePassphraseController.text.trim();

    final viewModel = widget.viewModel;
    final isFiltered = viewModel.state.settingsUIState.isFiltered;

    /*8
    final settings = viewModel.settings.rebuild((b) => b
      ..customSendingEmail =
          isFiltered && customSendingEmail.isEmpty ? null : customSendingEmail);
    if (settings != viewModel.settings) {
      viewModel.onSettingsChanged(settings);
    }
    */

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

    widget.viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = viewModel.state.company;
    final settings = viewModel.settings;
    final settingsUIState = state.settingsUIState;

    return EditScaffold(
      title: localization.emailSettings,
      onSavePressed: _onSavePressed,
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          FormCard(
            isLast: true,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                Padding(
                  padding:
                      EdgeInsets.only(top: settingsUIState.isFiltered ? 0 : 12),
                  child: AppDropdownButton<String>(
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
                        child: OutlinedButton(
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
                              viewModel
                                  .onEInvoiceCertificateSelected(files.first);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                                localization.uploadCertificate.toUpperCase()),
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
                        child: DecoratedFormField(
                          label: localization.certificatePassphrase,
                          controller: _eInvoiceCertificatePassphraseController,
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
                  )
                ],
              ],
            ],
          ),
        ],
      ),
    );
  }
}
