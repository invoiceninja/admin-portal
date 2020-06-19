import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientViewLedger extends StatefulWidget {
  const ClientViewLedger({Key key, this.viewModel}) : super(key: key);

  final ClientViewVM viewModel;

  @override
  _ClientViewLedgerState createState() => _ClientViewLedgerState();
}

class _ClientViewLedgerState extends State<ClientViewLedger> {
  @override
  void didChangeDependencies() {
    if (widget.viewModel.client.areActivitiesStale) {
      widget.viewModel.onRefreshed(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final client = widget.viewModel.client;

    if (client.areActivitiesStale) {
      return LoadingIndicator();
    }

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: client.ledger.length,
      separatorBuilder: (context, index) => ListDivider(),
      itemBuilder: (BuildContext context, index) {
        final store = StoreProvider.of<AppState>(context);
        final localization = AppLocalization.of(context);
        final ledger = client.ledger[index];
        final state = store.state;
        final entity = state.getEntityMap(ledger.entityType)[ledger.entityId];

        return ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${localization.lookup('${ledger.entityType}')}  ›  ${entity.listDisplayName}',
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Text(
                  formatNumber(
                    ledger.balance,
                    context,
                    clientId: client.id,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(formatDate(
                convertTimestampToDateString(ledger.createdAt),
                context,
                showTime: true,
              )),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: ledger.adjustment <= 0 ? kColorGreen : kColorRed,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      (ledger.adjustment > 0 ? '+' : '') +
                          formatNumber(
                            ledger.adjustment,
                            context,
                            clientId: client.id,
                          ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),
            ],
          ),
          leading: Icon(getEntityIcon(ledger.entityType)),
          trailing: Icon(Icons.chevron_right),
        );
      },
    );
  }
}
