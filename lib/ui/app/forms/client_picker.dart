// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientPicker extends StatelessWidget {
  const ClientPicker({
    Key? key,
    required this.clientId,
    required this.clientState,
    required this.onSelected,
    this.onAddPressed,
    this.autofocus,
    this.excludeIds = const [],
    this.isRequired = true,
    this.showNotes = false,
  }) : super(key: key);

  final String? clientId;
  final ClientState clientState;
  final Function(SelectableEntity?) onSelected;
  final Function(Completer<SelectableEntity> completer)? onAddPressed;
  final bool? autofocus;
  final List<String> excludeIds;
  final bool isRequired;
  final bool showNotes;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final client = state.clientState.get(clientId ?? '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EntityDropdown(
          entityType: EntityType.client,
          labelText: localization.client,
          entityId: clientId,
          autofocus: autofocus,
          entityList: memoizedDropdownClientList(clientState.map,
              clientState.list, state.userState.map, state.staticState),
          entityMap: clientState.map,
          validator: (String? val) => isRequired && (val ?? '').trim().isEmpty
              ? AppLocalization.of(context)!.pleaseSelectAClient
              : null,
          onSelected: onSelected,
          onAddPressed: onAddPressed,
          excludeIds: excludeIds,
        ),
        if (showNotes) ...[
          SizedBox(height: 4),
          if (client.publicNotes.isNotEmpty)
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: IconText(
                  text: client.privateNotes,
                  icon: Icons.lock,
                  iconSize: 16,
                  maxLines: 3,
                )),
          if (client.privateNotes.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(
                  top: client.publicNotes.isEmpty ? 8 : 0, bottom: 8),
              child: IconText(
                text: client.publicNotes,
                icon: Icons.note,
                iconSize: 16,
                maxLines: 3,
              ),
            ),
        ]
      ],
    );
  }
}
