import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/project/edit/project_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_icon_button.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProjectEdit extends StatefulWidget {
  const ProjectEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ProjectEditVM viewModel;

  @override
  _ProjectEditState createState() => _ProjectEditState();
}

class _ProjectEditState extends State<ProjectEdit> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool autoValidate = false;

  final _nameController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _hoursController = TextEditingController();
  final _taskRateController = TextEditingController();
  final _privateNotesController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _nameController,
      _dueDateController,
      _hoursController,
      _taskRateController,
      _privateNotesController,
      _custom1Controller,
      _custom2Controller,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final project = widget.viewModel.project;
    _nameController.text = project.name;
    _dueDateController.text = project.dueDate;
    _hoursController.text = formatNumber(project.budgetedHours, context,
        formatNumberType: FormatNumberType.input);
    _taskRateController.text = formatNumber(project.taskRate, context,
        formatNumberType: FormatNumberType.input);
    _privateNotesController.text = project.privateNotes;
    _custom1Controller.text = project.customValue1;
    _custom2Controller.text = project.customValue2;

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
      ..name = _nameController.text.trim()
      ..budgetedHours = parseDouble(_hoursController.text)
      ..taskRate = parseDouble(_taskRateController.text)
      ..privateNotes = _privateNotesController.text.trim()
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim());
    if (project != widget.viewModel.project) {
      widget.viewModel.onChanged(project);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final state = viewModel.state;
    final project = viewModel.project;
    final company = viewModel.company;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel.project.isNew
              ? localization.newProject
              : localization.editProject),
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
              return ActionIconButton(
                icon: Icons.cloud_upload,
                tooltip: localization.save,
                isVisible: !project.isDeleted,
                isDirty: project.isNew || project != viewModel.origProject,
                isSaving: viewModel.isSaving,
                onPressed: () {
                  final bool isValid = _formKey.currentState.validate();

                  setState(() {
                    autoValidate = !isValid;
                  });

                  if (!isValid) {
                    return;
                  }

                  viewModel.onSavePressed(context);
                },
              );
            })
          ],
        ),
        body: Form(
          key: _formKey,
          child: Builder(builder: (BuildContext context) {
            return ListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    project.isNew
                        ? EntityDropdown(
                            entityType: EntityType.client,
                            labelText: localization.client,
                            initialValue:
                                (state.clientState.map[project.clientId] ??
                                        ClientEntity())
                                    .displayName,
                            entityMap: state.clientState.map,
                            entityList: memoizedDropdownClientList(
                                state.clientState.map, state.clientState.list),
                            validator: (String val) => val.trim().isEmpty
                                ? localization.pleaseSelectAClient
                                : null,
                            autoValidate: autoValidate,
                            onSelected: (client) {
                              viewModel.onChanged(project
                                  .rebuild((b) => b..clientId = client.id));
                            },
                            onAddPressed: (completer) {
                              viewModel.onAddClientPressed(context, completer);
                            },
                          )
                        : SizedBox(),
                    TextFormField(
                      autocorrect: false,
                      controller: _nameController,
                      validator: (String val) => val.trim().isEmpty
                          ? localization.pleaseEnterAName
                          : null,
                      autovalidate: autoValidate,
                      decoration: InputDecoration(
                        labelText: localization.name,
                      ),
                    ),
                    DatePicker(
                      labelText: localization.dueDate,
                      selectedDate: project.dueDate,
                      onSelected: (date) {
                        viewModel.onChanged(
                            project.rebuild((b) => b..dueDate = date));
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _hoursController,
                      decoration: InputDecoration(
                        labelText: localization.budgetedHours,
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _taskRateController,
                      decoration: InputDecoration(
                        labelText: localization.taskRate,
                      ),
                    ),
                    TextFormField(
                      maxLines: 4,
                      controller: _privateNotesController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: localization.privateNotes,
                      ),
                    ),
                    CustomField(
                      controller: _custom1Controller,
                      labelText:
                          company.getCustomFieldLabel(CustomFieldType.project1),
                      options: company
                          .getCustomFieldValues(CustomFieldType.project1),
                    ),
                    CustomField(
                      controller: _custom2Controller,
                      labelText:
                          company.getCustomFieldLabel(CustomFieldType.project2),
                      options: company
                          .getCustomFieldValues(CustomFieldType.project2),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
