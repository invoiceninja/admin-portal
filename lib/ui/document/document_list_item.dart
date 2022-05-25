// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class DocumentListItem extends StatelessWidget {
  const DocumentListItem({
    @required this.userCompany,
    //@required this.onCheckboxChanged,
    @required this.document,
    @required this.filter,
    this.onTap,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserCompanyEntity userCompany;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  //final ValueChanged<bool> onCheckboxChanged;
  final DocumentEntity document;
  final String filter;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final uiState = store.state.uiState;
    final documentUIState = uiState.documentUIState;
    final filterMatch = filter != null && filter.isNotEmpty
        ? document.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch;
    final listUIState = documentUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;

    return DismissibleEntity(
      isSelected: document.id ==
          (uiState.isEditing
              ? documentUIState.editing.id
              : documentUIState.selectedId),
      userCompany: userCompany,
      entity: document,
      child: ListTile(
        onTap: () => onTap != null
            ? onTap()
            : selectEntity(entity: document, context: context),
        onLongPress: () => onLongPress != null
            ? onLongPress()
            : selectEntity(entity: document, context: context, longPress: true),
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
                  document.name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Text(formatNumber(document.listDisplayAmount, context),
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
            EntityStateLabel(document),
          ],
        ),
      ),
    );
  }
}
