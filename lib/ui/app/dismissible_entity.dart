import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/lists/selected_indicator.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class DismissibleEntity extends StatelessWidget {
  const DismissibleEntity({
    @required this.userCompany,
    @required this.entity,
    @required this.child,
    @required this.isSelected,
    this.showCheckbox = true,
    this.isDismissible = true,
  });

  final UserCompanyEntity userCompany;
  final BaseEntity entity;
  final Widget child;
  final bool isSelected;
  final bool showCheckbox;
  final bool isDismissible;

  @override
  Widget build(BuildContext context) {
    if (!userCompany.canEditEntity(entity)) {
      return child;
    }

    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final isMultiselect =
        store.state.getListState(entity.entityType).isInMultiselect();

    final widget = SelectedIndicator(
      isSelected: isSelected &&
          showCheckbox &&
          isDismissible &&
          !isMultiselect &&
          !entity.entityType.isSetting,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 60,
        ),
        child: child,
      ),
    );

    if (!isDismissible) {
      return widget;
    }

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      key: Key('__${entity.entityKey}_${entity.entityState}__'),
      actions: <Widget>[
        if (showCheckbox)
          IconSlideAction(
            caption: localization.select,
            color: Colors.teal,
            foregroundColor: Colors.white,
            icon: Icons.check_box,
            onTap: () => handleEntityAction(context.getAppContext(), entity,
                EntityAction.toggleMultiselect),
          ),
        IconSlideAction(
          caption: localization.more,
          color: Colors.black45,
          foregroundColor: Colors.white,
          icon: Icons.more_vert,
          onTap: () => handleEntityAction(
              context.getAppContext(), entity, EntityAction.more),
        ),
      ],
      secondaryActions: <Widget>[
        entity.isActive
            ? IconSlideAction(
                caption: localization.archive,
                color: Colors.orange,
                foregroundColor: Colors.white,
                icon: Icons.archive,
                onTap: () => handleEntityAction(
                    context.getAppContext(), entity, EntityAction.archive),
              )
            : IconSlideAction(
                caption: localization.restore,
                color: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.restore,
                onTap: () => handleEntityAction(
                    context.getAppContext(), entity, EntityAction.restore),
              ),
        entity.isDeleted
            ? IconSlideAction(
                caption: localization.restore,
                color: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.restore,
                onTap: () => handleEntityAction(
                    context.getAppContext(), entity, EntityAction.restore),
              )
            : IconSlideAction(
                caption: localization.delete,
                color: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                onTap: () => handleEntityAction(
                    context.getAppContext(), entity, EntityAction.delete),
              ),
      ],
      child: widget,
    );
  }
}
