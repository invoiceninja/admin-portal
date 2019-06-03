import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

class VendorEditNotes extends StatefulWidget {
  const VendorEditNotes({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final VendorEditVM viewModel;

  @override
  VendorEditNotesState createState() => new VendorEditNotesState();
}

class VendorEditNotesState extends State<VendorEditNotes> {
  final _publicNotesController = TextEditingController();
  final _privateNotesController = TextEditingController();

  final List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    final List<TextEditingController> _controllers = [
      _publicNotesController,
      _privateNotesController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final vendor = widget.viewModel.vendor;
    //_publicNotesController.text = vendor.publicNotes;
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
      //..publicNotes = _publicNotesController.text
      ..privateNotes = _privateNotesController.text);
    if (vendor != viewModel.vendor) {
      viewModel.onChanged(vendor);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        FormCard(
          children: <Widget>[
            TextFormField(
              maxLines: 4,
              controller: _publicNotesController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: localization.publicNotes,
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
    );
  }
}
