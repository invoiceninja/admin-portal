import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ScheduleListItem extends StatelessWidget {
  const ScheduleListItem({
    @required this.user,
    @required this.schedule,
    @required this.filter,
    this.onTap,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity user;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final ScheduleEntity schedule;
  final String filter;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final scheduleUIState = uiState.scheduleUIState;
    final listUIState = scheduleUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;
    final localization = AppLocalization.of(context);

    final filterMatch = filter != null && filter.isNotEmpty
        ? schedule.matchesFilterValue(filter)
        : localization.lookup(schedule.template) +
            ' • ' +
            localization.lookup(kFrequencies[schedule.frequencyId]);
    final subtitle = filterMatch;

    return DismissibleEntity(
      userCompany: state.userCompany,
      entity: schedule,
      isSelected: schedule.id ==
          (uiState.isEditing
              ? scheduleUIState.editing.id
              : scheduleUIState.selectedId),
      child: ListTile(
        onTap: () => onTap != null ? onTap() : selectEntity(entity: schedule),
        onLongPress: () => onLongPress != null
            ? onLongPress()
            : selectEntity(entity: schedule, longPress: true),
        leading: showCheckbox
            ? IgnorePointer(
                ignoring: listUIState.isInMultiselect(),
                child: Checkbox(
                  value: isChecked,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (value) => onCheckboxChanged(value),
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
                  schedule.name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Text(formatNumber(schedule.listDisplayAmount, context),
                  style: Theme.of(context).textTheme.subtitle1),
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
            EntityStateLabel(schedule),
          ],
        ),
      ),
    );
  }
}
