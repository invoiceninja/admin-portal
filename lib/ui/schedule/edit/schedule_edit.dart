import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/client_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/schedule/edit/schedule_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';

class ScheduleEdit extends StatefulWidget {
  const ScheduleEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ScheduleEditVM viewModel;

  @override
  _ScheduleEditState createState() => _ScheduleEditState();
}

class _ScheduleEditState extends State<ScheduleEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_scheduleEdit');
  final _debouncer = Debouncer();
  String _clientClearedAt = '';

  // STARTER: controllers - do not remove comment
  final _nameController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _nameController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final schedule = widget.viewModel.schedule;
    _nameController.text = schedule.name;

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    _debouncer.run(() {
      final schedule = widget.viewModel.schedule.rebuild((b) => b
        // STARTER: set value - do not remove comment
        ..name = _nameController.text.trim());
      if (schedule != widget.viewModel.schedule) {
        widget.viewModel.onChanged(schedule);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final localization = AppLocalization.of(context);
    final schedule = viewModel.schedule;
    final parameters = schedule.parameters;

    return EditScaffold(
      title:
          schedule.isNew ? localization.newSchedule : localization.editSchedule,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

        if (!isValid) {
          return;
        }

        viewModel.onSavePressed(context);
      },
      body: Form(
        key: _formKey,
        child: Builder(
          builder: (BuildContext context) {
            return ScrollableListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    DecoratedFormField(
                      keyboardType: TextInputType.text,
                      controller: _nameController,
                      label: localization.name,
                      validator: (value) =>
                          value.isEmpty ? localization.pleaseEnterAName : null,
                    ),
                    AppDropdownButton<String>(
                        labelText: localization.template,
                        value: schedule.template,
                        onChanged: (dynamic value) {
                          viewModel.onChanged(
                              schedule.rebuild((b) => b..template = value));
                        },
                        items: kScheduleTemplates.entries
                            .map((entry) => DropdownMenuItem(
                                  value: entry.key,
                                  child: Text(localization.lookup(entry.value)),
                                ))
                            .toList()),
                    AppDropdownButton<String>(
                        labelText: localization.frequency,
                        value: schedule.frequencyId,
                        showBlank: true,
                        blankLabel: localization.once,
                        onChanged: (dynamic value) {
                          viewModel.onChanged(
                              schedule.rebuild((b) => b..frequencyId = value));
                        },
                        items: kFrequencies.entries
                            .map((entry) => DropdownMenuItem(
                                  value: entry.key,
                                  child: Text(localization.lookup(entry.value)),
                                ))
                            .toList()),
                  ],
                ),
                FormCard(children: [
                  DatePicker(
                    labelText: localization.nextSendDate,
                    onSelected: (date, _) {
                      viewModel.onChanged(
                          schedule.rebuild((b) => b..nextRun = date));
                    },
                    selectedDate: schedule.nextRun,
                    firstDate: DateTime.now(),
                  ),
                  AppDropdownButton<DateRange>(
                    labelText: localization.dateRange,
                    blankValue: null,
                    value: parameters.dateRange.isNotEmpty
                        ? DateRange.valueOf(parameters.dateRange)
                        : null,
                    onChanged: (dynamic value) {
                      final updated = schedule.rebuild(
                          (b) => b..parameters.dateRange = value.toString());
                      viewModel.onChanged(updated);
                    },
                    items: DateRange.values
                        .map((dateRange) => DropdownMenuItem<DateRange>(
                              child: Text(
                                  localization.lookup(dateRange.toString())),
                              value: dateRange,
                            ))
                        .toList(),
                  ),
                  AppDropdownButton<String>(
                    labelText: localization.status,
                    blankValue: null,
                    value: parameters.status,
                    onChanged: (dynamic value) {
                      viewModel.onChanged(schedule
                          .rebuild((b) => b..parameters.status = value));
                    },
                    items: [
                      kStatementStatusAll,
                      kStatementStatusPaid,
                      kStatementStatusUnpaid,
                    ]
                        .map((value) => DropdownMenuItem<String>(
                              child: Text(localization.lookup(value)),
                              value: value,
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 20),
                  BoolDropdownButton(
                      label: localization.showAgingTable,
                      value: parameters.showAgingTable,
                      onChanged: (value) {
                        viewModel.onChanged(schedule.rebuild(
                            (b) => b..parameters.showAgingTable = value));
                      }),
                  BoolDropdownButton(
                      label: localization.showPaymentsTable,
                      value: parameters.showPaymentsTable,
                      onChanged: (value) {
                        viewModel.onChanged(schedule.rebuild(
                            (b) => b..parameters.showPaymentsTable = value));
                      }),
                ]),
                FormCard(
                  isLast: true,
                  children: [
                    ClientPicker(
                        key: ValueKey('__client_picker_${_clientClearedAt}__'),
                        isRequired: false,
                        clientId: null,
                        clientState: state.clientState,
                        onSelected: (value) {
                          if (!parameters.clients.contains(value.id)) {
                            viewModel.onChanged(schedule.rebuild(
                                (b) => b..parameters.clients.add(value.id)));
                          }
                          setState(() {
                            _clientClearedAt = DateTime.now().toIso8601String();
                          });
                        }),
                    SizedBox(height: 20),
                    if (parameters.clients.isEmpty)
                      HelpText(localization.allClients),
                    for (var clientId in parameters.clients)
                      ListTile(
                        title:
                            Text(state.clientState.get(clientId).displayName),
                        trailing: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            viewModel.onChanged(schedule.rebuild(
                                (b) => b..parameters.clients.remove(clientId)));
                          },
                        ),
                      ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
