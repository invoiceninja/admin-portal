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

class CreditListItem extends StatelessWidget {
  const CreditListItem({
    required this.user,
    required this.credit,
    required this.client,
    required this.filter,
    this.onTap,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity? user;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;
  final InvoiceEntity credit;
  final ClientEntity client;
  final String? filter;
  final Function(bool?)? onCheckboxChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final uiState = state.uiState;
    final creditUIState = uiState.creditUIState;
    final listUIState = state.getUIState(credit.entityType)!.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;
    final textStyle = TextStyle(fontSize: 16);
    final localization = AppLocalization.of(context);
    final filterMatch = filter != null && filter!.isNotEmpty
        ? (credit.matchesFilterValue(filter) ??
            client.matchesFilterValue(filter))
        : null;
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;

    String subtitle = '';
    if (credit.date.isNotEmpty) {
      subtitle = formatDate(credit.date, context);
    }

    return DismissibleEntity(
      isSelected: credit.id ==
          (uiState.isEditing
              ? creditUIState.editing!.id
              : creditUIState.selectedId),
      userCompany: state.userCompany,
      entity: credit,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return constraints.maxWidth > kTableListWidthCutoff
            ? InkWell(
                onTap: () =>
                    onTap != null ? onTap!() : selectEntity(entity: credit),
                onLongPress: () => onLongPress != null
                    ? onLongPress!()
                    : selectEntity(entity: credit, longPress: true),
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
                                  entityActions: credit.getActions(
                                    userCompany: state.userCompany,
                                    client: client,
                                    includeEdit: true,
                                  ),
                                  isSaving: false,
                                  entity: credit,
                                  onSelected: (context, action) =>
                                      handleEntityAction(credit, action),
                                )),
                      SizedBox(
                        width: kListNumberWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              credit.number.isEmpty
                                  ? localization!.pending
                                  : credit.number,
                              style: textStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (!credit.isActive) EntityStateLabel(credit)
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
                                    (credit.documents.isNotEmpty ? '  📎' : ''),
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
                        formatNumber(credit.amount, context,
                            clientId: client.id)!,
                        style: textStyle,
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(width: 25),
                      EntityStatusChip(entity: credit),
                    ],
                  ),
                ),
              )
            : ListTile(
                onTap: () =>
                    onTap != null ? onTap!() : selectEntity(entity: credit),
                onLongPress: () => onLongPress != null
                    ? onLongPress!()
                    : selectEntity(entity: credit, longPress: true),
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
                          client.displayName,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                          formatNumber(
                              credit.balance > 0
                                  ? credit.balance
                                  : credit.amount,
                              context,
                              clientId: credit.clientId)!,
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
                              ? Text(((credit.number.isEmpty
                                          ? localization!.pending
                                          : credit.number) +
                                      ' • ' +
                                      formatDate(credit.date, context) +
                                      (credit.documents.isNotEmpty
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
                                kCreditStatuses[credit.calculatedStatusId]),
                            style: TextStyle(
                              color: !credit.isSent
                                  ? textColor
                                  : CreditStatusColors(
                                          state.prefState.colorThemeModel)
                                      .colors[credit.calculatedStatusId],
                            )),
                      ],
                    ),
                    EntityStateLabel(credit),
                  ],
                ),
              );
      }),
    );
  }
}
