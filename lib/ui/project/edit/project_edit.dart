// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/user_picker.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/project/edit/project_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProjectEdit extends StatefulWidget {
  const ProjectEdit({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final ProjectEditVM viewModel;

  @override
  _ProjectEditState createState() => _ProjectEditState();
}

class _ProjectEditState extends State<ProjectEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_projectEdit');
  final _debouncer = Debouncer();

  final _numberController = TextEditingController();
  final _nameController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _hoursController = TextEditingController();
  final _taskRateController = TextEditingController();
  final _privateNotesController = TextEditingController();
  final _publicNotesController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();
  final _custom3Controller = TextEditingController();
  final _custom4Controller = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _numberController,
      _nameController,
      _dueDateController,
      _hoursController,
      _taskRateController,
      _privateNotesController,
      _publicNotesController,
      _custom1Controller,
      _custom2Controller,
      _custom3Controller,
      _custom4Controller,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final project = widget.viewModel.project;
    _numberController.text = project.number;
    _nameController.text = project.name;
    _dueDateController.text = project.dueDate;
    _hoursController.text = formatNumber(project.budgetedHours, context,
        formatNumberType: FormatNumberType.inputAmount)!;
    _taskRateController.text = formatNumber(project.taskRate, context,
        formatNumberType: FormatNumberType.inputMoney)!;
    _privateNotesController.text = project.privateNotes;
    _publicNotesController.text = project.publicNotes;
    _custom1Controller.text = project.customValue1;
    _custom2Controller.text = project.customValue2;
    _custom3Controller.text = project.customValue3;
    _custom4Controller.text = project.customValue4;

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
    final project = widget.viewModel.project.rebuild((b) => b
      ..number = _numberController.text.trim()
      ..name = _nameController.text.trim()
      ..budgetedHours = parseDouble(_hoursController.text)
      ..taskRate = parseDouble(_taskRateController.text)
      ..publicNotes = _publicNotesController.text.trim()
      ..privateNotes = _privateNotesController.text.trim()
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim()
      ..customValue3 = _custom3Controller.text.trim()
      ..customValue4 = _custom4Controller.text.trim());
    if (project != widget.viewModel.project) {
      _debouncer.run(() {
        widget.viewModel.onChanged(project);
      });
    }
  }

  void _onSavePressed(BuildContext context) {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    widget.viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final state = viewModel.state;
    final project = viewModel.project;

    return EditScaffold(
      entity: project,
      title:
          project.isNew ? localization!.newProject : localization!.editProject,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: _onSavePressed,
      body: Form(
        key: _formKey,
        child: Builder(builder: (BuildContext context) {
          return ScrollableListView(
            key: ValueKey('__project_${project.id}_${project.updatedAt}__'),
            children: <Widget>[
              FormCard(
                isLast: true,
                children: <Widget>[
                  DecoratedFormField(
                    controller: _nameController,
                    validator: (String val) => val.trim().isEmpty
                        ? localization.pleaseEnterAName
                        : null,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    label: localization.projectName,
                    onSavePressed: _onSavePressed,
                  ),
                  project.isNew
                      ? EntityDropdown(
                          entityType: EntityType.client,
                          labelText: localization.client,
                          entityId: project.clientId,
                          entityList: memoizedDropdownClientList(
                              state.clientState.map,
                              state.clientState.list,
                              state.userState.map,
                              state.staticState),
                          validator: (String? val) => (val ?? '').trim().isEmpty
                              ? localization.pleaseSelectAClient
                              : null,
                          onSelected: (client) {
                            viewModel.onChanged(project.rebuild(
                                (b) => b..clientId = client?.id ?? ''));
                          },
                          onAddPressed: (completer) {
                            viewModel.onAddClientPressed(context, completer);
                          },
                        )
                      : DecoratedFormField(
                          controller: _numberController,
                          label: localization.projectNumber,
                          keyboardType: TextInputType.text,
                          onSavePressed: _onSavePressed,
                        ),
                  UserPicker(
                    userId: project.assignedUserId,
                    onChanged: (userId) => viewModel.onChanged(
                        project.rebuild((b) => b..assignedUserId = userId)),
                  ),
                  DatePicker(
                    labelText: localization.dueDate,
                    selectedDate: project.dueDate,
                    onSelected: (date, _) {
                      viewModel
                          .onChanged(project.rebuild((b) => b..dueDate = date));
                    },
                  ),
                  DecoratedFormField(
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: true),
                    controller: _hoursController,
                    label: localization.budgetedHours,
                    onSavePressed: _onSavePressed,
                  ),
                  DecoratedFormField(
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: true),
                    controller: _taskRateController,
                    label: localization.taskRate,
                    onSavePressed: _onSavePressed,
                  ),
                  CustomField(
                    controller: _custom1Controller,
                    field: CustomFieldType.project1,
                    value: project.customValue1,
                    onSavePressed: _onSavePressed,
                  ),
                  CustomField(
                    controller: _custom2Controller,
                    field: CustomFieldType.project2,
                    value: project.customValue2,
                    onSavePressed: _onSavePressed,
                  ),
                  CustomField(
                    controller: _custom3Controller,
                    field: CustomFieldType.project3,
                    value: project.customValue3,
                    onSavePressed: _onSavePressed,
                  ),
                  CustomField(
                    controller: _custom4Controller,
                    field: CustomFieldType.project4,
                    value: project.customValue4,
                    onSavePressed: _onSavePressed,
                  ),
                  DecoratedFormField(
                    maxLines: 4,
                    controller: _publicNotesController,
                    keyboardType: TextInputType.multiline,
                    label: localization.publicNotes,
                  ),
                  DecoratedFormField(
                    maxLines: 4,
                    controller: _privateNotesController,
                    keyboardType: TextInputType.multiline,
                    label: localization.privateNotes,
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
