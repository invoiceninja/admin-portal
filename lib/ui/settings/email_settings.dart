// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
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
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EmailSettingsVM viewModel;

  @override
  _EmailSettingsState createState() => _EmailSettingsState();
}

class _EmailSettingsState extends State<EmailSettings> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_emailSettings');

  FocusScopeNode _focusNode;

  final _fromNameController = TextEditingController();
  final _replyToEmailController = TextEditingController();
  final _replyToNameController = TextEditingController();
  final _bccEmailController = TextEditingController();
  final _emailStyleCustomController = TextEditingController();
  final _emailSignatureController = TextEditingController();
  final _postmarkSecretController = TextEditingController();
  final _mailgunSecretController = TextEditingController();
  final _mailgunDomainController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();

    _focusNode = FocusScopeNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
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
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final settings = widget.viewModel.settings;
    _fromNameController.text = settings.emailFromName;
    _replyToEmailController.text = settings.replyToEmail;
    _replyToNameController.text = settings.replyToName;
    _bccEmailController.text = settings.bccEmail;
    _emailStyleCustomController.text = settings.emailStyleCustom;
    _emailSignatureController.text = settings.emailSignature;
    _postmarkSecretController.text = settings.postmarkSecret;
    _mailgunSecretController.text = settings.mailgunSecret;
    _mailgunDomainController.text = settings.mailgunDomain;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    final settings = widget.viewModel.settings.rebuild((b) => b
      ..emailFromName = _fromNameController.text.trim()
      ..replyToEmail = _replyToEmailController.text.trim()
      ..replyToName = _replyToNameController.text.trim()
      ..bccEmail = _bccEmailController.text.trim()
      ..emailStyleCustom = _emailStyleCustomController.text.trim()
      ..emailSignature = _emailSignatureController.text.trim()
      ..postmarkSecret = _postmarkSecretController.text.trim()
      ..mailgunSecret = _mailgunSecretController.text.trim()
      ..mailgunDomain = _mailgunDomainController.text.trim());
    if (settings != widget.viewModel.settings) {
      widget.viewModel.onSettingsChanged(settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final settings = viewModel.settings;
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
      onSavePressed: disableSave ? null : viewModel.onSavePressed,
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          FormCard(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AppDropdownButton<String>(
                showBlank: state.uiState.settingsUIState.isFiltered,
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
                  label: localization.secret,
                  controller: _postmarkSecretController,
                  keyboardType: TextInputType.text,
                ),
              ] else if (settings.emailSendingMethod ==
                  SettingsEntity.EMAIL_SENDING_METHOD_MAILGUN) ...[
                DecoratedFormField(
                  label: localization.secret,
                  controller: _mailgunSecretController,
                  keyboardType: TextInputType.text,
                ),
                DecoratedFormField(
                  label: localization.domain,
                  controller: _mailgunDomainController,
                  keyboardType: TextInputType.text,
                ),
              ]
            ],
          ),
          FormCard(
            children: <Widget>[
              DecoratedFormField(
                label: localization.fromName,
                controller: _fromNameController,
                onSavePressed: viewModel.onSavePressed,
                keyboardType: TextInputType.name,
              ),
              DecoratedFormField(
                label: localization.replyToName,
                controller: _replyToNameController,
                onSavePressed: viewModel.onSavePressed,
                keyboardType: TextInputType.name,
              ),
              DecoratedFormField(
                label: localization.replyToEmail,
                controller: _replyToEmailController,
                keyboardType: TextInputType.emailAddress,
                onSavePressed: viewModel.onSavePressed,
              ),
              DecoratedFormField(
                label: localization.bccEmail,
                controller: _bccEmailController,
                keyboardType: TextInputType.emailAddress,
                hint: localization.commaSeparatedList,
                onSavePressed: viewModel.onSavePressed,
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
                    if (viewModel.state.company.settings.enableMilitaryTime) {
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
            ],
          ),
          FormCard(
            isLast: true,
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
            ],
          ),
        ],
      ),
    );
  }
}
