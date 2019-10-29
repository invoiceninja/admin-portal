import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/ui/settings/workflow_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class WorkflowSettings extends StatefulWidget {
  const WorkflowSettings({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final WorkflowSettingsVM viewModel;

  @override
  _WorkflowSettingsState createState() => _WorkflowSettingsState();
}

class _WorkflowSettingsState extends State<WorkflowSettings>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusScopeNode _focusNode;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
    _controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final settings = viewModel.settings;

    return SettingsScaffold(
      title: localization.workflowSettings,
      onSavePressed: viewModel.onSavePressed,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        tabs: [
          Tab(
            text: localization.invoices,
          ),
          Tab(
            text: localization.quotes,
          ),
        ],
      ),
      body: AppTabForm(
          tabController: _controller,
          formKey: _formKey,
          focusNode: _focusNode,
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                SwitchListTile(
                  secondary: Icon(FontAwesomeIcons.solidEnvelope),
                  activeColor: Theme.of(context).accentColor,
                  title: Text(localization.autoEmailInvoice),
                  subtitle: Text(localization.autoEmailInvoiceHelp),
                  value: settings.autoEmailInvoice ?? false,
                  onChanged: (value) => viewModel.onSettingsChanged(
                      settings.rebuild((b) => b..autoEmailInvoice = value)),
                ),
                SwitchListTile(
                  secondary: Icon(FontAwesomeIcons.archive),
                  activeColor: Theme.of(context).accentColor,
                  title: Text(localization.autoArchiveInvoice),
                  subtitle: Text(localization.autoArchiveInvoiceHelp),
                  value: settings.autoArchiveInvoice ?? false,
                  onChanged: (value) => viewModel.onSettingsChanged(
                      settings.rebuild((b) => b..autoArchiveInvoice = value)),
                ),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                SwitchListTile(
                  secondary: Icon(FontAwesomeIcons.fileInvoice),
                  activeColor: Theme.of(context).accentColor,
                  title: Text(localization.autoConvertQuote),
                  subtitle: Text(localization.autoConvertQuoteHelp),
                  value: settings.autoConvertQuote ?? false,
                  onChanged: (value) => viewModel.onSettingsChanged(
                      settings.rebuild((b) => b..autoConvertQuote = value)),
                ),
                SwitchListTile(
                  secondary: Icon(FontAwesomeIcons.archive),
                  activeColor: Theme.of(context).accentColor,
                  title: Text(localization.autoArchiveQuote),
                  subtitle: Text(localization.autoArchiveQuoteHelp),
                  value: settings.autoArchiveQuote ?? false,
                  onChanged: (value) => viewModel.onSettingsChanged(
                      settings.rebuild((b) => b..autoArchiveQuote = value)),
                ),
              ],
            ),
          ]),
    );
  }
}
