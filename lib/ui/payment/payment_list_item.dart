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
import 'package:invoiceninja_flutter/utils/platforms.dart';

class PaymentListItem extends StatelessWidget {
  const PaymentListItem({
    required this.payment,
    this.filter,
    this.showCheckbox = false,
    this.isChecked = false,
    this.onTap,
    this.showSelected = true,
  });

  final PaymentEntity payment;
  final String? filter;
  final bool showCheckbox;
  final bool isChecked;
  final Function? onTap;
  final bool showSelected;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final uiState = state.uiState;
    final paymentUIState = uiState.paymentUIState;
    final textStyle = TextStyle(fontSize: 16);
    final client = state.clientState.get(payment.clientId);
    final localization = AppLocalization.of(context);
    final filterMatch = filter != null && filter!.isNotEmpty
        ? (payment.matchesFilterValue(filter) ??
            client.matchesFilterValue(filter))
        : null;
    final mobileSubtitle = filterMatch ??
        payment.number + ' • ' + formatDate(payment.date, context);
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;

    String desktopSubtitle = '';
    if (payment.date.isNotEmpty) {
      desktopSubtitle = formatDate(payment.date, context);
    }
    if (payment.transactionReference.isNotEmpty) {
      if (desktopSubtitle.isNotEmpty) {
        desktopSubtitle += ' • ';
      }
      desktopSubtitle += payment.transactionReference;
    }

    return DismissibleEntity(
      isSelected: isDesktop(context) &&
          showSelected &&
          payment.id ==
              (uiState.isEditing
                  ? paymentUIState.editing!.id
                  : paymentUIState.selectedId),
      showMultiselect: showSelected,
      userCompany: state.userCompany,
      entity: payment,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return constraints.maxWidth > kTableListWidthCutoff
            ? InkWell(
                onTap: () => onTap != null
                    ? onTap!()
                    : selectEntity(entity: payment, forceView: !showCheckbox),
                onLongPress: () => onTap != null
                    ? null
                    : selectEntity(entity: payment, longPress: true),
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
                                  child: Checkbox(
                                    value: isChecked,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onChanged: (value) => null,
                                    activeColor:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                )
                              : ActionMenuButton(
                                  entityActions: payment.getActions(
                                    userCompany: state.userCompany,
                                    client: client,
                                    includeEdit: true,
                                  ),
                                  isSaving: false,
                                  entity: payment,
                                  onSelected: (context, action) =>
                                      handleEntityAction(payment, action),
                                )),
                      SizedBox(
                        width: kListNumberWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              payment.number,
                              style: textStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (!payment.isActive) EntityStateLabel(payment)
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(client.displayName, style: textStyle),
                            Text(
                              filterMatch ?? desktopSubtitle,
                              maxLines: 2,
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
                        formatNumber(payment.amount, context,
                            clientId: client.id)!,
                        style: textStyle,
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(width: 25),
                      EntityStatusChip(entity: payment)
                    ],
                  ),
                ),
              )
            : ListTile(
                onTap: () => onTap != null
                    ? onTap!()
                    : selectEntity(entity: payment, forceView: !showCheckbox),
                onLongPress: () => onTap != null
                    ? null
                    : selectEntity(entity: payment, longPress: true),
                leading: showCheckbox
                    ? IgnorePointer(
                        child: Checkbox(
                          value: isChecked,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (value) => null,
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
                          client.displayName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Text(
                          formatNumber(payment.amount, context,
                              clientId: payment.clientId)!,
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
                          child: mobileSubtitle.isNotEmpty
                              ? Text(
                                  mobileSubtitle,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Container(),
                        ),
                        Text(
                            localization!.lookup(
                                'payment_status_${payment.calculatedStatusId}'),
                            style: TextStyle(
                              color: PaymentStatusColors(
                                      state.prefState.colorThemeModel)
                                  .colors[payment.calculatedStatusId],
                            )),
                      ],
                    ),
                    EntityStateLabel(payment),
                  ],
                ),
              );
      }),
    );
  }
}
