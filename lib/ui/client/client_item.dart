import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/dismissible_entity.dart';
//import 'package:invoiceninja/utils/localization.dart';

import '../app/entity_state_label.dart';

class ClientItem extends StatelessWidget {
  final AppState state;
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  //final ValueChanged<bool> onCheckboxChanged;
  final ClientEntity client;
  final String filter;

  static final clientItemKey = (int id) => Key('__client_item_${id}__');

  const ClientItem({
    @required this.state,
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
