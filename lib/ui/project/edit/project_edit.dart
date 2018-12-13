import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/project/edit/project_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/refresh_icon_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProjectEdit extends StatefulWidget {
  final ProjectEditVM viewModel;

  const ProjectEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _ProjectEditState createState() => _ProjectEditState();
}

class _ProjectEditState extends State<ProjectEdit> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // STARTER: controllers - do not remove comment

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {

    _controllers = [
      // STARTER: array - do not remove comment
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final project = widget.viewModel.project;
    // STARTER: read value - do not remove comment

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
      // STARTER: set value - do not remove comment
    );
    if (project != widget.viewModel.project) {
      widget.viewModel.onChanged(project);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
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
              RefreshIconButton(
                icon: Icons.cloud_upload,
                tooltip: localization.save,
                isVisible: project.isDeleted,
                isDirty: project.isNew || project != viewModel.origProject,
                isSaving: viewModel.isSaving,
                onPressed: () {
                  if (! _formKey.currentState.validate()) {
                    return;
                  }
                  viewModel.onSavePressed(context);
                },
              );
            }),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  // STARTER: widgets - do not remove comment
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
