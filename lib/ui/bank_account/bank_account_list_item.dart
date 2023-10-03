import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

class BankAccountListItem extends StatelessWidget {
  const BankAccountListItem({
    required this.user,
    required this.bankAccount,
    required this.filter,
    this.onTap,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity? user;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;
  final BankAccountEntity bankAccount;
  final String? filter;
  final Function(bool?)? onCheckboxChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final bankAccountUIState = uiState.bankAccountUIState;
    final listUIState = bankAccountUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;

    return DismissibleEntity(
      userCompany: state.userCompany,
      entity: bankAccount,
      isSelected: bankAccount.id ==
          (uiState.isEditing
              ? bankAccountUIState.editing!.id
              : bankAccountUIState.selectedId),
      child: ListTile(
        onTap: () =>
            onTap != null ? onTap!() : selectEntity(entity: bankAccount),
        onLongPress: () => onLongPress != null
            ? onLongPress!()
            : selectEntity(entity: bankAccount, longPress: true),
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
                  bankAccount.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              if (bankAccount.isConnected)
                Text(formatNumber(bankAccount.balance, context)!,
                    style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(toTitleCase(bankAccount.type) +
                (bankAccount.disabledUpstream
                    ? ' • ${localization!.disabled}'
                    : '')),
            EntityStateLabel(bankAccount),
          ],
        ),
      ),
    );
  }
}
