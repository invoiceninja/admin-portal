import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';

class VendorListItem extends StatelessWidget {
  const VendorListItem({
    @required this.userCompany,
    @required this.onEntityAction,
    @required this.onTap,
    @required this.onLongPress,
    @required this.vendor,
    @required this.filter,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserCompanyEntity userCompany;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  final VendorEntity vendor;
  final String filter;

  static final vendorItemKey = (int id) => Key('__vendor_item_${id}__');

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final uiState = store.state.uiState;
    final vendorUIState = uiState.vendorUIState;
    final listUIState = vendorUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;

    final filterMatch = filter != null && filter.isNotEmpty
        ? vendor.matchesFilterValue(filter)
        : null;

    return DismissibleEntity(
      isSelected: vendor.id ==
          (uiState.isEditing
              ? vendorUIState.editing.id
              : vendorUIState.selectedId),
      userCompany: userCompany,
      entity: vendor,
      onEntityAction: onEntityAction,
      child: ListTile(
        onTap: isInMultiselect
            ? () => onEntityAction(EntityAction.toggleMultiselect)
            : onTap,
        onLongPress: onLongPress,
        leading: showCheckbox
            ? IgnorePointer(
                ignoring: listUIState.isInMultiselect(),
                child: Checkbox(
                  value: isChecked,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (value) => onCheckboxChanged(value),
                  activeColor: Theme.of(context).accentColor,
                ),
              )
            : null,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  vendor.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Text(formatNumber(vendor.listDisplayAmount, context),
                  style: Theme.of(context).textTheme.headline6),
            ],
          ),
        ),
        subtitle: (filterMatch == null && vendor.isActive)
            ? null
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (filterMatch != null)
                    Text(
                      filterMatch,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  EntityStateLabel(vendor),
                ],
              ),
      ),
    );
  }
}
