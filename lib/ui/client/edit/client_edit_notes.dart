import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

class ClientEditNotes extends StatefulWidget {
  const ClientEditNotes({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientEditVM viewModel;

  @override
  ClientEditNotesState createState() => new ClientEditNotesState();
}

class ClientEditNotesState extends State<ClientEditNotes> {

  final _publicNotesController = TextEditingController();
  final _privateNotesController = TextEditingController();

  final List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    final List<TextEditingController> _controllers = [
      _publicNotesController,
      _privateNotesController,
    ];

    _controllers.forEach((dynamic controller) => controller.removeListener(_onChanged));

    final client = widget.viewModel.client;
    _publicNotesController.text = client.publicNotes;
    _privateNotesController.text = client.privateNotes;

    _controllers.forEach((dynamic controller) => controller.addListener(_onChanged));

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
    final client = viewModel.client.rebuild((b) => b
      ..publicNotes = _publicNotesController.text
      ..privateNotes = _privateNotesController.text
    );
    if (client != viewModel.client) {
      viewModel.onChanged(client);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        FormCard(
          children: <Widget>[
            TextFormField(
              maxLines: 6,
              controller: _publicNotesController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: localization.publicNotes,
              ),
            ),
            TextFormField(
              maxLines: 6,
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
