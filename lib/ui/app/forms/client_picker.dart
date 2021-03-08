import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
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
    this.autofocus,
  });

  final String clientId;
  final ClientState clientState;
  final Function(SelectableEntity) onSelected;
  final Function(Completer<SelectableEntity> completer) onAddPressed;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    return EntityDropdown(
      key: ValueKey('__client_${clientId}__'),
      entityType: EntityType.client,
      labelText: localization.client,
      entityId: clientId,
      autofocus: autofocus,
      entityList: memoizedDropdownClientList(clientState.map, clientState.list,
          state.userState.map, state.staticState),
      entityMap: clientState.map,
      validator: (String val) => val.trim().isEmpty
          ? AppLocalization.of(context).pleaseSelectAClient
          : null,
      onSelected: onSelected,
      onAddPressed: onAddPressed,
    );
  }
}
