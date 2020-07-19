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
import 'package:invoiceninja_flutter/utils/platforms.dart';

class InvoiceListItem extends StatelessWidget {
  const InvoiceListItem({
    @required this.user,
    @required this.onEntityAction,
    @required this.invoice,
    @required this.client,
    @required this.filter,
    this.onTap,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity user;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final InvoiceEntity invoice;
  final ClientEntity client;
  final String filter;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final invoiceUIState = uiState.invoiceUIState;
    final listUIState = state.getUIState(invoice.entityType).listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;
    final textStyle = TextStyle(fontSize: 16);
    final localization = AppLocalization.of(context);
    final filterMatch = filter != null && filter.isNotEmpty
        ? (invoice.matchesFilterValue(filter) ??
            client.matchesFilterValue(filter))
        : null;

    final statusLabel =
        localization.lookup(kInvoiceStatuses[invoice.calculatedStatusId]);
    final statusColor = InvoiceStatusColors.colors[invoice.calculatedStatusId];
    final textColor = Theme.of(context).textTheme.bodyText1.color;

    String subtitle = '';
    if (invoice.date.isNotEmpty) {
      subtitle = formatDate(invoice.date, context);
    }
    if (invoice.dueDate.isNotEmpty) {
      if (subtitle.isNotEmpty) {
        subtitle += ' • ';
      }
      subtitle += formatDate(invoice.dueDate, context);
    }

    return DismissibleEntity(
        isSelected: isDesktop(context) &&
            invoice.id ==
                (uiState.isEditing
                    ? invoiceUIState.editing.id
                    : invoiceUIState.selectedId),
        userCompany: state.userCompany,
        entity: invoice,
        onEntityAction: onEntityAction,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return constraints.maxWidth > kTableListWidthCutoff
              ? InkWell(
                  onTap: () => onTap != null
                      ? onTap()
                      : selectEntity(entity: invoice, context: context),
                  onLongPress: () => onLongPress != null
                      ? onLongPress()
                      : selectEntity(
                          entity: invoice, context: context, longPress: true),
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
                            padding: const EdgeInsets.only(right: 16),
                            child: showCheckbox
                                ? IgnorePointer(
                                    ignoring: listUIState.isInMultiselect(),
                                    child: Checkbox(
                                      value: isChecked,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      onChanged: (value) =>
                                          onCheckboxChanged(value),
                                      activeColor:
                                          Theme.of(context).accentColor,
                                    ),
                                  )
                                : ActionMenuButton(
                                    entityActions: invoice.getActions(
                                        userCompany: state.userCompany,
                                        client: client),
                                    isSaving: false,
                                    entity: invoice,
                                    onSelected: (context, action) =>
                                        handleEntityAction(
                                            context, invoice, action),
                                  )),
                        ConstrainedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                (invoice.number ?? '').isEmpty
                                    ? localization.pending
                                    : invoice.number,
                                style: textStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (!invoice.isActive) EntityStateLabel(invoice)
                            ],
                          ),
                          constraints: BoxConstraints(
                            minWidth: 80,
                            maxWidth: 80,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  client.displayName +
                                      (invoice.documents.isNotEmpty
                                          ? '  📎'
                                          : ''),
                                  style: textStyle),
                              Text(
                                filterMatch ?? subtitle,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                      color: textColor.withOpacity(0.65),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          formatNumber(
                              invoice.balance > 0
                                  ? invoice.balance
                                  : invoice.amount,
                              context,
                              clientId: client.id),
                          style: textStyle,
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(width: 25),
                        EntityStatusChip(entity: invoice)
                      ],
                    ),
                  ),
                )
              : ListTile(
                  onTap: () => onTap != null
                      ? onTap()
                      : selectEntity(entity: invoice, context: context),
                  onLongPress: () => onLongPress != null
                      ? onLongPress()
                      : selectEntity(
                          entity: invoice, context: context, longPress: true),
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
                            client.displayName,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Text(
                            formatNumber(
                                invoice.balance > 0
                                    ? invoice.balance
                                    : invoice.amount,
                                context,
                                clientId: invoice.clientId),
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
                                ? Text(
                                    (((invoice.number ?? '').isEmpty
                                                ? localization.pending
                                                : invoice.number) +
                                            ' • ' +
                                            formatDate(
                                                invoice.dueDate.isNotEmpty
                                                    ? invoice.dueDate
                                                    : invoice.date,
                                                context) +
                                            (invoice.documents.isNotEmpty
                                                ? '  📎'
                                                : ''))
                                        .trim(),
                                    style: TextStyle(
                                      color: textColor.withOpacity(0.65),
                                    ),
                                  )
                                : Text(
                                    filterMatch,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                          ),
                          Text(statusLabel,
                              style: TextStyle(
                                color:
                                    !invoice.isSent ? textColor : statusColor,
                              )),
                        ],
                      ),
                      EntityStateLabel(invoice),
                    ],
                  ),
                );
        }));
  }
}
