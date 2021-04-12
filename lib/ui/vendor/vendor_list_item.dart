import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';

class VendorListItem extends StatelessWidget {
  const VendorListItem({
    @required this.user,
    @required this.vendor,
    @required this.filter,
    this.onTap,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity user;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final VendorEntity vendor;
  final String filter;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final vendorUIState = uiState.vendorUIState;
    final filterMatch = filter != null && filter.isNotEmpty
        ? vendor.matchesFilterValue(filter)
        : null;
    final listUIState = vendorUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;
    final textStyle = TextStyle(fontSize: 16);
    final textColor = Theme.of(context).textTheme.bodyText1.color;
    final documents = vendor.documents ?? <DocumentEntity>[];

    return DismissibleEntity(
      isSelected: isDesktop(context) &&
          vendor.id ==
              (uiState.isEditing
                  ? vendorUIState.editing.id
                  : vendorUIState.selectedId),
      userCompany: store.state.userCompany,
      entity: vendor,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return constraints.maxWidth > kTableListWidthCutoff
            ? InkWell(
                onTap: () => onTap != null
                    ? onTap()
                    : selectEntity(entity: vendor, context: context),
                onLongPress: () => onLongPress != null
                    ? onLongPress()
                    : selectEntity(
                        entity: vendor, context: context, longPress: true),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 28,
                    top: 4,
                    bottom: 4,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: showCheckbox
                            ? Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: IgnorePointer(
                                  ignoring: listUIState.isInMultiselect(),
                                  child: Checkbox(
                                    value: isChecked,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onChanged: (value) =>
                                        onCheckboxChanged(value),
                                    activeColor: Theme.of(context).accentColor,
                                  ),
                                ),
                              )
                            : ActionMenuButton(
                                entityActions: vendor.getActions(
                                    userCompany: state.userCompany),
                                isSaving: false,
                                entity: vendor,
                                onSelected: (context, action) =>
                                    handleEntityAction(context.getAppContext(),
                                        vendor, action),
                              ),
                      ),
                      SizedBox(
                        width: kListNumberWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              vendor.number,
                              style: textStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (!vendor.isActive) EntityStateLabel(vendor)
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                vendor.name +
                                    (documents.isNotEmpty ? '  📎' : ''),
                                style: textStyle),
                            if (filterMatch != null)
                              Text(filterMatch,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                        color: textColor
                                            .withOpacity(kLighterOpacity),
                                      )),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      /*
                    Text(
                      formatNumber(vendor.balance, context,
                          vendorId: vendor.id),
                      style: textStyle,
                      textAlign: TextAlign.end,
                    ),
                     */
                    ],
                  ),
                ),
              )
            : ListTile(
                onTap: () => onTap != null
                    ? onTap()
                    : selectEntity(entity: vendor, context: context),
                onLongPress: () => onLongPress != null
                    ? onLongPress()
                    : selectEntity(
                        entity: vendor, context: context, longPress: true),
                leading: showCheckbox
                    ? IgnorePointer(
                        ignoring: listUIState.isInMultiselect(),
                        child: Checkbox(
                          value: isChecked,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
                          vendor.name + (documents.isNotEmpty ? '  📎' : ''),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      /*
                    Text(
                        formatNumber(vendor.balance, context,
                            vendorId: vendor.id),
                        style: Theme.of(context).textTheme.headline6),
                     */
                    ],
                  ),
                ),
                subtitle: (filterMatch == null && vendor.isActive)
                    ? null
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          filterMatch != null
                              ? Text(filterMatch,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                        color: textColor
                                            .withOpacity(kLighterOpacity),
                                      ))
                              : SizedBox(),
                          EntityStateLabel(vendor),
                        ],
                      ),
              );
      }),
    );
  }
}
