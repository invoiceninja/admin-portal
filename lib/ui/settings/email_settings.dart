import 'dart:convert';

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
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';

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
  ZefyrController _zefyrController;
  FocusNode _focusNode;
  bool autoValidate = false;

  final _replyToEmailController = TextEditingController();
  final _bccEmailController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();

    final Delta delta = Delta()..insert('\n');
    final doc = NotusDocument.fromDelta(delta);

    _tabController = TabController(vsync: this, length: 2);
    _zefyrController = ZefyrController(doc);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _zefyrController.dispose();
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

    final settings = widget.viewModel.settings;
    final signature = settings.emailFooter ?? '';
    // return NotusDocument.fromJson(jsonDecode(contents));
    _zefyrController.compose(Delta()..insert(signature));

    //_replyToEmailController.text = ;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    /*
    final product = widget.viewModel.product.rebuild((b) => b
      ..customValue2 = _custom2Controller.text.trim());
    if (product != widget.viewModel.product) {
      widget.viewModel.onChanged(product);
    }
    */
  }

  void _onSavePressed(BuildContext context) {
    final viewModel = widget.viewModel;
    final settings = viewModel.settings;
    viewModel.onSettingsChanged(settings.rebuild((b) => b
        ..emailFooter = jsonEncode(_zefyrController.document)
    ));
    viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;

    return SettingsScaffold(
      title: localization.emailSettings,
      onSavePressed: _onSavePressed,
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
                    value: false,
                    iconData: FontAwesomeIcons.link,
                    showBlank: state.settingsUIState.isFiltered,
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
                    value: false,
                    iconData: FontAwesomeIcons.fileInvoice,
                    showBlank: state.settingsUIState.isFiltered,
                  ),
                  BoolDropdownButton(
                    label: localization.attachDocuments,
                    value: false,
                    iconData: FontAwesomeIcons.fileImage,
                    showBlank: state.settingsUIState.isFiltered,
                  ),
                  BoolDropdownButton(
                    label: localization.attachUbl,
                    value: false,
                    iconData: FontAwesomeIcons.fileArchive,
                    showBlank: state.settingsUIState.isFiltered,
                  ),
                ],
              ),
            ],
          ),
          Container(
            color: Colors.white,
            child: ZefyrScaffold(
              child: ZefyrEditor(
                padding: EdgeInsets.all(16),
                controller: _zefyrController,
                focusNode: _focusNode,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
