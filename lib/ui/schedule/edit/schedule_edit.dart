import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
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
import 'package:invoiceninja_flutter/utils/strings.dart';

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

  void _onSavePressed() {
    final bool isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    }

    widget.viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = state.company;
    final localization = AppLocalization.of(context);
    final schedule = viewModel.schedule;
    final parameters = schedule.parameters;

    return EditScaffold(
      title:
          schedule.isNew ? localization.newSchedule : localization.editSchedule,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) => _onSavePressed(),
      body: Form(
        key: _formKey,
        child: Builder(
          builder: (BuildContext context) {
            return ScrollableListView(
              children: <Widget>[
                FormCard(
                  isLast: schedule.template.isEmpty,
                  children: <Widget>[
                    DecoratedFormField(
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      controller: _nameController,
                      label: localization.name,
                      onSavePressed: (context) => _onSavePressed(),
                      validator: (value) =>
                          value.isEmpty ? localization.pleaseEnterAName : null,
                    ),
                    AppDropdownButton<String>(
                        labelText: localization.action,
                        value: schedule.template,
                        onChanged: (dynamic value) {
                          viewModel.onChanged(
                              schedule.rebuild((b) => b..template = value));
                        },
                        items: ScheduleEntity.TEMPLATES
                            .map((entry) => DropdownMenuItem(
                                  value: entry,
                                  child: Text(entry ==
                                          ScheduleEntity
                                              .TEMPLATE_SCHEDULE_ENTITY
                                      ? localization.emailRecord
                                      : localization.lookup(entry)),
                                ))
                            .toList()),
                    DatePicker(
                      labelText: localization.nextRun,
                      onSelected: (date, _) {
                        viewModel.onChanged(
                            schedule.rebuild((b) => b..nextRun = date));
                      },
                      selectedDate: schedule.nextRun,
                      firstDate: DateTime.now(),
                      validator: (value) => value.trim().isEmpty
                          ? localization.pleaseEnterAValue
                          : null,
                    ),
                    if (schedule.template !=
                        ScheduleEntity.TEMPLATE_SCHEDULE_ENTITY) ...[
                      AppDropdownButton<String>(
                          labelText: localization.frequency,
                          value: schedule.frequencyId,
                          showBlank: true,
                          blankLabel: localization.once,
                          onChanged: (dynamic value) {
                            viewModel.onChanged(
                              schedule.rebuild((b) => b
                                ..frequencyId = value
                                ..remainingCycles = value.isEmpty
                                    ? 1
                                    : schedule.frequencyId.isEmpty
                                        ? -1
                                        : schedule.remainingCycles),
                            );
                          },
                          items: kFrequencies.entries
                              .map((entry) => DropdownMenuItem(
                                    value: entry.key,
                                    child:
                                        Text(localization.lookup(entry.value)),
                                  ))
                              .toList()),
                      if (schedule.frequencyId.isNotEmpty)
                        AppDropdownButton<int>(
                          labelText: localization.remainingCycles,
                          value: schedule.remainingCycles,
                          blankValue: null,
                          onChanged: (dynamic value) => viewModel.onChanged(
                              schedule
                                  .rebuild((b) => b..remainingCycles = value)),
                          items: [
                            DropdownMenuItem(
                              child: Text(localization.endless),
                              value: -1,
                            ),
                            ...List<int>.generate(61, (i) => i)
                                .map((value) => DropdownMenuItem(
                                      child: Text('$value'),
                                      value: value,
                                    ))
                                .toList()
                          ],
                        ),
                    ],
                  ],
                ),
                if (schedule.template ==
                    ScheduleEntity.TEMPLATE_EMAIL_STATEMENT) ...[
                  FormCard(children: [
                    AppDropdownButton<DateRange>(
                      labelText: localization.dateRange,
                      blankValue: null,
                      value: parameters.dateRange.isNotEmpty
                          ? DateRange.valueOf(toCamelCase(parameters.dateRange))
                          : null,
                      onChanged: (dynamic value) {
                        viewModel.onChanged(schedule.rebuild((b) => b
                          ..parameters.dateRange =
                              (value as DateRange).snakeCase));
                      },
                      items: DateRange.values
                          .where((value) => value != DateRange.custom)
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
                          key:
                              ValueKey('__client_picker_${_clientClearedAt}__'),
                          isRequired: false,
                          clientId: null,
                          clientState: state.clientState,
                          excludeIds: parameters.clients.toList(),
                          onSelected: (value) {
                            if (!parameters.clients.contains(value.id)) {
                              viewModel.onChanged(schedule.rebuild(
                                  (b) => b..parameters.clients.add(value.id)));
                            }
                            setState(() {
                              _clientClearedAt =
                                  DateTime.now().toIso8601String();
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
                              viewModel.onChanged(schedule.rebuild((b) =>
                                  b..parameters.clients.remove(clientId)));
                            },
                          ),
                        ),
                    ],
                  )
                ] else if (schedule.template ==
                    ScheduleEntity.TEMPLATE_SCHEDULE_ENTITY) ...[
                  FormCard(
                    children: [
                      AppDropdownButton<String>(
                          labelText: localization.type,
                          value: parameters.entityType,
                          onChanged: (dynamic value) {
                            viewModel.onChanged(schedule.rebuild(
                                (b) => b..parameters.entityType = value));
                          },
                          items: [
                            EntityType.invoice,
                            EntityType.quote,
                            EntityType.credit,
                            EntityType.purchaseOrder
                          ]
                              .map((entityType) => DropdownMenuItem<String>(
                                    value: entityType.toString(),
                                    child: Text(
                                      localization
                                          .lookup(entityType.toString()),
                                    ),
                                  ))
                              .toList()),
                    ],
                  )
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
