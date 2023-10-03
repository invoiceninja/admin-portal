// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientViewLedger extends StatefulWidget {
  const ClientViewLedger({Key? key, this.viewModel}) : super(key: key);

  final ClientViewVM? viewModel;

  @override
  _ClientViewLedgerState createState() => _ClientViewLedgerState();
}

class _ClientViewLedgerState extends State<ClientViewLedger> {
  @override
  void didChangeDependencies() {
    if (widget.viewModel!.client.isStale) {
      widget.viewModel!.onRefreshed(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final client = widget.viewModel!.client;
    final ledgers =
        client.ledger.where((ledger) => ledger.adjustment != 0).toList();

    if (client.isStale) {
      return LoadingIndicator();
    }

    return ScrollableListViewBuilder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: ledgers.length + 1,
      separatorBuilder: (context, index) => ListDivider(),
      itemBuilder: (BuildContext context, index) {
        final store = StoreProvider.of<AppState>(context);
        final localization = AppLocalization.of(context);
        final state = store.state;

        if (index == ledgers.length) {
          return ListTile(
            leading: Icon(getEntityIcon(EntityType.client)),
            title: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Text(localization!.clientCreated)),
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Text(
                      formatNumber(
                        0,
                        context,
                        clientId: client.id,
                      )!,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ]),
            subtitle: Text(
              formatDate(
                convertTimestampToDateString(client.createdAt),
                context,
                showTime: true,
              ),
            ),
          );
        }

        final ledger = ledgers[index];
        final entity = state.getEntityMap(ledger.entityType)![ledger.entityId];

        if (entity == null) {
          print('Error: unable to find entity $ledger');
          return SizedBox();
        }

        return ListTile(
          onTap: () => viewEntity(entity: entity as BaseEntity),
          onLongPress: () =>
              showEntityActionsDialog(entities: [entity as BaseEntity]),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '${localization!.lookup('${ledger.entityType}')}  ›  ${entity.listDisplayName}',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Text(
                  formatNumber(
                    ledger.balance,
                    context,
                    clientId: client.id,
                  )!,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  formatDate(
                    convertTimestampToDateString(ledger.createdAt),
                    context,
                    showTime: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: ledger.adjustment <= 0
                        ? state.prefState.colorThemeModel!.colorSuccess
                        : state.prefState.colorThemeModel!.colorDanger,
                    borderRadius:
                        BorderRadius.all(Radius.circular(kBorderRadius)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      (ledger.adjustment > 0 ? '+' : '') +
                          formatNumber(
                            ledger.adjustment,
                            context,
                            clientId: client.id,
                          )!,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),
            ],
          ),
          leading: Icon(getEntityIcon(ledger.entityType)),
        );
      },
    );
  }
}
