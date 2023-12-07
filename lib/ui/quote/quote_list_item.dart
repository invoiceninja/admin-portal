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

class QuoteListItem extends StatelessWidget {
  const QuoteListItem({
    required this.quote,
    this.filter,
    this.showCheckbox = true,
  });

  final InvoiceEntity quote;
  final String? filter;
  final bool showCheckbox;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final client = state.clientState.get(quote.clientId);
    final uiState = state.uiState;
    final quoteUIState = uiState.quoteUIState;
    final listUIState = state.getUIState(quote.entityType)!.listUIState;
    final isInMultiselect = showCheckbox && listUIState.isInMultiselect();
    final isChecked = isInMultiselect && listUIState.isSelected(quote.id);
    final textStyle = TextStyle(fontSize: 16);
    final localization = AppLocalization.of(context);
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    final filterMatch = filter != null && filter!.isNotEmpty
        ? (quote.matchesFilterValue(filter) ??
            client.matchesFilterValue(filter))
        : null;

    String subtitle = '';
    if (quote.date.isNotEmpty) {
      subtitle = formatDate(quote.date, context);
    }
    if (quote.dueDate.isNotEmpty) {
      if (subtitle.isNotEmpty) {
        subtitle += ' • ';
      }
      subtitle += formatDate(quote.dueDate, context);
    }

    return DismissibleEntity(
        isSelected: quote.id ==
            (uiState.isEditing
                ? quoteUIState.editing!.id
                : quoteUIState.selectedId),
        userCompany: state.userCompany,
        showMultiselect: showCheckbox,
        entity: quote,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return constraints.maxWidth > kTableListWidthCutoff
              ? InkWell(
                  onTap: () =>
                      selectEntity(entity: quote, forceView: !showCheckbox),
                  onLongPress: () =>
                      selectEntity(entity: quote, longPress: true),
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
                            child: isInMultiselect
                                ? IgnorePointer(
                                    ignoring: listUIState.isInMultiselect(),
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
                                    entityActions: quote.getActions(
                                      userCompany: state.userCompany,
                                      client: client,
                                      includeEdit: true,
                                    ),
                                    isSaving: false,
                                    entity: quote,
                                    onSelected: (context, action) =>
                                        handleEntityAction(quote, action),
                                  )),
                        SizedBox(
                          width: kListNumberWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                quote.number.isEmpty
                                    ? localization!.pending
                                    : quote.number,
                                style: textStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (!quote.isActive) EntityStateLabel(quote)
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
                                      (quote.documents.isNotEmpty
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
                          formatNumber(quote.amount, context,
                              clientId: client.id)!,
                          style: textStyle,
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(width: 25),
                        EntityStatusChip(entity: quote),
                      ],
                    ),
                  ),
                )
              : ListTile(
                  onTap: () =>
                      selectEntity(entity: quote, forceView: !showCheckbox),
                  onLongPress: () =>
                      selectEntity(entity: quote, longPress: true),
                  leading: isInMultiselect
                      ? IgnorePointer(
                          ignoring: listUIState.isInMultiselect(),
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
                            formatNumber(quote.amount, context,
                                clientId: quote.clientId)!,
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
                                ? Text(((quote.number.isEmpty
                                            ? localization!.pending
                                            : quote.number) +
                                        ' • ' +
                                        formatDate(
                                            quote.dueDate.isNotEmpty
                                                ? quote.dueDate
                                                : quote.date,
                                            context) +
                                        (quote.documents.isNotEmpty
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
                              localization!.lookup(
                                  kQuoteStatuses[quote.calculatedStatusId]),
                              style: TextStyle(
                                color: !quote.isSent
                                    ? textColor
                                    : QuoteStatusColors(
                                            state.prefState.colorThemeModel)
                                        .colors[quote.calculatedStatusId],
                              )),
                        ],
                      ),
                      EntityStateLabel(quote),
                    ],
                  ),
                );
        }));
  }
}
