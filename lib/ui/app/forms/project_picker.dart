import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/forms/dynamic_selector.dart';

class ProjectPicker extends StatelessWidget {
  const ProjectPicker({
    Key key,
    this.projectId,
    this.clientId,
    this.onChanged,
    this.onAddPressed,
  }) : super(key: key);

  final String projectId;
  final String clientId;
  final Function(String) onChanged;
  final Function(Completer<SelectableEntity> completer) onAddPressed;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;

    return DynamicSelector(
      onChanged: onChanged,
      onAddPressed: onAddPressed,
      entityType: EntityType.project,
      entityId: projectId,
      entityIds: memoizedDropdownProjectList(
          state.projectState.map,
          state.projectState.list,
          state.clientState.map,
          state.userState.map,
          clientId),
    );
  }
}
