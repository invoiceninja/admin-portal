// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class VendorEditNotes extends StatefulWidget {
  const VendorEditNotes({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final VendorEditVM viewModel;

  @override
  VendorEditNotesState createState() => new VendorEditNotesState();
}

class VendorEditNotesState extends State<VendorEditNotes> {
  final _publicNotesController = TextEditingController();
  final _privateNotesController = TextEditingController();

  late List<TextEditingController> _controllers;
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    _controllers = [
      _publicNotesController,
      _privateNotesController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final vendor = widget.viewModel.vendor;
    _publicNotesController.text = vendor.publicNotes;
    _privateNotesController.text = vendor.privateNotes;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    final viewModel = widget.viewModel;
    final vendor = viewModel.vendor.rebuild((b) => b
      ..publicNotes = _publicNotesController.text
      ..privateNotes = _privateNotesController.text);
    if (vendor != viewModel.vendor) {
      _debouncer.run(() {
        viewModel.onChanged(vendor);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final isFullscreen = state.prefState.isEditorFullScreen(EntityType.vendor);

    return FormCard(
      isLast: true,
      padding: isFullscreen
          ? const EdgeInsets.only(
              left: kMobileDialogPadding,
              top: kMobileDialogPadding,
              right: kMobileDialogPadding / 2,
            )
          : null,
      children: <Widget>[
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
    );
  }
}
