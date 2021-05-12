import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/user/user_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/dynamic_selector.dart';
import 'package:invoiceninja_flutter/ui/settings/email_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
  bool autoValidate = false;

  final _replyToEmailController = TextEditingController();
  final _replyToNameController = TextEditingController();
  final _bccEmailController = TextEditingController();
  final _emailStyleCustomController = TextEditingController();
  final _emailSignatureController = TextEditingController();

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
      _replyToEmailController,
      _replyToNameController,
      _bccEmailController,
      _emailStyleCustomController,
      _emailSignatureController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final settings = widget.viewModel.settings;
    _replyToEmailController.text = settings.replyToEmail;
    _replyToNameController.text = settings.replyToName;
    _bccEmailController.text = settings.bccEmail;
    _emailStyleCustomController.text = settings.emailStyleCustom;
    _emailSignatureController.text = settings.emailSignature;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    final settings = widget.viewModel.settings.rebuild((b) => b
      ..replyToEmail = _replyToEmailController.text.trim()
      ..replyToName = _replyToNameController.text.trim()
      ..bccEmail = _bccEmailController.text.trim()
      ..emailStyleCustom = _emailStyleCustomController.text.trim()
      ..emailSignature = _emailSignatureController.text.trim());
    if (settings != widget.viewModel.settings) {
      widget.viewModel.onSettingsChanged(settings);
    }
  }

  void _onSavePressed(BuildContext context) {
    final viewModel = widget.viewModel;
    final settings = viewModel.settings;
    final sendingUserId = settings.gmailSendingUserId ?? '';
    final sendingMethod = settings.emailSendingMethod;

    if (sendingMethod == SettingsEntity.EMAIL_SENDING_METHOD_GMAIL &&
        sendingUserId.isEmpty) {
      showErrorDialog(
          context: context,
          message: AppLocalization.of(context).selectAGmailUser);
      return;
    }

    viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final settings = viewModel.settings;
    final gmailUserIds = memoizedGmailUserList(viewModel.state.userState.map);

    return EditScaffold(
      title: localization.emailSettings,
      isAdvancedSettings: true,
      onSavePressed: _onSavePressed,
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          if (viewModel.state.authState.isHosted) ...[
            FormCard(children: <Widget>[
              BoolDropdownButton(
                label: localization.sendFromGmail,
                value: settings.emailSendingMethod ==
                    SettingsEntity.EMAIL_SENDING_METHOD_GMAIL,
                iconData: MdiIcons.gmail,
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b
                      ..emailSendingMethod = (value == true
                          ? SettingsEntity.EMAIL_SENDING_METHOD_GMAIL
                          : SettingsEntity.EMAIL_SENDING_METHOD_DEFAULT))),
              ),
              if (settings.emailSendingMethod ==
                  SettingsEntity.EMAIL_SENDING_METHOD_GMAIL)
                if (gmailUserIds.isEmpty) ...[
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlineButton(
                          child: Text(localization.connectGmail.toUpperCase()),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            final store = StoreProvider.of<AppState>(context);
                            store.dispatch(ViewSettings(
                              section: kSettingsUserDetails,
                            ));
                          },
                        ),
                      ),
                    ],
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
                        return '${user.fullName} <${user.email}>';
                      },
                    ),
                  ),
            ]),
          ],
          FormCard(
            children: <Widget>[
              DecoratedFormField(
                label: localization.replyToName,
                controller: _replyToNameController,
                onSavePressed: viewModel.onSavePressed,
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
                showUseDefault: true,
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
            children: <Widget>[
              BoolDropdownButton(
                label: localization.attachPdf,
                value: settings.pdfEmailAttachment,
                iconData: MdiIcons.filePdf,
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
