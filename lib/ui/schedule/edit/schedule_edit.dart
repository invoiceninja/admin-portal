import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
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

  // STARTER: controllers - do not remove comment
  final _nameController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      // STARTER: array - do not remove comment
      _nameController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final schedule = widget.viewModel.schedule;
    // STARTER: read value - do not remove comment
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
    final localization = AppLocalization.of(context);
    final schedule = viewModel.schedule;

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
          child: Builder(builder: (BuildContext context) {
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
                  ],
                ),
              ],
            );
          })),
    );
  }
}
