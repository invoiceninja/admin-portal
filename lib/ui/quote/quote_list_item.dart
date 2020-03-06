import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class QuoteListItem extends StatelessWidget {
  const QuoteListItem({
    @required this.user,
    @required this.onEntityAction,
    @required this.onTap,
    @required this.onLongPress,
    @required this.quote,
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
  final InvoiceEntity quote;
  final ClientEntity client;
  final String filter;
  final bool hasDocuments;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final uiState = state.uiState;
    final quoteUIState = uiState.quoteUIState;
    final listUIState = state.getUIState(quote.entityType).listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;

    final localization = AppLocalization.of(context);
    final filterMatch = filter != null && filter.isNotEmpty
        ? (quote.matchesFilterValue(filter) ??
            client.matchesFilterValue(filter))
        : null;

    return DismissibleEntity(
      isSelected: quote.id ==
          (uiState.isEditing
              ? quoteUIState.editing.id
              : quoteUIState.selectedId),
      userCompany: state.userCompany,
      entity: quote,
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
                  client.displayName,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Text(
                  formatNumber(
                      quote.balance > 0 ? quote.balance : quote.amount, context,
                      clientId: quote.clientId),
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
                      ? Text(((quote.number ?? localization.pending) +
                              ' • ' +
                              formatDate(
                                  quote.dueDate.isNotEmpty
                                      ? quote.dueDate
                                      : quote.date,
                                  context) +
                              (hasDocuments ? '  📎' : ''))
                          .trim())
                      : Text(
                          filterMatch,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
                Text(
                    quote.isPastDue
                        ? localization.expired
                        : localization.lookup(kQuoteStatuses[quote.statusId]),
                    style: TextStyle(
                      color: quote.isPastDue
                          ? Colors.red
                          : QuoteStatusColors.colors[quote.statusId],
                    )),
              ],
            ),
            EntityStateLabel(quote),
          ],
        ),
      ),
    );
  }
}
