import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
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

class _WorkflowSettingsState extends State<WorkflowSettings> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool autoValidate = false;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final settings = viewModel.settings;

    return SettingsScaffold(
      title: localization.workflowSettings,
      onSavePressed: viewModel.onSavePressed,
      body: AppForm(
        formKey: _formKey,
        children: <Widget>[
          FormCard(
            children: <Widget>[
              SwitchListTile(
                secondary: Icon(FontAwesomeIcons.solidEnvelope),
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.autoEmailInvoice),
                subtitle: Text(localization.autoEmailInvoiceHelp),
                value: settings.autoEmailInvoice ?? false,
                onChanged: (value) => viewModel.onSettingsChanged(settings.rebuild((b) => b
                  ..autoEmailInvoice = value
                )),
              ),
              SwitchListTile(
                secondary: Icon(FontAwesomeIcons.archive),
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.autoArchiveInvoice),
                subtitle: Text(localization.autoArchiveInvoiceHelp),
                value: settings.autoArchiveInvoice ?? false,
                onChanged: (value) => viewModel.onSettingsChanged(settings.rebuild((b) => b
                  ..autoArchiveInvoice = value
                )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
