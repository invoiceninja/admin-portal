import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/group/edit/group_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_icon_button.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class GroupEdit extends StatefulWidget {
  const GroupEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final GroupEditVM viewModel;

  @override
  _GroupEditState createState() => _GroupEditState();
}

class _GroupEditState extends State<GroupEdit> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _debouncer = Debouncer();

  final _nameController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _nameController,
      _custom1Controller,
      _custom2Controller,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final group = widget.viewModel.group;
    _nameController.text = group.name;
    _custom1Controller.text = group.customValue1;
    _custom2Controller.text = group.customValue2;

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
    final group = widget.viewModel.group.rebuild((b) => b
      ..name = _nameController.text.trim()
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim());
    if (group != widget.viewModel.group) {
      widget.viewModel.onChanged(group);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final company = viewModel.company;
    final group = viewModel.group;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: isMobile(context),
          title: Text(viewModel.group.isNew
              ? localization.newGroup
              : localization.editGroup),
          actions: <Widget>[
            if (!isMobile(context))
              FlatButton(
                child: Text(
                  localization.cancel,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => viewModel.onCancelPressed(context),
              ),
            ActionIconButton(
              icon: Icons.cloud_upload,
              tooltip: localization.save,
              isVisible: !(group.isDeleted ?? false), // TODO remove this
              isDirty: group.isNew || group != viewModel.origGroup,
              isSaving: viewModel.isSaving,
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }
                viewModel.onSavePressed(context);
              },
            ),
          ],
        ),
        body: Form(
            key: _formKey,
            child: Builder(builder: (BuildContext context) {
              return ListView(
                children: <Widget>[
                  FormCard(
                    children: <Widget>[
                      DecoratedFormField(
                        label: localization.name,
                        controller: _nameController,
                      ),
                      CustomField(
                        controller: _custom1Controller,
                        labelText:
                            company.getCustomFieldLabel(CustomFieldType.group1),
                        options: company
                            .getCustomFieldValues(CustomFieldType.group1),
                      ),
                      CustomField(
                        controller: _custom2Controller,
                        labelText:
                            company.getCustomFieldLabel(CustomFieldType.group2),
                        options: company
                            .getCustomFieldValues(CustomFieldType.group2),
                      ),
                    ],
                  ),
                ],
              );
            })),
      ),
    );
  }
}
