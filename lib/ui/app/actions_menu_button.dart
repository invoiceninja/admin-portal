import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ActionMenuButton extends StatelessWidget {
  const ActionMenuButton({
    @required this.entity,
    @required this.onSelected,
    this.isSaving = false,
    this.entityActions,
  });

  final BaseEntity entity;
  final List<EntityAction> entityActions;
  final Function(BuildContext, EntityAction) onSelected;
  final bool isSaving;

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuEntry<EntityAction>> actions = [];

    if (isSaving) {
      return IconButton(
        onPressed: null,
        icon: SizedBox(
          width: 26,
          height: 26,
          child: CircularProgressIndicator(),
        ),
      );
    }

    entityActions?.forEach((action) {
      if (action == null) {
        actions.add(PopupMenuDivider());
      } else {
        actions.add(PopupMenuItem<EntityAction>(
          value: action,
          child: Row(
            children: <Widget>[
              Icon(getEntityActionIcon(action)),
              SizedBox(width: 15.0),
              Text(AppLocalization.of(context).lookup(action.toString()) ?? ''),
            ],
          ),
        ));
      }
    });

    if (actions.isEmpty) {
      return Container();
    }

    return PopupMenuButton<EntityAction>(
      icon: Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => actions,
      onSelected: (EntityAction action) {
        onSelected(context, action);
      },
    );
  }
}

/// This class is used to differentiate List and View ActionMenuButtons
/// during tests
class ViewActionMenuButton extends StatelessWidget {
  const ViewActionMenuButton({
    @required this.entity,
    @required this.onSelected,
    this.isSaving = false,
    this.entityActions,
  });

  final BaseEntity entity;
  final List<EntityAction> entityActions;
  final Function(BuildContext, EntityAction) onSelected;
  final bool isSaving;

  @override
  Widget build(BuildContext context) {
    return ActionMenuButton(
        entity: entity,
        onSelected: onSelected,
        isSaving: isSaving,
        entityActions: entityActions
    );
  }
}
