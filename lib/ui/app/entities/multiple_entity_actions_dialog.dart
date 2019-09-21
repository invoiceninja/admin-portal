import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

Future<void> showMultipleEntitiesActionsDialog({
  @required List<BaseEntity> entities,
  @required UserEntity user,
  @required GlobalKey<ScaffoldState> scaffoldKey,
  @required
      Function(BuildContext, ClientEntity, EntityAction,
              {bool multiselect, bool isMultiselectLast})
          onEntityAction,
  ClientEntity client,
}) async {
  if (entities == null || entities.isEmpty) {
    return;
  }
  final mainContext = scaffoldKey.currentContext;
  await showDialog<String>(
      context: scaffoldKey.currentContext,
      builder: (BuildContext dialogContext) {
        final actions = <Widget>[];
        actions.addAll(entities[0] // Suppose they are all the same type
            .getActions(user: user, client: client, multiselect: true)
            .map((entityAction) {
          if (entityAction == null) {
            return Divider();
          } else {
            return EntityActionListTile(
              entities: entities,
              entityAction: entityAction,
              mainContext: mainContext,
              onEntityAction: onEntityAction,
            );
          }
        }).toList());

        return SimpleDialog(children: actions);
      });
}

class EntityActionListTile extends StatelessWidget {
  const EntityActionListTile(
      {this.entities,
      this.entityAction,
      this.onEntityAction,
      this.mainContext});

  final List<BaseEntity> entities;
  final EntityAction entityAction;
  final BuildContext mainContext;
  final Function(BuildContext, BaseEntity, EntityAction,
      {bool multiselect, bool isMultiselectLast}) onEntityAction;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return ListTile(
      leading: Icon(getEntityActionIcon(entityAction)),
      title: Text(localization.lookup(entityAction.toString())),
      onTap: () {
        Navigator.of(context).pop();
        for (int i = 0; i < entities.length; i++) {
          final BaseEntity entity = entities[i];
          onEntityAction(mainContext, entity, entityAction,
              multiselect: true, isMultiselectLast: i == entities.length - 1);
        }
      },
    );
  }
}
