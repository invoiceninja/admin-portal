// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/payment_term_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class PaymentTermListItem extends StatelessWidget {
  const PaymentTermListItem({
    required this.user,
    required this.paymentTerm,
    required this.filter,
    this.onTap,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity? user;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;
  final PaymentTermEntity paymentTerm;
  final String? filter;
  final Function(bool?)? onCheckboxChanged;
  final bool isChecked;

  static final paymentTermItemKey =
      (int id) => Key('__payment_term_item_${id}__');

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final paymentTermUIState = uiState.paymentTermUIState;
    final listUIState = paymentTermUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;

    final filterMatch = filter != null && filter!.isNotEmpty
        ? paymentTerm.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch;

    return DismissibleEntity(
      userCompany: state.userCompany,
      entity: paymentTerm,
      isSelected: paymentTerm.id ==
          (uiState.isEditing
              ? paymentTermUIState.editing!.id
              : paymentTermUIState.selectedId),
      child: ListTile(
        onTap: () =>
            onTap != null ? onTap!() : selectEntity(entity: paymentTerm),
        onLongPress: () => onLongPress != null
            ? onLongPress!()
            : selectEntity(entity: paymentTerm, longPress: true),
        leading: showCheckbox
            ? IgnorePointer(
                ignoring: listUIState.isInMultiselect(),
                child: Checkbox(
                  value: isChecked,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                  paymentTerm.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(formatNumber(paymentTerm.listDisplayAmount, context)!,
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            subtitle != null && subtitle.isNotEmpty
                ? Text(
                    subtitle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                : Container(),
            EntityStateLabel(paymentTerm),
          ],
        ),
      ),
    );
  }
}
