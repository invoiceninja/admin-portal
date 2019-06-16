import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

void showEntityActionsDialog(
    {@required BuildContext context,
    @required BaseEntity entity,
    @required UserEntity user,
    @required Function onEntityAction}) async {
  if (entity == null) {
    return;
  }
  showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        final actions = <Widget>[];
        actions.addAll(entity
            .getActions(user: user, includeEdit: true)
            .map((entityAction) {
          if (entityAction == null) {
            return Divider();
          } else {
            return EntityActionListTile(
              entity: entity,
              entityAction: entityAction,
              mainContext: context,
              onEntityAction: onEntityAction,
            );
          }
        }).toList());

        return SimpleDialog(children: actions);
      });
}

class EntityActionListTile extends StatelessWidget {
  const EntityActionListTile(
      {this.entity, this.entityAction, this.onEntityAction, this.mainContext});

  final BaseEntity entity;
  final EntityAction entityAction;
  final BuildContext mainContext;
  final Function(BuildContext, ClientEntity, EntityAction) onEntityAction;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return ListTile(
      leading: Icon(getEntityActionIcon(entityAction)),
      title: Text(localization.lookup(entityAction.toString())),
      onTap: () {
        Navigator.of(context).pop();
        onEntityAction(mainContext, entity, entityAction);
      },
    );
  }
}
