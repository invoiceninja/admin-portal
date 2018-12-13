import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/date_picker.dart';
import 'package:invoiceninja_flutter/ui/project/edit/project_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/refresh_icon_button.dart';
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

  final _nameController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _hoursController = TextEditingController();
  final _taskRateController = TextEditingController();
  final _privateNotesController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _nameController,
      _dueDateController,
      _hoursController,
      _taskRateController,
      _privateNotesController,
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
      ..privateNotes = _privateNotesController.text.trim());
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
              return RefreshIconButton(
                icon: Icons.cloud_upload,
                tooltip: localization.save,
                isVisible: !project.isDeleted,
                isDirty: project.isNew || project != viewModel.origProject,
                isSaving: viewModel.isSaving,
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
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
          child: ListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  EntityDropdown(
                    entityType: EntityType.client,
                    labelText: localization.client,
                    initialValue: (state.clientState.map[project.clientId] ??
                            ClientEntity())
                        .displayName,
                    entityMap: state.clientState.map,
                    entityList: memoizedDropdownClientList(
                        state.clientState.map, state.clientState.list),
                    validator: (String val) => val.trim().isEmpty
                        ? AppLocalization.of(context).pleaseSelectAClient
                        : null,
                    onSelected: (clientId) {
                      viewModel.onChanged(
                          project.rebuild((b) => b..clientId = clientId));
                    },
                    onAddPressed: (completer) {
                      viewModel.onAddClientPressed(context, completer);
                    },
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: _nameController,
                    validator: (String val) => val.trim().isEmpty
                        ? AppLocalization.of(context).pleaseEnterAName
                        : null,
                    decoration: InputDecoration(
                      labelText: localization.name,
                    ),
                  ),
                  DatePicker(
                    labelText: localization.dueDate,
                    selectedDate: project.dueDate,
                    onSelected: (date) {
                      viewModel
                          .onChanged(project.rebuild((b) => b..dueDate = date));
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _hoursController,
                    decoration: InputDecoration(
                      labelText: localization.budgetedHours,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
