import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentListItem extends StatelessWidget {
  const PaymentListItem({
    @required this.user,
    @required this.onEntityAction,
    @required this.onTap,
    @required this.onLongPress,
    @required this.payment,
    @required this.filter,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity user;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final PaymentEntity payment;
  final String filter;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  static final paymentItemKey = (int id) => Key('__payment_${id}__');

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final uiState = state.uiState;
    final paymentUIState = uiState.paymentUIState;
    final listUIState = paymentUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;
    final textStyle = TextStyle(fontSize: 17);
    final client = state.clientState.map[payment.clientId];
    final localization = AppLocalization.of(context);
    final filterMatch = filter != null && filter.isNotEmpty
        ? payment.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch ??
        (payment.number ?? '') + ' • ' + formatDate(payment.date, context);

    Widget _buildMobile() {
      return ListTile(
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
                  client.displayName,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Text(formatNumber(payment.amount, context),
                  style: Theme.of(context).textTheme.headline6),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: subtitle != null && subtitle.isNotEmpty
                      ? Text(
                          subtitle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      : Container(),
                ),
                Text(localization.lookup('payment_status_${payment.statusId}'),
                    style: TextStyle(
                      color: PaymentStatusColors.colors[payment.statusId],
                    )),
              ],
            ),
            EntityStateLabel(payment),
          ],
        ),
      );
    }

    Widget _buildDesktop() {
      String subtitle = '';
      if (payment.date.isNotEmpty) {
        subtitle = formatDate(payment.date, context);
      }
      if (payment.transactionReference.isNotEmpty) {
        if (subtitle.isNotEmpty) {
          subtitle += ' • ';
        }
        subtitle += payment.transactionReference;
      }

      return InkWell(
        onTap: isInMultiselect
            ? () => onEntityAction(EntityAction.toggleMultiselect)
            : onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 28,
            top: 4,
            bottom: 4,
          ),
          child: Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: showCheckbox
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
                      : ActionMenuButton(
                          entityActions: payment.getActions(
                              userCompany: state.userCompany,
                              includeEdit: true,
                              client: client),
                          isSaving: false,
                          entity: payment,
                          onSelected: (context, action) =>
                              handleEntityAction(context, payment, action),
                        )),
              ConstrainedBox(
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
                constraints: BoxConstraints(
                  minWidth: 80,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(client.displayName, style: textStyle),
                    Text(
                      filterMatch ?? subtitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Text(
                formatNumber(payment.amount, context, clientId: client.id),
                style: textStyle,
                textAlign: TextAlign.end,
              ),
              SizedBox(width: 25),
              EntityStatusChip(
                entityType: EntityType.payment,
                statusId: payment.statusId,
              )
            ],
          ),
        ),
      );
    }

    return DismissibleEntity(
      isSelected: payment.id ==
          (uiState.isEditing
              ? paymentUIState.editing.id
              : paymentUIState.selectedId),
      userCompany: state.userCompany,
      entity: payment,
      onEntityAction: onEntityAction,
      child: state.prefState.isMobile ? _buildMobile() : _buildDesktop(),
    );
  }
}
