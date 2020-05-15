import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/lists/selected_indicator.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class DismissibleEntity extends StatelessWidget {
  const DismissibleEntity({
    @required this.userCompany,
    @required this.entity,
    @required this.child,
    @required this.onEntityAction,
    @required this.isSelected,
  });

  final UserCompanyEntity userCompany;
  final BaseEntity entity;
  final Widget child;
  final bool isSelected;
  final Function(EntityAction entityAction) onEntityAction;

  @override
  Widget build(BuildContext context) {
    if (!userCompany.canEditEntity(entity)) {
      return child;
    }

    if (onEntityAction == null) {
      return child;
    }

    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final isMultiselect =
        store.state.getListState(entity.entityType).isInMultiselect();

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      key: Key('__${entity.entityKey}_${entity.entityState}__'),
      actions: <Widget>[
        IconSlideAction(
          caption: localization.select,
          color: Colors.teal,
          foregroundColor: Colors.white,
          icon: Icons.check_box,
          onTap: () => onEntityAction(EntityAction.toggleMultiselect),
        ),
        IconSlideAction(
          caption: localization.more,
          color: Colors.black45,
          foregroundColor: Colors.white,
          icon: Icons.more_vert,
          onTap: () => onEntityAction(EntityAction.more),
        ),
      ],
      secondaryActions: <Widget>[
        entity.isActive
            ? IconSlideAction(
                caption: localization.archive,
                color: Colors.orange,
                foregroundColor: Colors.white,
                icon: Icons.archive,
                onTap: () => onEntityAction(EntityAction.archive),
              )
            : IconSlideAction(
                caption: localization.restore,
                color: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.restore,
                onTap: () => onEntityAction(EntityAction.restore),
              ),
        entity.isDeleted ?? false
            ? IconSlideAction(
                caption: localization.restore,
                color: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.restore,
                onTap: () => onEntityAction(EntityAction.restore),
              )
            : IconSlideAction(
                caption: localization.delete,
                color: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                onTap: () => onEntityAction(EntityAction.delete),
              ),
      ],
      child: SelectedIndicator(
        isSelected: isSelected && !isMultiselect,
        child: child,
      ),
    );
  }
}
