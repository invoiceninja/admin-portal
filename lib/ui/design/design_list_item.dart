// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/design_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DesignListItem extends StatelessWidget {
  const DesignListItem({
    required this.design,
    required this.filter,
    this.onTap,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;
  final DesignEntity design;
  final String? filter;
  final Function(bool?)? onCheckboxChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final designUIState = uiState.designUIState;
    final listUIState = designUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;

    final filterMatch = filter != null && filter!.isNotEmpty
        ? design.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch;

    return DismissibleEntity(
      userCompany: state.userCompany,
      entity: design,
      isSelected: false,
      child: ListTile(
        onTap: () => onTap != null ? onTap!() : selectEntity(entity: design),
        onLongPress: () => onLongPress != null
            ? onLongPress!()
            : selectEntity(entity: design, longPress: true),
        leading: showCheckbox
            ? IgnorePointer(
                ignoring: listUIState.isInMultiselect(),
                child: Checkbox(
                  value: isChecked,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (value) => onCheckboxChanged!(value),
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
                  design.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              if (design.isTemplate)
                Text(AppLocalization.of(context)!.template,
                    style: Theme.of(context).textTheme.bodySmall),
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
            EntityStateLabel(design),
          ],
        ),
      ),
    );
  }
}
