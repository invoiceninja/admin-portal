import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
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
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_workflowSettings');

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

    return EditScaffold(
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
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    BoolDropdownButton(
                      label: localization.autoEmailInvoice,
                      helpLabel: localization.autoEmailInvoiceHelp,
                      value: settings.autoEmailInvoice,
                      onChanged: (value) => viewModel.onSettingsChanged(
                          settings.rebuild((b) => b..autoEmailInvoice = value)),
                      iconData:
                          kIsWeb ? Icons.email : FontAwesomeIcons.solidEnvelope,
                    ),
                    BoolDropdownButton(
                      label: localization.autoArchiveInvoice,
                      helpLabel: localization.autoArchiveInvoiceHelp,
                      value: settings.autoArchiveInvoice,
                      onChanged: (value) => viewModel.onSettingsChanged(settings
                          .rebuild((b) => b..autoArchiveInvoice = value)),
                      iconData:
                          kIsWeb ? Icons.archive : FontAwesomeIcons.archive,
                    ),
                  ],
                ),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    BoolDropdownButton(
                      label: localization.autoConvertQuote,
                      helpLabel: localization.autoConvertQuoteHelp,
                      value: settings.autoConvertQuote,
                      onChanged: (value) => viewModel.onSettingsChanged(
                          settings.rebuild((b) => b..autoConvertQuote = value)),
                      iconData:
                          kIsWeb ? Icons.book : FontAwesomeIcons.fileInvoice,
                    ),
                    BoolDropdownButton(
                      label: localization.autoArchiveQuote,
                      helpLabel: localization.autoArchiveQuoteHelp,
                      value: settings.autoArchiveQuote,
                      onChanged: (value) => viewModel.onSettingsChanged(
                          settings.rebuild((b) => b..autoArchiveQuote = value)),
                      iconData:
                          kIsWeb ? Icons.archive : FontAwesomeIcons.archive,
                    ),
                  ],
                ),
              ],
            ),
          ]),
    );
  }
}
