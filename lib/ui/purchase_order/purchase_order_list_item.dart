// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/colors.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PurchaseOrderListItem extends StatelessWidget {
  const PurchaseOrderListItem({
    required this.user,
    required this.purchaseOrder,
    required this.vendor,
    required this.filter,
    this.onTap,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity? user;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;
  final InvoiceEntity purchaseOrder;
  final VendorEntity? vendor;
  final String? filter;
  final Function(bool?)? onCheckboxChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final uiState = state.uiState;
    final purchaseOrderUIState = uiState.purchaseOrderUIState;
    final listUIState = state.getUIState(purchaseOrder.entityType)!.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;
    final textStyle = TextStyle(fontSize: 16);
    final localization = AppLocalization.of(context);
    final filterMatch = filter != null && filter!.isNotEmpty
        ? (purchaseOrder.matchesFilterValue(filter) ??
            vendor!.matchesFilterValue(filter))
        : null;
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;

    String subtitle = '';
    if (purchaseOrder.date.isNotEmpty) {
      subtitle = formatDate(purchaseOrder.date, context);
    }

    return DismissibleEntity(
      isSelected: purchaseOrder.id ==
          (uiState.isEditing
              ? purchaseOrderUIState.editing!.id
              : purchaseOrderUIState.selectedId),
      userCompany: state.userCompany,
      entity: purchaseOrder,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return constraints.maxWidth > kTableListWidthCutoff
            ? InkWell(
                onTap: () => onTap != null
                    ? onTap!()
                    : selectEntity(entity: purchaseOrder),
                onLongPress: () => onLongPress != null
                    ? onLongPress!()
                    : selectEntity(entity: purchaseOrder, longPress: true),
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
                              ? IgnorePointer(
                                  ignoring: listUIState.isInMultiselect(),
                                  child: Checkbox(
                                    value: isChecked,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onChanged: (value) =>
                                        onCheckboxChanged!(value),
                                    activeColor:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                )
                              : ActionMenuButton(
                                  entityActions: purchaseOrder.getActions(
                                    userCompany: state.userCompany,
                                    includeEdit: true,
                                  ),
                                  isSaving: false,
                                  entity: purchaseOrder,
                                  onSelected: (context, action) =>
                                      handleEntityAction(purchaseOrder, action),
                                )),
                      SizedBox(
                        width: kListNumberWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              purchaseOrder.number.isEmpty
                                  ? localization!.pending
                                  : purchaseOrder.number,
                              style: textStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (!purchaseOrder.isActive)
                              EntityStateLabel(purchaseOrder)
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                vendor!.name +
                                    (purchaseOrder.documents.isNotEmpty
                                        ? '  📎'
                                        : ''),
                                style: textStyle),
                            Text(
                              filterMatch ?? subtitle,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color:
                                        textColor!.withOpacity(kLighterOpacity),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        formatNumber(
                          purchaseOrder.amount,
                          context,
                          vendorId: vendor!.id,
                        )!,
                        style: textStyle,
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(width: 25),
                      EntityStatusChip(entity: purchaseOrder),
                    ],
                  ),
                ),
              )
            : ListTile(
                onTap: () => onTap != null
                    ? onTap!()
                    : selectEntity(entity: purchaseOrder),
                onLongPress: () => onLongPress != null
                    ? onLongPress!()
                    : selectEntity(entity: purchaseOrder, longPress: true),
                leading: showCheckbox
                    ? IgnorePointer(
                        ignoring: listUIState.isInMultiselect(),
                        child: Checkbox(
                          value: isChecked,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
                          vendor!.name,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                          formatNumber(
                            purchaseOrder.amount,
                            context,
                            vendorId: vendor!.id,
                          )!,
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: filterMatch == null
                              ? Text(((purchaseOrder.number.isEmpty
                                          ? localization!.pending
                                          : purchaseOrder.number) +
                                      ' • ' +
                                      formatDate(purchaseOrder.date, context) +
                                      (purchaseOrder.documents.isNotEmpty
                                          ? '  📎'
                                          : ''))
                                  .trim())
                              : Text(
                                  filterMatch,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                        ),
                        Text(
                            localization!.lookup(kPurchaseOrderStatuses[
                                purchaseOrder.calculatedStatusId]),
                            style: TextStyle(
                              color: !purchaseOrder.isSent
                                  ? textColor
                                  : PurchaseOrderStatusColors(
                                          state.prefState.colorThemeModel)
                                      .colors[purchaseOrder.calculatedStatusId],
                            )),
                      ],
                    ),
                    EntityStateLabel(purchaseOrder),
                  ],
                ),
              );
      }),
    );
  }
}
