// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ProjectListItem extends StatelessWidget {
  const ProjectListItem({
    required this.user,
    required this.project,
    required this.filter,
    this.onTap,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity? user;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;
  final ProjectEntity project;
  final String? filter;
  final Function(bool?)? onCheckboxChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final projectUIState = uiState.projectUIState;
    final client = state.clientState.get(project.clientId);
    final filterMatch = filter != null && filter!.isNotEmpty
        ? (project.matchesFilterValue(filter) ??
            client.matchesFilterValue(filter))
        : null;
    final listUIState = projectUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;
    final textStyle = TextStyle(fontSize: 16);
    final subtitle = client.displayName;
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;

    return DismissibleEntity(
      isSelected: isDesktop(context) &&
          project.id ==
              (uiState.isEditing
                  ? projectUIState.editing!.id
                  : projectUIState.selectedId),
      userCompany: store.state.userCompany,
      entity: project,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return constraints.maxWidth > kTableListWidthCutoff
            ? InkWell(
                onTap: () =>
                    onTap != null ? onTap!() : selectEntity(entity: project),
                onLongPress: () => onLongPress != null
                    ? onLongPress!()
                    : selectEntity(entity: project, longPress: true),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 28,
                    top: 4,
                    bottom: 4,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: showCheckbox
                            ? Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: IgnorePointer(
                                  ignoring: listUIState.isInMultiselect(),
                                  child: Checkbox(
                                    value: isChecked,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onChanged: (value) =>
                                        onCheckboxChanged!(value),
                                    activeColor:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              )
                            : ActionMenuButton(
                                entityActions: project.getActions(
                                  userCompany: state.userCompany,
                                  client: client,
                                  includeEdit: true,
                                ),
                                isSaving: false,
                                entity: project,
                                onSelected: (context, action) =>
                                    handleEntityAction(project, action),
                              ),
                      ),
                      SizedBox(
                        width: kListNumberWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              project.number,
                              style: textStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (!project.isActive) EntityStateLabel(project)
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                project.name +
                                    (project.documents.isNotEmpty
                                        ? '  📎'
                                        : ''),
                                style: textStyle),
                            Text(subtitle,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: textColor!
                                          .withOpacity(kLighterOpacity),
                                    )),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        formatDuration(
                            Duration(
                                minutes: (project.budgetedHours * 60).toInt()),
                            showSeconds: false),
                        style: textStyle,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              )
            : ListTile(
                onTap: () =>
                    onTap != null ? onTap!() : selectEntity(entity: project),
                onLongPress: () => onLongPress != null
                    ? onLongPress!()
                    : selectEntity(entity: project, longPress: true),
                leading: showCheckbox
                    ? IgnorePointer(
                        ignoring: listUIState.isInMultiselect(),
                        child: Checkbox(
                          value: isChecked,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (value) => onCheckboxChanged!(value),
                          activeColor: Theme.of(context).colorScheme.secondary,
                        ),
                      )
                    : null,
                title: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          project.name +
                              (project.documents.isNotEmpty ? '  📎' : ''),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Text(
                          formatDuration(
                              Duration(
                                  minutes:
                                      (project.budgetedHours * 60).toInt()),
                              showSeconds: false),
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        filterMatch == null
                            ? project.number + ' • ' + client.displayName
                            : filterMatch,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis),
                    EntityStateLabel(project),
                  ],
                ),
              );
      }),
    );
  }
}
