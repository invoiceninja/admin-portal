import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';

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

  List<TextEditingController> _controllers;
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
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final client = viewModel.client;

    return ScrollableListView(
      children: <Widget>[
        FormCard(
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
            AppDropdownButton(
              value: client.sizeId,
              labelText: localization.size,
              items: memoizedSizeList(state.staticState.sizeMap)
                  .map((sizeId) => DropdownMenuItem(
                        child: Text(state.staticState.sizeMap[sizeId].name),
                        value: sizeId,
                      ))
                  .toList(),
              onChanged: (dynamic sizeId) => viewModel.onChanged(
                client.rebuild((b) => b..sizeId = sizeId),
              ),
              showBlank: true,
            ),
            EntityDropdown(
              key: ValueKey('__industry_${client.industryId}__'),
              entityType: EntityType.industry,
              entityList:
                  memoizedIndustryList(viewModel.staticState.industryMap),
              labelText: localization.industry,
              entityId: client.industryId,
              onSelected: (SelectableEntity industry) => viewModel.onChanged(
                  client.rebuild((b) => b..industryId = industry?.id ?? '')),
            ),
          ],
        ),
      ],
    );
  }
}
