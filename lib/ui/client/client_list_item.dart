import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';

class ClientListItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  //final ValueChanged<bool> onCheckboxChanged;
  final ClientEntity client;
  final String filter;

  static final clientItemKey = (int id) => Key('__client_item_${id}__');

  const ClientListItem({
    @required this.onDismissed,
    @required this.onTap,
    //@required this.onCheckboxChanged,
    @required this.client,
    @required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    //var localization = AppLocalization.of(context);
    final searchMatch = filter != null && filter.isNotEmpty
        ? client.matchesSearchValue(filter)
        : null;

    return DismissibleEntity(
      onDismissed: onDismissed,
      entity: client,
      //entityKey: clientItemKey,
      child: ListTile(
        onTap: onTap,
        title: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                client.displayName,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Text(formatNumber(client.balance, context, clientId: client.id),
                style: Theme.of(context).textTheme.title)
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            searchMatch == null
                ? Container()
                : Text(
                    searchMatch,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
            EntityStateLabel(client),
          ],
        ),
      ),
    );
  }
}
