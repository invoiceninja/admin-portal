import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/bank_account/bank_account_actions.dart';
import 'package:invoiceninja_flutter/redux/transaction/transaction_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/bank_account/view/bank_account_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

class BankAccountView extends StatefulWidget {
  const BankAccountView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
  }) : super(key: key);

  final BankAccountViewVM viewModel;
  final bool isFilter;

  @override
  _BankAccountViewState createState() => new _BankAccountViewState();
}

class _BankAccountViewState extends State<BankAccountView> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final bankAccount = viewModel.bankAccount;
    final state = viewModel.state;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: bankAccount,
      onBackPressed: () => viewModel.onBackPressed(),
      body: ScrollableListView(
        children: <Widget>[
          if (!kReleaseMode || bankAccount.isConnected) ...[
            EntityHeader(
              entity: bankAccount,
              label: localization.balance,
              value: formatNumber(bankAccount.balance, context),
            ),
            if (!kReleaseMode || bankAccount.isDisconnected) ...[
              ListDivider(),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: AppButton(
                  label: localization.reconnect,
                  onPressed: () {
                    handleBankAccountAction(
                        context, [bankAccount], EntityAction.reconnect);
                  },
                  iconData: getEntityActionIcon(EntityAction.reconnect),
                ),
              ),
            ],
          ],
          ListDivider(),
          EntitiesListTile(
            entity: bankAccount,
            isFilter: widget.isFilter,
            entityType: EntityType.transaction,
            title: localization.transactions,
            subtitle: memoizedTransactionStatsForBankAccount(
                    bankAccount.id, state.transactionState.map)
                .present(localization.active, localization.archived),
          ),
          FieldGrid({
            localization.type: toTitleCase(bankAccount.type),
            localization.status: toTitleCase(bankAccount.status),
            localization.provider: bankAccount.provider,
            if (bankAccount.isConnected)
              localization.autoSync: bankAccount.autoSync
                  ? localization.enabled
                  : localization.disabled,
          }),
        ],
      ),
    );
  }
}
