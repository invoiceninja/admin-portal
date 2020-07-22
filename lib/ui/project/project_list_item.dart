import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ProjectListItem extends StatelessWidget {
  const ProjectListItem({
    @required this.userCompany,
    @required this.project,
    @required this.filter,
    @required this.client,
    this.onTap,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserCompanyEntity userCompany;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  final ProjectEntity project;
  final ClientEntity client;
  final String filter;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final uiState = store.state.uiState;
    final projectUIState = uiState.projectUIState;
    final listUIState = projectUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;

    final filterMatch = filter != null && filter.isNotEmpty
        ? project.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch ?? client.displayName;

    return DismissibleEntity(
      isSelected: isDesktop(context) && project.id ==
          (uiState.isEditing
              ? projectUIState.editing.id
              : projectUIState.selectedId),
      userCompany: userCompany,
      entity: project,
      child: ListTile(
        onTap: () => onTap != null
            ? onTap()
            : selectEntity(entity: project, context: context),
        onLongPress: () => onLongPress != null
            ? onLongPress()
            : selectEntity(entity: project, context: context, longPress: true),
        leading: showCheckbox
            ? IgnorePointer(
                ignoring: listUIState.isInMultiselect(),
                child: Checkbox(
                  value: isChecked,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (value) => onCheckboxChanged(value),
                  activeColor: Theme.of(context).accentColor,
                ),
              )
            : null,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  project.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Text(formatNumber(project.listDisplayAmount, context),
                  style: Theme.of(context).textTheme.headline6),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            subtitle != null && subtitle.isNotEmpty
                ? Text(
                    subtitle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                : Container(),
            EntityStateLabel(project),
          ],
        ),
      ),
    );
  }
}
