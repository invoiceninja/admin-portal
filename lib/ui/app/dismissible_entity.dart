// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/lists/selected_indicator.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class DismissibleEntity extends StatelessWidget {
  const DismissibleEntity({
    required this.userCompany,
    required this.entity,
    required this.child,
    required this.isSelected,
    this.showMultiselect = true,
    this.isDismissible = true,
  });

  final UserCompanyEntity userCompany;
  final BaseEntity entity;
  final Widget child;
  final bool isSelected;
  final bool showMultiselect;
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
      isSelected: isDesktop(context) &&
          isSelected &&
          showMultiselect &&
          isDismissible &&
          !isMultiselect &&
          !entity.entityType!.isSetting,
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
      key: Key('__${entity.entityKey}_${entity.entityState}__'),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          if (showMultiselect)
            SlidableAction(
              onPressed: (context) =>
                  handleEntityAction(entity, EntityAction.toggleMultiselect),
              icon: Icons.check_box,
              label: localization!.select,
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
            ),
          SlidableAction(
            label: localization!.more,
            backgroundColor: Colors.black45,
            foregroundColor: Colors.white,
            icon: Icons.more_vert,
            onPressed: (context) =>
                handleEntityAction(entity, EntityAction.more),
          ),
        ],
      ),
      endActionPane: entity.isDeletable
          ? ActionPane(
              motion: const DrawerMotion(),
              children: [
                if (entity.isActive)
                  SlidableAction(
                    label: localization.archive,
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    icon: Icons.archive,
                    onPressed: (context) =>
                        handleEntityAction(entity, EntityAction.archive),
                  )
                else if (entity.isRestorable)
                  SlidableAction(
                    label: localization.restore,
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    icon: Icons.restore,
                    onPressed: (context) =>
                        handleEntityAction(entity, EntityAction.restore),
                  ),
                if (!entity.isDeleted!)
                  SlidableAction(
                    label: localization.delete,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    onPressed: (context) =>
                        handleEntityAction(entity, EntityAction.delete),
                  ),
              ],
            )
          : null,
      child: widget,
    );
  }
}
