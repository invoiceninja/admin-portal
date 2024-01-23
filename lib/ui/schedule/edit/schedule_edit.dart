import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/import_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_selectors.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_selectors.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/client_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/schedule/edit/schedule_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

class ScheduleEdit extends StatefulWidget {
  const ScheduleEdit({
    Key? key,
    required this.viewModel,
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

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      //
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    //final schedule = widget.viewModel.schedule;

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
      final schedule = widget.viewModel.schedule.rebuild((b) => b);
      if (schedule != widget.viewModel.schedule) {
        widget.viewModel.onChanged(schedule);
      }
    });
  }

  void _onSavePressed() {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    widget.viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final localization = AppLocalization.of(context);
    final schedule = viewModel.schedule;
    final parameters = schedule.parameters;

    final invoiceIds = memoizedDropdownInvoiceList(
      state.invoiceState.map,
      state.clientState.map,
      state.vendorState.map,
      state.invoiceState.list,
      '',
      state.userState.map,
      [],
      state.company.settings.recurringNumberPrefix,
    );

    final quoteIds = memoizedDropdownQuoteList(
        state.quoteState.map,
        state.clientState.map,
        state.vendorState.map,
        state.quoteState.list,
        '',
        state.userState.map, []);

    final creditIds = memoizedDropdownCreditList(
        state.creditState.map,
        state.clientState.map,
        state.vendorState.map,
        state.creditState.list,
        '',
        state.userState.map, []);

    final purchaseOrderIds = memoizedDropdownPurchaseOrderList(
        state.purchaseOrderState.map,
        state.purchaseOrderState.list,
        state.staticState,
        state.userState.map,
        state.clientState.map,
        state.vendorState.map,
        '');

    return EditScaffold(
      title: schedule.isNew
          ? localization!.newSchedule
          : localization!.editSchedule,
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
                    AppDropdownButton<String>(
                        labelText: localization.action,
                        value: schedule.template,
                        onChanged: (dynamic value) {
                          if (schedule.template == value) {
                            return;
                          }

                          viewModel.onChanged(
                            schedule.rebuild((b) => b
                              ..template = value
                              //..frequencyId =
                              //    value == ScheduleEntity.TEMPLATE_EMAIL_RECORD
                              //        ? kFrequencyOnce
                              //        : schedule.frequencyId
                              ..parameters.replace(ScheduleParameters(value))),
                          );
                        },
                        items: ScheduleEntity.TEMPLATES
                            .where((entry) =>
                                supportsLatestFeatures('5.8.0') ||
                                entry != ScheduleEntity.TEMPLATE_EMAIL_REPORT)
                            .map((entry) => DropdownMenuItem(
                                  value: entry,
                                  child: Text(localization.lookup(entry)),
                                ))
                            .toList()),
                    DatePicker(
                      autofocus: true,
                      hint: localization.datePickerHint,
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
                        ScheduleEntity.TEMPLATE_EMAIL_RECORD) ...[
                      AppDropdownButton<String>(
                          labelText: localization.frequency,
                          value: schedule.frequencyId,
                          //showBlank: true,
                          //blankLabel: localization.once,
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
                    ScheduleEntity.TEMPLATE_EMAIL_REPORT) ...[
                  FormCard(
                    isLast: true,
                    children: [
                      AppDropdownButton<String>(
                          value: schedule.parameters.reportName,
                          labelText: localization.report,
                          onChanged: (dynamic value) {
                            setState(() {
                              viewModel.onChanged(schedule.rebuild(
                                  (b) => b..parameters.reportName = value));
                            });
                          },
                          items: ExportType.values
                              .map((importType) => DropdownMenuItem<String>(
                                  value: importType.name,
                                  child:
                                      Text(localization.lookup('$importType'))))
                              .toList()),
                      AppDropdownButton<DateRange>(
                        labelText: localization.dateRange,
                        blankValue: null,
                        value: parameters.dateRange!.isNotEmpty
                            ? DateRange.valueOf(
                                toCamelCase(parameters.dateRange!))
                            : null,
                        onChanged: (dynamic value) {
                          viewModel.onChanged(schedule.rebuild((b) => b
                            ..parameters.dateRange =
                                (value as DateRange).snakeCase));
                        },
                        items: DateRange.values
                            .where((value) => value != DateRange.custom)
                            .map((dateRange) => DropdownMenuItem<DateRange>(
                                  child: Text(localization
                                      .lookup(dateRange.toString())),
                                  value: dateRange,
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ] else if (schedule.template ==
                    ScheduleEntity.TEMPLATE_EMAIL_STATEMENT) ...[
                  FormCard(children: [
                    AppDropdownButton<DateRange>(
                      labelText: localization.dateRange,
                      blankValue: null,
                      value: parameters.dateRange!.isNotEmpty
                          ? DateRange.valueOf(
                              toCamelCase(parameters.dateRange!))
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
                    BoolDropdownButton(
                        label: localization.onlyClientsWithInvoices,
                        value: parameters.onlyClientsWithInvoices,
                        onChanged: (value) {
                          viewModel.onChanged(schedule.rebuild((b) =>
                              b..parameters.onlyClientsWithInvoices = value));
                        }),
                  ]),
                  FormCard(
                    isLast: true,
                    children: [
                      ClientPicker(
                          key: ValueKey(
                              '__statement_client_picker_${_clientClearedAt}__'),
                          isRequired: false,
                          clientId: null,
                          clientState: state.clientState,
                          excludeIds: parameters.clients!.toList(),
                          onSelected: (value) {
                            if (value == null) {
                              return;
                            }
                            if (!parameters.clients!.contains(value.id)) {
                              viewModel.onChanged(schedule.rebuild(
                                  (b) => b..parameters.clients.add(value.id)));
                            }
                            setState(() {
                              _clientClearedAt =
                                  DateTime.now().toIso8601String();
                            });
                          }),
                      SizedBox(height: 20),
                      if (parameters.clients!.isEmpty)
                        HelpText(localization.allClients),
                      for (var clientId in parameters.clients!)
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
                    ScheduleEntity.TEMPLATE_EMAIL_RECORD) ...[
                  FormCard(
                    isLast: true,
                    children: [
                      AppDropdownButton<String>(
                          labelText: localization.type,
                          value: parameters.entityType,
                          onChanged: (dynamic value) {
                            viewModel.onChanged(schedule.rebuild((b) => b
                              ..parameters.entityType = value
                              ..parameters.entityId = ''));
                          },
                          items: [
                            EntityType.invoice,
                            EntityType.quote,
                            EntityType.credit,
                            EntityType.purchaseOrder
                          ]
                              .map((entityType) => DropdownMenuItem<String>(
                                    value: entityType.apiValue,
                                    child: Text(
                                      localization.lookup(entityType.apiValue),
                                    ),
                                  ))
                              .toList()),
                      if (parameters.entityType == EntityType.invoice.apiValue)
                        EntityDropdown(
                          labelText: localization.invoice,
                          entityType: EntityType.invoice,
                          entityList: invoiceIds,
                          entityId: parameters.entityId,
                          onSelected: (value) {
                            viewModel.onChanged(schedule.rebuild((b) =>
                                b..parameters.entityId = value?.id ?? ''));
                          },
                        )
                      else if (parameters.entityType ==
                          EntityType.quote.apiValue)
                        EntityDropdown(
                          labelText: localization.quote,
                          entityType: EntityType.quote,
                          entityList: quoteIds,
                          entityId: parameters.entityId,
                          onSelected: (value) {
                            viewModel.onChanged(schedule.rebuild((b) =>
                                b..parameters.entityId = value?.id ?? ''));
                          },
                        )
                      else if (parameters.entityType ==
                          EntityType.credit.apiValue)
                        EntityDropdown(
                          labelText: localization.credit,
                          entityType: EntityType.credit,
                          entityList: creditIds,
                          entityId: parameters.entityId,
                          onSelected: (value) {
                            viewModel.onChanged(schedule.rebuild((b) =>
                                b..parameters.entityId = value?.id ?? ''));
                          },
                        )
                      else if (parameters.entityType ==
                          EntityType.purchaseOrder.apiValue)
                        EntityDropdown(
                          labelText: localization.purchaseOrder,
                          entityType: EntityType.purchaseOrder,
                          entityList: purchaseOrderIds,
                          entityId: parameters.entityId,
                          onSelected: (value) {
                            viewModel.onChanged(schedule.rebuild((b) =>
                                b..parameters.entityId = value?.id ?? ''));
                          },
                        )
                    ],
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
