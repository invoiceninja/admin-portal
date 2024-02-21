// Flutter imports:
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/files.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/user/user_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/dynamic_selector.dart';
import 'package:invoiceninja_flutter/ui/settings/email_settings_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class EmailSettings extends StatefulWidget {
  const EmailSettings({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final EmailSettingsVM viewModel;

  @override
  _EmailSettingsState createState() => _EmailSettingsState();
}

class _EmailSettingsState extends State<EmailSettings> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_emailSettings');

  FocusScopeNode? _focusNode;

  final _fromNameController = TextEditingController();
  final _replyToEmailController = TextEditingController();
  final _replyToNameController = TextEditingController();
  final _bccEmailController = TextEditingController();
  final _emailStyleCustomController = TextEditingController();
  final _emailSignatureController = TextEditingController();
  final _postmarkSecretController = TextEditingController();
  final _mailgunSecretController = TextEditingController();
  final _mailgunDomainController = TextEditingController();
  final _customSendingEmailController = TextEditingController();
  final _eInvoiceCertificatePassphraseController = TextEditingController();
  final _smtpHostController = TextEditingController();
  final _smtpPortController = TextEditingController();
  final _smtpUsernameController = TextEditingController();
  final _smtpPasswordController = TextEditingController();
  final _smtpLocalDomainController = TextEditingController();

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
      _fromNameController,
      _replyToEmailController,
      _replyToNameController,
      _bccEmailController,
      _emailStyleCustomController,
      _emailSignatureController,
      _postmarkSecretController,
      _mailgunSecretController,
      _mailgunDomainController,
      _customSendingEmailController,
      _eInvoiceCertificatePassphraseController,
      _smtpHostController,
      _smtpPortController,
      _smtpUsernameController,
      _smtpPasswordController,
      _smtpLocalDomainController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final viewModel = widget.viewModel;
    final company = viewModel.company;
    final settings = viewModel.settings;

    _fromNameController.text = settings.emailFromName ?? '';
    _replyToEmailController.text = settings.replyToEmail ?? '';
    _replyToNameController.text = settings.replyToName ?? '';
    _bccEmailController.text = settings.bccEmail ?? '';
    _emailStyleCustomController.text = settings.emailStyleCustom ?? '';
    _emailSignatureController.text = settings.emailSignature ?? '';
    _postmarkSecretController.text = settings.postmarkSecret ?? '';
    _customSendingEmailController.text = settings.customSendingEmail ?? '';
    _mailgunSecretController.text = settings.mailgunSecret ?? '';
    _mailgunDomainController.text = settings.mailgunDomain ?? '';
    _eInvoiceCertificatePassphraseController.text =
        company.eInvoiceCertificatePassphrase;
    _smtpHostController.text = company.smtpHost;
    _smtpPortController.text = company.smtpPort.toString();
    _smtpUsernameController.text = company.smtpUsername;
    _smtpPasswordController.text = company.smtpPassword;
    _smtpLocalDomainController.text = company.smtpLocalDomain;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    final emailFromName = _fromNameController.text.trim();
    final replyToEmail = _replyToEmailController.text.trim();
    final replyToName = _replyToNameController.text.trim();
    final bccEmail = _bccEmailController.text.trim();
    final emailStyleCustom = _emailStyleCustomController.text.trim();
    final emailSignature = _emailSignatureController.text.trim();
    final postmarkSecret = _postmarkSecretController.text.trim();
    final mailgunSecret = _mailgunSecretController.text.trim();
    final mailgunDomain = _mailgunDomainController.text.trim();
    final customSendingEmail = _customSendingEmailController.text.trim();
    final eInvoiceCertificatePassphrase =
        _eInvoiceCertificatePassphraseController.text.trim();

    final viewModel = widget.viewModel;
    final isFiltered = viewModel.state.settingsUIState.isFiltered;
    final settings = viewModel.settings.rebuild((b) => b
      ..emailFromName =
          isFiltered && emailFromName.isEmpty ? null : emailFromName
      ..replyToEmail = isFiltered && replyToEmail.isEmpty ? null : replyToEmail
      ..replyToName = isFiltered && replyToName.isEmpty ? null : replyToName
      ..bccEmail = isFiltered && bccEmail.isEmpty ? null : bccEmail
      ..emailStyleCustom =
          isFiltered && emailStyleCustom.isEmpty ? null : emailStyleCustom
      ..emailSignature =
          isFiltered && emailSignature.isEmpty ? null : emailSignature
      ..postmarkSecret =
          isFiltered && postmarkSecret.isEmpty ? null : postmarkSecret
      ..mailgunSecret =
          isFiltered && mailgunSecret.isEmpty ? null : mailgunSecret
      ..mailgunDomain =
          isFiltered && mailgunDomain.isEmpty ? null : mailgunDomain
      ..customSendingEmail =
          isFiltered && customSendingEmail.isEmpty ? null : customSendingEmail);
    if (settings != viewModel.settings) {
      viewModel.onSettingsChanged(settings);
    }

    final company = viewModel.company.rebuild((b) => b
      ..eInvoiceCertificatePassphrase =
          isFiltered && eInvoiceCertificatePassphrase.isEmpty
              ? null
              : eInvoiceCertificatePassphrase
      ..smtpHost = _smtpHostController.text.trim()
      ..smtpPort = parseInt(_smtpPortController.text.trim())
      ..smtpUsername = _smtpUsernameController.text.trim()
      ..smtpPassword = _smtpPasswordController.text.trim()
      ..smtpLocalDomain = _smtpLocalDomainController.text.trim());
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
    final gmailUserIds = memoizedGmailUserList(viewModel.state.userState.map);
    final microsoftUserIds =
        memoizedMicrosoftUserList(viewModel.state.userState.map);

    final gmailSendingUserId = settings.gmailSendingUserId ?? '';
    final disableSave = [
          SettingsEntity.EMAIL_SENDING_METHOD_GMAIL,
          SettingsEntity.EMAIL_SENDING_METHOD_MICROSOFT
        ].contains(settings.emailSendingMethod) &&
        (gmailSendingUserId.isEmpty || gmailSendingUserId == '0');

    return EditScaffold(
      title: localization.emailSettings,
      onSavePressed: disableSave ? null : _onSavePressed,
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          FormCard(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AppDropdownButton<String>(
                showBlank: settingsUIState.isFiltered,
                labelText: localization.emailProvider,
                value: settings.emailSendingMethod,
                onChanged: (dynamic value) {
                  viewModel.onSettingsChanged(
                      settings.rebuild((b) => b..emailSendingMethod = value));
                },
                items: [
                  DropdownMenuItem(
                      child: Text(localization.defaultWord),
                      value: SettingsEntity.EMAIL_SENDING_METHOD_DEFAULT),
                  if (supportsLatestFeatures('5.8.0') && state.isProPlan)
                    DropdownMenuItem(
                        child: Text('SMTP'),
                        value: SettingsEntity.EMAIL_SENDING_METHOD_SMTP),
                  if (viewModel.state.isHosted) ...[
                    DropdownMenuItem(
                        child: Text('Gmail'),
                        value: SettingsEntity.EMAIL_SENDING_METHOD_GMAIL),
                    DropdownMenuItem(
                        child: Text('Microsoft'),
                        value: SettingsEntity.EMAIL_SENDING_METHOD_MICROSOFT),
                  ],
                  DropdownMenuItem(
                      child: Text('Postmark'),
                      value: SettingsEntity.EMAIL_SENDING_METHOD_POSTMARK),
                  DropdownMenuItem(
                      child: Text('Mailgun'),
                      value: SettingsEntity.EMAIL_SENDING_METHOD_MAILGUN),
                ],
              ),
              if (settings.emailSendingMethod ==
                  SettingsEntity.EMAIL_SENDING_METHOD_GMAIL)
                if (gmailUserIds.isEmpty) ...[
                  SizedBox(height: 20),
                  if (isApple() || isDesktopOS())
                    Text(
                      localization.useWebAppToConnectGmail,
                      textAlign: TextAlign.center,
                    )
                  else
                    OutlinedButton(
                      child: Text(localization.connectGmail.toUpperCase()),
                      onPressed: () {
                        final store = StoreProvider.of<AppState>(context);
                        store.dispatch(ViewSettings(
                          section: kSettingsUserDetails,
                          force: true,
                        ));
                      },
                    )
                ] else
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: DynamicSelector(
                      onChanged: (userId) => viewModel.onSettingsChanged(
                          settings
                              .rebuild((b) => b..gmailSendingUserId = userId)),
                      entityType: EntityType.user,
                      entityId: settings.gmailSendingUserId,
                      entityIds: gmailUserIds,
                      overrideSuggestedLabel: (entity) {
                        final user = entity as UserEntity;
                        return '${user.fullName} • ${user.email}';
                      },
                    ),
                  )
              else if (settings.emailSendingMethod ==
                  SettingsEntity.EMAIL_SENDING_METHOD_MICROSOFT)
                if (microsoftUserIds.isEmpty) ...[
                  SizedBox(height: 20),
                  if (isApple() || !kIsWeb)
                    Text(
                      localization.useWebAppToConnectMicrosoft,
                      textAlign: TextAlign.center,
                    )
                  else
                    OutlinedButton(
                      child: Text(localization.connectMicrosoft.toUpperCase()),
                      onPressed: () {
                        final store = StoreProvider.of<AppState>(context);
                        store.dispatch(ViewSettings(
                          section: kSettingsUserDetails,
                          force: true,
                        ));
                      },
                    )
                ] else
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: DynamicSelector(
                      onChanged: (userId) => viewModel.onSettingsChanged(
                          settings
                              .rebuild((b) => b..gmailSendingUserId = userId)),
                      entityType: EntityType.user,
                      entityId: settings.gmailSendingUserId,
                      entityIds: microsoftUserIds,
                      overrideSuggestedLabel: (entity) {
                        final user = entity as UserEntity;
                        return '${user.fullName} • ${user.email}';
                      },
                    ),
                  )
              else if (settings.emailSendingMethod ==
                  SettingsEntity.EMAIL_SENDING_METHOD_POSTMARK) ...[
                DecoratedFormField(
                  label: localization.apiToken,
                  controller: _postmarkSecretController,
                  keyboardType: TextInputType.text,
                  onSavePressed: _onSavePressed,
                  validator: (value) => value.trim().isEmpty
                      ? localization.pleaseEnterAValue
                      : null,
                ),
              ] else if (settings.emailSendingMethod ==
                  SettingsEntity.EMAIL_SENDING_METHOD_MAILGUN) ...[
                DecoratedFormField(
                  label: localization.apiKey,
                  controller: _mailgunSecretController,
                  keyboardType: TextInputType.text,
                  onSavePressed: _onSavePressed,
                  validator: (value) => value.trim().isEmpty
                      ? localization.pleaseEnterAValue
                      : null,
                ),
                DecoratedFormField(
                  label: localization.domain,
                  controller: _mailgunDomainController,
                  keyboardType: TextInputType.text,
                  onSavePressed: _onSavePressed,
                  validator: (value) => value.trim().isEmpty
                      ? localization.pleaseEnterAValue
                      : null,
                ),
                AppDropdownButton<String>(
                    labelText: localization.endpoint,
                    value: settings.mailgunEndpoint,
                    onChanged: (dynamic value) {
                      viewModel.onSettingsChanged(
                          settings.rebuild((b) => b..mailgunEndpoint = value));
                    },
                    items: [
                      SettingsEntity.MAILGUN_ENDPOINT_US,
                      SettingsEntity.MAILGUN_ENDPOINT_EU
                    ]
                        .map((endpoint) => DropdownMenuItem<String>(
                              child: Text(endpoint),
                              value: endpoint,
                            ))
                        .toList())
              ] else if (settings.emailSendingMethod ==
                      SettingsEntity.EMAIL_SENDING_METHOD_SMTP &&
                  !settingsUIState.isFiltered) ...[
                DecoratedFormField(
                  label: localization.host,
                  controller: _smtpHostController,
                  keyboardType: TextInputType.url,
                  onSavePressed: _onSavePressed,
                  validator: (value) => value.trim().isEmpty
                      ? localization.pleaseEnterAValue
                      : null,
                ),
                DecoratedFormField(
                  label: localization.port,
                  controller: _smtpPortController,
                  keyboardType: TextInputType.number,
                  onSavePressed: _onSavePressed,
                  validator: (value) => value.trim().isEmpty
                      ? localization.pleaseEnterAValue
                      : null,
                ),
                AppDropdownButton<String>(
                    labelText: localization.encryption,
                    value: viewModel.company.smtpEncryption,
                    onChanged: (value) {
                      viewModel.onCompanyChanged(viewModel.company
                          .rebuild((b) => b..smtpEncryption = value));
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text(CompanyEntity.SMTP_ENCRYPTION_TLS),
                        value: CompanyEntity.SMTP_ENCRYPTION_TLS,
                      ),
                      DropdownMenuItem(
                        child: Text(CompanyEntity.SMTP_ENCRYPTION_STARTTLS),
                        value: CompanyEntity.SMTP_ENCRYPTION_STARTTLS,
                      ),
                    ]),
                DecoratedFormField(
                  label: localization.username,
                  controller: _smtpUsernameController,
                  keyboardType: TextInputType.text,
                  onSavePressed: _onSavePressed,
                  validator: (value) => value.trim().isEmpty
                      ? localization.pleaseEnterAValue
                      : null,
                ),
                DecoratedFormField(
                  label: localization.password,
                  obscureText: true,
                  controller: _smtpPasswordController,
                  keyboardType: TextInputType.text,
                  onSavePressed: _onSavePressed,
                  validator: (value) => value.trim().isEmpty
                      ? localization.pleaseEnterAValue
                      : null,
                ),
                DecoratedFormField(
                  label: localization.localDomain,
                  controller: _smtpLocalDomainController,
                  keyboardType: TextInputType.url,
                  onSavePressed: _onSavePressed,
                ),
                SizedBox(height: 10),
                BoolDropdownButton(
                    label: localization.verifyPeer,
                    value: viewModel.company.smtpVerifyPeer,
                    onChanged: (value) {
                      viewModel.onCompanyChanged(viewModel.company.rebuild(
                        (b) => b..smtpVerifyPeer = value,
                      ));
                    }),
                SizedBox(height: 20),
                OutlinedButton(
                    onPressed: () async {
                      final credentials = state.credentials;
                      final url = '${credentials.url}/smtp/check';
                      final company = viewModel.company;

                      final data = {
                        'smtp_host': company.smtpHost,
                        'smtp_port': company.smtpPort,
                        'smtp_encryption': company.smtpEncryption,
                        if (company.smtpUsername != '********')
                          'smtp_username': company.smtpUsername,
                        if (company.smtpPassword != '********')
                          'smtp_password': company.smtpPassword,
                        'smtp_local_domain': company.smtpLocalDomain,
                        'smtp_verify_peer': company.smtpVerifyPeer,
                      };

                      final store = StoreProvider.of<AppState>(context);
                      store.dispatch(StartSaving());

                      try {
                        final response = await WebClient().post(
                            url, credentials.token,
                            data: json.encode(data));
                        store.dispatch(StopSaving());
                        showMessageDialog(message: localization.testEmailSent);
                        //showMessageDialog(message: '$response');
                      } catch (error) {
                        store.dispatch(StopSaving());
                        showErrorDialog(message: '$error');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(localization.sendTestEmail.toUpperCase()),
                    )),
              ],
            ],
          ),
          FormCard(
            children: <Widget>[
              if ([
                SettingsEntity.EMAIL_SENDING_METHOD_MAILGUN,
                SettingsEntity.EMAIL_SENDING_METHOD_POSTMARK
              ].contains(settings.emailSendingMethod))
                DecoratedFormField(
                  label: localization.fromEmail,
                  controller: _customSendingEmailController,
                  keyboardType: TextInputType.text,
                  onSavePressed: _onSavePressed,
                ),
              DecoratedFormField(
                label: localization.fromName,
                controller: _fromNameController,
                onSavePressed: _onSavePressed,
                keyboardType: TextInputType.name,
              ),
              DecoratedFormField(
                label: localization.replyToEmail,
                controller: _replyToEmailController,
                keyboardType: TextInputType.emailAddress,
                onSavePressed: _onSavePressed,
              ),
              DecoratedFormField(
                label: localization.replyToName,
                controller: _replyToNameController,
                onSavePressed: _onSavePressed,
                keyboardType: TextInputType.name,
              ),
              DecoratedFormField(
                label: localization.bccEmail,
                controller: _bccEmailController,
                keyboardType: TextInputType.emailAddress,
                hint: localization.commaSeparatedList,
                onSavePressed: _onSavePressed,
              ),
              AppDropdownButton<int>(
                  showBlank: true,
                  labelText: localization.sendTime,
                  value: settings.entitySendTime,
                  blankValue: null,
                  onChanged: (dynamic value) => viewModel.onSettingsChanged(
                      settings.rebuild((b) => b..entitySendTime = value)),
                  items: List<int>.generate(24, (i) => i).map((value) {
                    final hour = value + 1;
                    String timeLabel;
                    if (viewModel.state.company.settings.enableMilitaryTime!) {
                      timeLabel = '$hour:00';
                    } else {
                      if (hour > 12) {
                        timeLabel = '${hour - 12}:00 ';
                      } else {
                        timeLabel = '$hour:00 ';
                      }

                      if (hour < 12 || hour == 24) {
                        timeLabel += 'AM';
                      } else {
                        timeLabel += 'PM';
                      }
                    }
                    return DropdownMenuItem(
                      child: Text(timeLabel),
                      value: hour,
                    );
                  }).toList()),
              /*
              SizedBox(height: 10),
              BoolDropdownButton(
                label: localization.enableMarkup,
                helpLabel: localization.enableMarkupHelp,
                value: settings.enableEmailMarkup,
                iconData: kIsWeb ? Icons.email : MdiIcons.solidEnvelope,
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..enableEmailMarkup = value)),
              ),
               */
            ],
          ),
          FormCard(
            children: <Widget>[
              AppDropdownButton<String>(
                labelText: localization.emailDesign,
                value: viewModel.settings.emailStyle,
                onChanged: (dynamic value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..emailStyle = value)),
                items: [
                  DropdownMenuItem(
                    child: Text(localization.plain),
                    value: kEmailDesignPlain,
                  ),
                  DropdownMenuItem(
                    child: Text(localization.light),
                    value: kEmailDesignLight,
                  ),
                  DropdownMenuItem(
                    child: Text(localization.dark),
                    value: kEmailDesignDark,
                  ),
                  DropdownMenuItem(
                    child: Text(localization.custom),
                    value: kEmailDesignCustom,
                  ),
                ],
              ),
              AppDropdownButton<String>(
                showBlank: true,
                labelText: localization.emailAlignment,
                value: viewModel.settings.emailAlignment,
                onChanged: (dynamic value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..emailAlignment = value)),
                items: [
                  DropdownMenuItem(
                    child: Text(localization.left),
                    value: SettingsEntity.EMAIL_ALIGNMENT_LEFT,
                  ),
                  DropdownMenuItem(
                    child: Text(localization.center),
                    value: SettingsEntity.EMAIL_ALIGNMENT_CENTER,
                  ),
                  DropdownMenuItem(
                    child: Text(localization.right),
                    value: SettingsEntity.EMAIL_ALIGNMENT_RIGHT,
                  ),
                ],
              ),
              if (settings.emailStyle == kEmailDesignCustom) ...[
                SizedBox(height: 10),
                DecoratedFormField(
                  label: localization.custom,
                  controller: _emailStyleCustomController,
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                  hint: localization.addBodyVariableMessage
                      .replaceFirst(':body', '\$body'),
                ),
              ],
              DecoratedFormField(
                label: localization.emailSignature,
                controller: _emailSignatureController,
                maxLines: 6,
                keyboardType: TextInputType.multiline,
              ),
              if (!settingsUIState.isFiltered) SizedBox(height: 16),
              BoolDropdownButton(
                label: localization.showEmailFooter,
                value: settingsUIState.isFiltered
                    ? settings.showEmailFooter
                    : (settings.showEmailFooter ?? true),
                iconData: MdiIcons.textBox,
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..showEmailFooter = value)),
              ),
            ],
          ),
          FormCard(
            isLast: true,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              BoolDropdownButton(
                label: localization.attachPdf,
                value: settings.pdfEmailAttachment,
                iconData: MdiIcons.filePdfBox,
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..pdfEmailAttachment = value)),
              ),
              BoolDropdownButton(
                label: localization.attachDocuments,
                value: settings.documentEmailAttachment,
                iconData: MdiIcons.fileImage,
                onChanged: (value) => viewModel.onSettingsChanged(settings
                    .rebuild((b) => b..documentEmailAttachment = value)),
              ),
              BoolDropdownButton(
                label: localization.attachUbl,
                value: settings.ublEmailAttachment,
                iconData: MdiIcons.xml,
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..ublEmailAttachment = value)),
              ),
              BoolDropdownButton(
                label: localization.enableEInvoice,
                value: settings.enableEInvoice,
                iconData: MdiIcons.fileXmlBox,
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..enableEInvoice = value)),
              ),
              if (settings.enableEInvoice == true) ...[
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
                            padding: const EdgeInsets.all(8),
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
