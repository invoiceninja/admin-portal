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

class InvoiceListItem extends StatelessWidget {
  const InvoiceListItem({
    required this.invoice,
    this.filter,
    this.onTap,
    this.isChecked = false,
    this.showCheckbox = false,
    this.showSelected = true,
  });

  final InvoiceEntity invoice;
  final String? filter;
  final bool showCheckbox;
  final bool isChecked;
  final Function? onTap;
  final bool showSelected;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final client = state.clientState.get(invoice.clientId);
    final uiState = state.uiState;
    final invoiceUIState = uiState.invoiceUIState;
    final textStyle = TextStyle(fontSize: 16);
    final localization = AppLocalization.of(context)!;
    final filterMatch = filter != null && filter!.isNotEmpty
        ? (invoice.matchesFilterValue(filter) ??
            client.matchesFilterValue(filter))
        : null;

    final statusLabel =
        localization.lookup(kInvoiceStatuses[invoice.calculatedStatusId]);
    final statusColor = InvoiceStatusColors(state.prefState.colorThemeModel)
        .colors[invoice.calculatedStatusId];
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;

    String subtitle = '';
    if (invoice.date.isNotEmpty) {
      subtitle = formatDate(invoice.date, context);
    }
    if (invoice.partialDueDate.isNotEmpty && invoice.partial != 0) {
      if (subtitle.isNotEmpty) {
        subtitle += ' • ';
      }
      subtitle += formatDate(invoice.partialDueDate, context);
    } else if (invoice.dueDate.isNotEmpty) {
      if (subtitle.isNotEmpty) {
        subtitle += ' • ';
      }
      subtitle += formatDate(invoice.dueDate, context);
    }

    return DismissibleEntity(
        isSelected: isDesktop(context) &&
            showSelected &&
            invoice.id ==
                (uiState.isEditing
                    ? invoiceUIState.editing!.id
                    : invoiceUIState.selectedId),
        showMultiselect: showSelected,
        userCompany: state.userCompany,
        entity: invoice,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return constraints.maxWidth > kTableListWidthCutoff
              ? InkWell(
                  onTap: () => onTap != null
                      ? onTap!()
                      : selectEntity(
                          entity: invoice,
                          forceView: !showCheckbox,
                        ),
                  onLongPress: () => onTap != null
                      ? null
                      : selectEntity(entity: invoice, longPress: true),
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
                                      activeColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  )
                                : ActionMenuButton(
                                    entityActions: invoice.getActions(
                                      userCompany: state.userCompany,
                                      client: client,
                                      includeEdit: true,
                                    ),
                                    isSaving: false,
                                    entity: invoice,
                                    onSelected: (context, action) =>
                                        handleEntityAction(invoice, action),
                                  )),
                        SizedBox(
                          width: kListNumberWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                invoice.number.isEmpty
                                    ? localization.pending
                                    : invoice.number,
                                style: textStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (!invoice.isActive) EntityStateLabel(invoice)
                            ],
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
                                    .titleSmall!
                                    .copyWith(
                                      color: textColor!
                                          .withOpacity(kLighterOpacity),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          formatNumber(
                              invoice.balance != 0
                                  ? invoice.balance
                                  : invoice.amount,
                              context,
                              clientId: client.id)!,
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
                      ? onTap!()
                      : selectEntity(entity: invoice, forceView: !showCheckbox),
                  onLongPress: () => onTap != null
                      ? null
                      : selectEntity(entity: invoice, longPress: true),
                  leading: showCheckbox
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
                      : null,
                  title: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            client.displayName,
                            style: Theme.of(context).textTheme.titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                            formatNumber(
                                invoice.balance != 0
                                    ? invoice.balance
                                    : invoice.amount,
                                context,
                                clientId: invoice.clientId)!,
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
                                ? Text(((invoice.number.isEmpty
                                            ? localization.pending
                                            : invoice.number) +
                                        ' • ' +
                                        formatDate(
                                            invoice.primaryDate, context) +
                                        (invoice.documents.isNotEmpty
                                            ? '  📎'
                                            : ''))
                                    .trim())
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
