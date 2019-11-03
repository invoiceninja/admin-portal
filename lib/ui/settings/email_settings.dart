import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/email_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
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

class _EmailSettingsState extends State<EmailSettings>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TabController _tabController;
  FocusScopeNode _focusNode;
  bool autoValidate = false;

  final _replyToEmailController = TextEditingController();
  final _bccEmailController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);
    _focusNode = FocusScopeNode();
  }

  @override
  void dispose() {
    _tabController.dispose();
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
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    //final settings = widget.viewModel.settings;
    //final signature = settings.emailFooter;

    // return NotusDocument.fromJson(jsonDecode(contents));
    //_zefyrController.compose(Delta()..insert(signature));

    //_replyToEmailController.text = ;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {}

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final settings = viewModel.settings;

    return SettingsScaffold(
      title: localization.emailSettings,
      onSavePressed: viewModel.onSavePressed,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _tabController,
        tabs: [
          Tab(
            text: localization.settings,
          ),
          Tab(
            text: localization.emailSignature,
          ),
        ],
      ),
      body: AppTabForm(
        tabController: _tabController,
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          ListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: localization.emailDesign,
                    ),
                    isEmpty: false,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: kEmailDesignPlain,
                        onChanged: (value) => null,
                        isExpanded: true,
                        isDense: true,
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
                    ),
                  ),
                  SizedBox(height: 10),
                  BoolDropdownButton(
                    label: localization.enableMarkup,
                    helpLabel: localization.enableMarkupHelp,
                    value: settings.enableEmailMarkup,
                    iconData: FontAwesomeIcons.solidEnvelope,
                    onChanged: (value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..enableEmailMarkup = value)),
                  ),
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
          Container(
            color: Colors.grey.shade100,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
