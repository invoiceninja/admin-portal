import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CreditListItem extends StatelessWidget {
  const CreditListItem({
    @required this.user,
    @required this.onEntityAction,
    @required this.onTap,
    @required this.onLongPress,
    @required this.credit,
    @required this.client,
    @required this.filter,
    @required this.hasDocuments,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity user;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final InvoiceEntity credit;
  final ClientEntity client;
  final String filter;
  final bool hasDocuments;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final uiState = state.uiState;
    final creditUIState = uiState.creditUIState;
    final listUIState = state.getUIState(credit.entityType).listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;
    final textStyle = TextStyle(fontSize: 17);
    final localization = AppLocalization.of(context);
    final filterMatch = filter != null && filter.isNotEmpty
        ? (credit.matchesFilterValue(filter) ??
            client.matchesFilterValue(filter))
        : null;

    final statusLabel = localization.lookup(kCreditStatuses[credit.statusId]);
    final statusColor = CreditStatusColors.colors[credit.statusId];

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
              Text(
                  formatNumber(
                      credit.balance > 0 ? credit.balance : credit.amount,
                      context,
                      clientId: credit.clientId),
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
                  child: filterMatch == null
                      ? Text(((credit.number ?? localization.pending) +
                              ' • ' +
                              formatDate(credit.date, context) +
                              (hasDocuments ? '  📎' : ''))
                          .trim())
                      : Text(
                          filterMatch,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
                Text(localization.lookup(kCreditStatuses[credit.statusId]),
                    style: TextStyle(
                      color: CreditStatusColors.colors[credit.statusId],
                    )),
              ],
            ),
            EntityStateLabel(credit),
          ],
        ),
      );
    }

    Widget _buildDesktop() {
      String subtitle = '';
      if (credit.date.isNotEmpty) {
        subtitle = formatDate(credit.date, context);
      }
      if (hasDocuments) {
        subtitle += '  📎';
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
                          entityActions: credit.getActions(
                              userCompany: state.userCompany,
                              includeEdit: true,
                              client: client),
                          isSaving: false,
                          entity: credit,
                          onSelected: (context, action) =>
                              handleEntityAction(context, credit, action),
                        )),
              ConstrainedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      credit.number ?? localization.pending,
                      style: textStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (!credit.isActive) EntityStateLabel(credit)
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
                formatNumber(credit.amount, context, clientId: client.id),
                style: textStyle,
                textAlign: TextAlign.end,
              ),
              SizedBox(width: 25),
              credit.isSent
                  ? DecoratedBox(
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 80,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            statusLabel.toUpperCase(),
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      child: Text(
                        localization.draft.toUpperCase(),
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      width: 80,
                    ),
            ],
          ),
        ),
      );
    }

    return DismissibleEntity(
      isSelected: credit.id ==
          (uiState.isEditing
              ? creditUIState.editing.id
              : creditUIState.selectedId),
      userCompany: state.userCompany,
      entity: credit,
      onEntityAction: onEntityAction,
      child: state.prefState.isMobile ? _buildMobile() : _buildDesktop(),
    );
  }
}
