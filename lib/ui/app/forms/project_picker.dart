// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProjectPicker extends StatelessWidget {
  const ProjectPicker({
    Key? key,
    this.projectId,
    this.clientId,
    this.onChanged,
    this.onAddPressed,
  }) : super(key: key);

  final String? projectId;
  final String? clientId;
  final Function(String)? onChanged;
  final Function(Completer<SelectableEntity> completer)? onAddPressed;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context)!;

    return EntityDropdown(
        entityType: EntityType.project,
        labelText: localization.project,
        onAddPressed: onAddPressed,
        entityId: projectId,
        entityList: memoizedDropdownProjectList(
            state.projectState.map,
            state.projectState.list,
            state.clientState.map,
            state.userState.map,
            clientId),
        onSelected: (entity) {
          onChanged!(entity?.id ?? '');
        },
        onCreateNew: (clientId ?? '').isNotEmpty
            ? (completer, name) {
                store.dispatch(SaveProjectRequest(
                    project: ProjectEntity().rebuild((b) => b
                      ..name = name
                      ..clientId = clientId),
                    completer: completer));
              }
            : null);
  }
}
