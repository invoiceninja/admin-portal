// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ClientEditNotes extends StatefulWidget {
  const ClientEditNotes({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final ClientEditVM viewModel;

  @override
  ClientEditNotesState createState() => new ClientEditNotesState();
}

class ClientEditNotesState extends State<ClientEditNotes> {
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

    final client = widget.viewModel.client;
    _publicNotesController.text = client.publicNotes;
    _privateNotesController.text = client.privateNotes;

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
    final client = viewModel.client.rebuild((b) => b
      ..publicNotes = _publicNotesController.text
      ..privateNotes = _privateNotesController.text);
    if (client != viewModel.client) {
      _debouncer.run(() {
        viewModel.onChanged(client);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final isFullscreen = state.prefState.isEditorFullScreen(EntityType.client);

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
          maxLines: isMobile(context) || !isFullscreen ? 8 : 4,
          controller: _publicNotesController,
          keyboardType: TextInputType.multiline,
          label: localization.publicNotes,
        ),
        DecoratedFormField(
          maxLines: isMobile(context) || !isFullscreen ? 8 : 4,
          controller: _privateNotesController,
          keyboardType: TextInputType.multiline,
          label: localization.privateNotes,
        ),
      ],
    );
  }
}
