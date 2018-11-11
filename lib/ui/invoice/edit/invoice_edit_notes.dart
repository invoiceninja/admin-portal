import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_notes_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceEditNotes extends StatefulWidget {
  const InvoiceEditNotes({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EntityEditNotesVM viewModel;

  @override
  InvoiceEditNotesState createState() => InvoiceEditNotesState();
}

class InvoiceEditNotesState extends State<InvoiceEditNotes> {
  final _publicNotesController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _publicNotesController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final invoice = widget.viewModel.invoice;
    _publicNotesController.text = invoice.publicNotes;

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
    final invoice = widget.viewModel.invoice
        .rebuild((b) => b..publicNotes = _publicNotesController.text.trim());
    if (invoice != widget.viewModel.invoice) {
      widget.viewModel.onChanged(invoice);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    //final viewModel = widget.viewModel;

    return ListView(
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
          ],
        ),
      ],
    );
  }
}
