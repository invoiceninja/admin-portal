import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
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
    return Dismissible(
      key: clientItemKey(client.id),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        /*
        leading: Checkbox(
          //key: NinjaKeys.clientItemCheckbox(client.id),
          value: true,
          //onChanged: onCheckboxChanged,
          onChanged: (value) {
            return true;
          },
        ),
        */
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            client.isDeleted
                ? Chip(
                    label: Text(AppLocalization.of(context).deleted,
                        style: TextStyle(color: Colors.white, fontSize: 11.0)),
                    backgroundColor: Colors.red,
                  )
                : client.isArchived()
                    ? Chip(
                        label: Text(AppLocalization.of(context).archived,
                            style: TextStyle(color: Colors.white, fontSize: 11.0)),
                        backgroundColor: Colors.orange,
                      )
                    : Container(),
            SizedBox(width: 12.0),
            //Text(client.cost.toStringAsFixed(2)),
          ],
        ),
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
        //subtitle: Text(client.notes),
      ),
      background: client.isDeleted ? Container(
          color: Colors.blue,
          child: const ListTile(
              leading:
              const Icon(Icons.restore, color: Colors.white, size: 36.0)),
      ) : Container(
          color: Colors.red,
          child: const ListTile(
              leading:
                  const Icon(Icons.delete, color: Colors.white, size: 36.0))),
      secondaryBackground: client.isArchived() || client.isDeleted ? Container(
        color: Colors.blue,
        child: const ListTile(
            trailing:
            const Icon(Icons.restore, color: Colors.white, size: 36.0)),
      ) : Container(
          color: Colors.orange,
          child: const ListTile(
              trailing:
                  const Icon(Icons.archive, color: Colors.white, size: 36.0))),
    );
  }
}
