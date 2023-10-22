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
  }) : super(key: key);

  final String? clientId;
  final ClientState clientState;
  final Function(SelectableEntity?) onSelected;
  final Function(Completer<SelectableEntity> completer)? onAddPressed;
  final bool? autofocus;
  final List<String> excludeIds;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    return EntityDropdown(
      entityType: EntityType.client,
      labelText: localization.client,
      entityId: clientId,
      autofocus: autofocus,
      entityList: memoizedDropdownClientList(clientState.map, clientState.list,
          state.userState.map, state.staticState),
      entityMap: clientState.map,
      validator: (String? val) => isRequired && (val ?? '').trim().isEmpty
          ? AppLocalization.of(context)!.pleaseSelectAClient
          : null,
      onSelected: onSelected,
      onAddPressed: onAddPressed,
      excludeIds: excludeIds,
    );
  }
}
