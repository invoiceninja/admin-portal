import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

Future<void> showEntityActionsDialog({
  @required BuildContext context,
  @required List<BaseEntity> entities,
  @required UserCompanyEntity userCompany,
  @required
      Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction,
  ClientEntity client,
}) async {
  if (entities == null) {
    return;
  }
  final mainContext = context;
  showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        final actions = <Widget>[];
        actions.addAll(entities[0]
            .getActions(
                userCompany: userCompany, includeEdit: true, client: client)
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
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return ListTile(
      leading: Icon(getEntityActionIcon(entityAction)),
      title: Text(localization.lookup(entityAction.toString())),
      onTap: () {
        Navigator.of(context).pop();
        onEntityAction(context, entities, entityAction);
      },
    );
  }
}
