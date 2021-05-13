import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/task_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaskSettings extends StatefulWidget {
  const TaskSettings({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final TaskSettingsVM viewModel;

  @override
  _TaskSettingsState createState() => _TaskSettingsState();
}

class _TaskSettingsState extends State<TaskSettings> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_taskSettings');
  FocusScopeNode _focusNode;
  final _taskRateController = TextEditingController();
  List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _taskRateController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    _taskRateController.text = formatNumber(
        widget.viewModel.settings.defaultTaskRate, context,
        formatNumberType: FormatNumberType.inputMoney);

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged() {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final settings = viewModel.settings.rebuild((b) => b
      ..defaultTaskRate = parseDouble(_taskRateController.text,
          zeroIsNull: state.settingsUIState.isFiltered));

    if (settings != viewModel.settings) {
      viewModel.onSettingsChanged(settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final company = viewModel.company;

    return EditScaffold(
      title: localization.taskSettings,
      onSavePressed: viewModel.onSavePressed,
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          FormCard(children: <Widget>[
            DecoratedFormField(
              controller: _taskRateController,
              label: localization.defaultTaskRate,
              onSavePressed: viewModel.onSavePressed,
              isMoney: true,
            ),
            if (!viewModel.state.settingsUIState.isFiltered) ...[
              SizedBox(height: 32),
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.autoStartTasks),
                value: company.autoStartTasks,
                subtitle: Text(localization.autoStartTasksHelp),
                onChanged: (value) => viewModel.onCompanyChanged(
                    company.rebuild((b) => b..autoStartTasks = value)),
              ),
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.showTaskEndDate),
                value: company.showTaskEndDate,
                subtitle: Text(localization.showTaskEndDateHelp),
                onChanged: (value) => viewModel.onCompanyChanged(
                    company.rebuild((b) => b..showTaskEndDate = value)),
              ),
            ]
          ]),
          if (!viewModel.state.settingsUIState.isFiltered)
            FormCard(
              children: <Widget>[
                SwitchListTile(
                  activeColor: Theme.of(context).accentColor,
                  title: Text(localization.showTasksTable),
                  value: company.showTasksTable,
                  subtitle: Text(localization.showTasksTableHelp),
                  onChanged: (value) => viewModel.onCompanyChanged(
                      company.rebuild((b) => b..showTasksTable = value)),
                ),
                SwitchListTile(
                  activeColor: Theme.of(context).accentColor,
                  title: Text(localization.invoiceTaskDatelog),
                  value: company.invoiceTaskDatelog,
                  subtitle: Text(localization.invoiceTaskDatelogHelp),
                  onChanged: (value) => viewModel.onCompanyChanged(
                      company.rebuild((b) => b..invoiceTaskDatelog = value)),
                ),
                SwitchListTile(
                  activeColor: Theme.of(context).accentColor,
                  title: Text(localization.invoiceTaskTimelog),
                  value: company.invoiceTaskTimelog,
                  subtitle: Text(localization.invoiceTaskTimelogHelp),
                  onChanged: (value) => viewModel.onCompanyChanged(
                      company.rebuild((b) => b..invoiceTaskTimelog = value)),
                ),
                SwitchListTile(
                  activeColor: Theme.of(context).accentColor,
                  title: Text(localization.addDocumentsToInvoice),
                  value: company.invoiceTaskDocuments ?? false,
                  subtitle: Text(localization.addDocumentsToInvoiceHelp),
                  onChanged: (value) => viewModel.onCompanyChanged(
                      company.rebuild((b) => b..invoiceTaskDocuments = value)),
                ),
              ],
            ),
          if (!viewModel.state.settingsUIState.isFiltered)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AppButton(
                iconData: Icons.settings,
                label: localization.configureStatuses.toUpperCase(),
                onPressed: () => viewModel.onConfigureStatusesPressed(context),
              ),
            ),
        ],
      ),
    );
  }
}
