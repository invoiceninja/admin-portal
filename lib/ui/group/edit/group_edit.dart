import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/group/edit/group_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

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
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_groupEdit');

  final _nameController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();
  bool autoValidate = false;

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
    final group = widget.viewModel.group
        .rebuild((b) => b..name = _nameController.text.trim());
    if (group != widget.viewModel.group) {
      _debouncer.run(() {
        widget.viewModel.onChanged(group);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final group = viewModel.group;

    return EditScaffold(
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      title: group.isNew ? localization.newGroup : localization.editGroup,
      isAdvancedSettings: true,
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

        setState(() {
          autoValidate = !isValid ?? false;
        });

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
                      autofocus: true,
                      label: localization.name,
                      controller: _nameController,
                      onSavePressed: viewModel.onSavePressed,
                      validator: (val) => val.isEmpty || val.trim().isEmpty
                          ? localization.pleaseEnterAValue
                          : null,
                      autovalidate: autoValidate,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
