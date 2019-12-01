import 'dart:async';

import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientPicker extends StatelessWidget {
  const ClientPicker({
    @required this.clientId,
    @required this.clientState,
    @required this.onSelected,
    @required this.onAddPressed,
  });

  final String clientId;
  final ClientState clientState;
  final Function(SelectableEntity) onSelected;
  final Function(Completer<SelectableEntity> completer) onAddPressed;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return EntityDropdown(
      key: ValueKey('__client_${clientId}__'),
      entityType: EntityType.client,
      labelText: localization.client,
      entityId: clientId,
      entityList: memoizedDropdownClientList(clientState.map, clientState.list),
      validator: (String val) => val.trim().isEmpty
          ? AppLocalization.of(context).pleaseSelectAClient
          : null,
      onSelected: onSelected,
      onAddPressed: onAddPressed,
    );
  }
}
