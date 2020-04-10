import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/email_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

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
  final _bccEmailController = TextEditingController();
  final _emailStyleCustomController = TextEditingController();
  final _emailFooterController = TextEditingController();

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
      _bccEmailController,
      _emailStyleCustomController,
      _emailFooterController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final settings = widget.viewModel.settings;
    _replyToEmailController.text = settings.replyToEmail;
    _bccEmailController.text = settings.bccEmail;
    _emailStyleCustomController.text = settings.emailStyleCustom;
    _emailFooterController.text = settings.emailFooter;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    final settings = widget.viewModel.settings.rebuild((b) => b
      ..replyToEmail = _replyToEmailController.text.trim()
      ..bccEmail = _bccEmailController.text.trim()
      ..emailStyleCustom = _emailStyleCustomController.text.trim()
      ..emailFooter = _emailFooterController.text.trim());
    if (settings != widget.viewModel.settings) {
      widget.viewModel.onSettingsChanged(settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final settings = viewModel.settings;

    return EditScaffold(
      title: localization.emailSettings,
      onSavePressed: viewModel.onSavePressed,
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
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
              if (settings.emailStyle == kEmailDesignCustom) ...[
                SizedBox(height: 10),
                DecoratedFormField(
                  label: localization.custom,
                  controller: _emailStyleCustomController,
                  maxLines: 6,
                ),
              ]
            ],
          ),
          FormCard(
            children: <Widget>[
              DecoratedFormField(
                label: localization.replyToEmail,
                controller: _replyToEmailController,
                keyboardType: TextInputType.emailAddress,
              ),
              DecoratedFormField(
                label: localization.bccEmail,
                controller: _bccEmailController,
                keyboardType: TextInputType.emailAddress,
              ),
              /*
              SizedBox(height: 10),
              BoolDropdownButton(
                label: localization.enableMarkup,
                helpLabel: localization.enableMarkupHelp,
                value: settings.enableEmailMarkup,
                iconData: kIsWeb ? Icons.email : FontAwesomeIcons.solidEnvelope,
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..enableEmailMarkup = value)),
              ),
               */
            ],
          ),
          FormCard(
            children: <Widget>[
              DecoratedFormField(
                label: localization.emailSignature,
                controller: _emailFooterController,
                maxLines: 6,
              ),
            ],
          ),
          FormCard(
            children: <Widget>[
              BoolDropdownButton(
                label: localization.attachPdf,
                value: settings.pdfEmailAttachment,
                iconData: FontAwesomeIcons.fileInvoice,
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..pdfEmailAttachment = value)),
              ),
              BoolDropdownButton(
                label: localization.attachDocuments,
                value: settings.documentEmailAttachment,
                iconData: FontAwesomeIcons.fileImage,
                onChanged: (value) => viewModel.onSettingsChanged(settings
                    .rebuild((b) => b..documentEmailAttachment = value)),
              ),
              BoolDropdownButton(
                label: localization.attachUbl,
                value: settings.ublEmailAttachment,
                iconData: FontAwesomeIcons.fileArchive,
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
