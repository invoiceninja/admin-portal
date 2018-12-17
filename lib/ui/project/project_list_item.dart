import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';

class ProjectListItem extends StatelessWidget {

  const ProjectListItem({
    @required this.user,
    @required this.onEntityAction,
    @required this.onTap,
    @required this.onLongPress,
    //@required this.onCheckboxChanged,
    @required this.project,
    @required this.filter,
    @required this.client,
  });

  final UserEntity user;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  //final ValueChanged<bool> onCheckboxChanged;
  final ProjectEntity project;
  final ClientEntity client;
  final String filter;

  static final projectItemKey = (int id) => Key('__project_item_${id}__');

  @override
  Widget build(BuildContext context) {
    final filterMatch = filter != null && filter.isNotEmpty
        ? project.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch ?? client.displayName;

    return DismissibleEntity(
      user: user,
      entity: project,
      onEntityAction: onEntityAction,
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        /*
        leading: Checkbox(
          //key: NinjaKeys.projectItemCheckbox(project.id),
          value: true,
          //onChanged: onCheckboxChanged,
          onChanged: (value) {
            return true;
          },
        ),
        */
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  project.name,
                  //key: NinjaKeys.clientItemClientKey(client.id),
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Text(formatNumber(project.listDisplayAmount, context),
                  style: Theme.of(context).textTheme.title),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            subtitle != null && subtitle.isNotEmpty ?
            Text(
              subtitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ) : Container(),
            EntityStateLabel(project),
          ],
        ),
      ),
    );
  }
}
