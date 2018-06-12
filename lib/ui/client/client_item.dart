import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/dismissible_entity.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  //final ValueChanged<bool> onCheckboxChanged;
  final ClientEntity client;

  static final clientItemKey = (int id) => Key('__client_item_${id}__');

  ClientItem({
    @required this.onDismissed,
    @required this.onTap,
    //@required this.onCheckboxChanged,
    @required this.client,
  });

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    return DismissibleEntity(
      onDismissed: onDismissed,
      entity: client,
      //entityKey: clientItemKey,
      child: ListTile(
        onTap: onTap,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  client.displayName,
                  //key: NinjaKeys.clientItemClientKey(client.id),
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ],
          ),
        ),
        subtitle: Text(
            localization.paidToDate + ': ' + client.balance.toStringAsFixed(2)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            client.isDeleted
                ? Chip(
                    label: Text(localization.deleted,
                        style: TextStyle(color: Colors.white, fontSize: 11.0)),
                    backgroundColor: Colors.red,
                  )
                : client.isArchived()
                    ? Chip(
                        label: Text(localization.archived,
                            style:
                                TextStyle(color: Colors.white, fontSize: 11.0)),
                        backgroundColor: Colors.orange,
                      )
                    : Container(),
            SizedBox(width: 12.0),
            Text(client.balance.toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }
}
