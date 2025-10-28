// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/settings_model.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/task_settings_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class TaskSettings extends StatefulWidget {
  const TaskSettings({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final TaskSettingsVM viewModel;

  @override
  _TaskSettingsState createState() => _TaskSettingsState();
}

class _TaskSettingsState extends State<TaskSettings> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_taskSettings');
  FocusScopeNode? _focusNode;
  final _taskRateController = TextEditingController();
  final _taskRoundToNearestController = TextEditingController();
  late List<TextEditingController> _controllers;
  bool _showCustomTaskRounding = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();

    _showCustomTaskRounding = widget.viewModel.settings.isTaskRoundingCustom;
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _taskRateController,
      _taskRoundToNearestController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final settings = widget.viewModel.settings;
    _taskRateController.text = formatNumber(settings.defaultTaskRate, context,
        formatNumberType: FormatNumberType.inputMoney)!;
    _taskRoundToNearestController.text =
        (settings.taskRoundToNearest ?? 0).toString();

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
    _focusNode!.dispose();
    super.dispose();
  }

  void _onChanged() {
    final viewModel = widget.viewModel;
    final state = viewModel.state;

    final seconds = parseInt(_taskRoundToNearestController.text.trim());
    final settings = viewModel.settings.rebuild((b) => b
      ..defaultTaskRate = parseDouble(_taskRateController.text.trim(),
          zeroIsNull: state.settingsUIState.isFiltered)
      ..taskRoundToNearest = seconds == null ? null : seconds);

    if (settings != viewModel.settings) {
      viewModel.onSettingsChanged(settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final company = viewModel.company;
    final settings = viewModel.settings;

    return EditScaffold(
      title: localization.taskSettings,
      onSavePressed: viewModel.onSavePressed,
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          FormCard(
            children: <Widget>[
              DecoratedFormField(
                controller: _taskRateController,
                label: localization.defaultTaskRate,
                onSavePressed: viewModel.onSavePressed,
                isMoney: true,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
              ),
              if (!viewModel.state.settingsUIState.isFiltered) ...[
                SizedBox(height: 32),
                SwitchListTile(
                  activeThumbColor: Theme.of(context).colorScheme.secondary,
                  title: Text(localization.autoStartTasks),
                  value: company.autoStartTasks,
                  subtitle: Text(localization.autoStartTasksHelp),
                  onChanged: (value) => viewModel.onCompanyChanged(
                      company.rebuild((b) => b..autoStartTasks = value)),
                ),
                SwitchListTile(
                  activeThumbColor: Theme.of(context).colorScheme.secondary,
                  title: Text(localization.showTaskEndDate),
                  value: company.showTaskEndDate,
                  subtitle: Text(localization.showTaskEndDateHelp),
                  onChanged: (value) => viewModel.onCompanyChanged(
                      company.rebuild((b) => b..showTaskEndDate = value)),
                ),
                SwitchListTile(
                  activeThumbColor: Theme.of(context).colorScheme.secondary,
                  title: Text(localization.showTaskItemDescription),
                  value: settings.showTaskItemDescription!,
                  subtitle: Text(localization.showTaskItemDescriptionHelp),
                  onChanged: (value) => viewModel.onSettingsChanged(settings
                      .rebuild((b) => b..showTaskItemDescription = value)),
                ),
                SwitchListTile(
                  activeThumbColor: Theme.of(context).colorScheme.secondary,
                  title: Text(localization.showTaskBillable),
                  value: settings.allowBillableTaskItems!,
                  subtitle: Text(localization.allowBillableTaskItemsHelp),
                  onChanged: (value) => viewModel.onSettingsChanged(settings
                      .rebuild((b) => b..allowBillableTaskItems = value)),
                ),
              ],
              if (supportsLatestFeatures('5.8.55'))
                BoolDropdownButton(
                  label: localization.roundTasks,
                  value: settings.taskRoundingEnabled,
                  helpLabel: localization.roundTasksHelp,
                  onChanged: (value) =>
                      viewModel.onSettingsChanged(settings.rebuild(
                    (b) => b
                      ..taskRoundToNearest = value == true
                          ? 60 * 15
                          : value == false
                              ? 1
                              : null,
                  )),
                ),
              if (settings.taskRoundingEnabled == true) ...[
                BoolDropdownButton(
                  label: localization.direction,
                  value: settings.taskRoundUp,
                  onChanged: (value) => viewModel.onSettingsChanged(
                      settings.rebuild((b) => b.taskRoundUp = value)),
                  disabledLabel: localization.roundDown,
                  enabledLabel: localization.roundUp,
                ),
                AppDropdownButton<int>(
                  value:
                      settings.isTaskRoundingCustom || _showCustomTaskRounding
                          ? 0
                          : settings.taskRoundToNearest,
                  labelText: localization.taskRoundToNearest,
                  onChanged: (value) {
                    final updated =
                        settings.rebuild((b) => b..taskRoundToNearest = value);
                    viewModel.onSettingsChanged(updated);
                    setState(() {
                      _showCustomTaskRounding = updated.isTaskRoundingCustom;
                      _taskRoundToNearestController.text =
                          (settings.taskRoundToNearest ?? 0).toString();
                    });
                  },
                  items: kTaskRoundingOptions.keys
                      .map((roundTo) => DropdownMenuItem(
                            child: Text(localization.lookup(roundTo)),
                            value: kTaskRoundingOptions[roundTo],
                          ))
                      .toList(),
                ),
                if (_showCustomTaskRounding || settings.isTaskRoundingCustom)
                  DecoratedFormField(
                    keyboardType: TextInputType.number,
                    label: localization.roundToSeconds,
                    controller: _taskRoundToNearestController,
                  ),
              ],
            ],
          ),
          if (!viewModel.state.settingsUIState.isFiltered)
            Padding(
              padding: const EdgeInsets.only(
                  top: 0, bottom: 10, right: 16, left: 16),
              child: AppButton(
                iconData: Icons.settings,
                label: localization.configureStatuses.toUpperCase(),
                onPressed: () => viewModel.onConfigureStatusesPressed(context),
              ),
            ),
          FormCard(
            children: <Widget>[
              if (!viewModel.state.settingsUIState.isFiltered) ...[
                SwitchListTile(
                  activeThumbColor: Theme.of(context).colorScheme.secondary,
                  title: Text(localization.invoiceTaskDatelog),
                  value: company.invoiceTaskDatelog,
                  subtitle: Text(localization.invoiceTaskDatelogHelp),
                  onChanged: (value) => viewModel.onCompanyChanged(
                      company.rebuild((b) => b..invoiceTaskDatelog = value)),
                ),
                SwitchListTile(
                  activeThumbColor: Theme.of(context).colorScheme.secondary,
                  title: Text(localization.invoiceTaskTimelog),
                  value: company.invoiceTaskTimelog,
                  subtitle: Text(localization.invoiceTaskTimelogHelp),
                  onChanged: (value) => viewModel.onCompanyChanged(
                      company.rebuild((b) => b..invoiceTaskTimelog = value)),
                ),
                SwitchListTile(
                  activeThumbColor: Theme.of(context).colorScheme.secondary,
                  title: Text(localization.invoiceTaskHours),
                  value: company.invoiceTaskHours,
                  subtitle: Text(localization.invoiceTaskHoursHelp),
                  onChanged: (value) => viewModel.onCompanyChanged(
                      company.rebuild((b) => b..invoiceTaskHours = value)),
                ),
                if (settings.showTaskItemDescription == true)
                  SwitchListTile(
                    activeThumbColor: Theme.of(context).colorScheme.secondary,
                    title: Text(localization.invoiceTaskItemDescription),
                    value: company.invoiceTaskItemDescription,
                    subtitle: Text(localization.invoiceTaskItemDescriptionHelp),
                    onChanged: (value) => viewModel.onCompanyChanged(company
                        .rebuild((b) => b..invoiceTaskItemDescription = value)),
                  ),
                SwitchListTile(
                  activeThumbColor: Theme.of(context).colorScheme.secondary,
                  title: Text(localization.invoiceTaskProject),
                  value: company.invoiceTaskProject,
                  subtitle: Text(localization.invoiceTaskProjectHelp),
                  onChanged: (value) => viewModel.onCompanyChanged(
                      company.rebuild((b) => b..invoiceTaskProject = value)),
                ),
                if (company.invoiceTaskProject) ...[
                  SizedBox(height: 10),
                  AppDropdownButton<bool>(
                      labelText: localization.projectLocation,
                      value: company.invoiceTaskProjectHeader,
                      onChanged: (dynamic value) {
                        viewModel.onCompanyChanged(company.rebuild(
                            (b) => b..invoiceTaskProjectHeader = value));
                      },
                      items: [
                        DropdownMenuItem(
                          child: Text(localization.service),
                          value: false,
                        ),
                        DropdownMenuItem(
                          child: Text(localization.description),
                          value: true,
                        ),
                      ]),
                ],
              ],
            ],
          ),
          if (!viewModel.state.settingsUIState.isFiltered)
            FormCard(
              children: [
                SwitchListTile(
                  activeThumbColor: Theme.of(context).colorScheme.secondary,
                  title: Text(localization.showTasksTable),
                  value: company.showTasksTable,
                  subtitle: Text(localization.showTasksTableHelp),
                  onChanged: (value) => viewModel.onCompanyChanged(
                      company.rebuild((b) => b..showTasksTable = value)),
                ),
                SwitchListTile(
                  activeThumbColor: Theme.of(context).colorScheme.secondary,
                  title: Text(localization.lockInvoicedTasks),
                  value: company.invoiceTaskLock,
                  subtitle: Text(localization.lockInvoicedTasksHelp),
                  onChanged: (value) => viewModel.onCompanyChanged(
                      company.rebuild((b) => b..invoiceTaskLock = value)),
                ),
                SwitchListTile(
                  activeThumbColor: Theme.of(context).colorScheme.secondary,
                  title: Text(localization.addDocumentsToInvoice),
                  value: company.invoiceTaskDocuments,
                  subtitle: Text(localization.addDocumentsToInvoiceHelp),
                  onChanged: (value) => viewModel.onCompanyChanged(
                      company.rebuild((b) => b..invoiceTaskDocuments = value)),
                ),
              ],
            ),
          FormCard(
            isLast: true,
            children: [
              BoolDropdownButton(
                label: localization.clientPortal,
                value: settings.enablePortalTasks,
                iconData: getSettingIcon(kSettingsClientPortal),
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..enablePortalTasks = value)),
              ),
              SizedBox(height: 10),
              AppDropdownButton<String>(
                labelText: localization.tasksShownInPortal,
                value: settings.clientPortalTasks,
                onChanged: ((settings.enablePortalTasks ?? false) != false)
                    ? (dynamic value) {
                        viewModel.onSettingsChanged(settings
                            .rebuild((b) => b..clientPortalTasks = value));
                      }
                    : null,
                items: [
                  SettingsEntity.PORTAL_TASKS_INVOICED,
                  SettingsEntity.PORTAL_TASKS_UNINVOICED,
                  SettingsEntity.PORTAL_TASKS_ALL,
                ]
                    .map((value) => DropdownMenuItem(
                          child: Text(localization.lookup(value)),
                          value: value,
                        ))
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
