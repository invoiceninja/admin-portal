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

  static final clientItemKey = (int id) => Key('__client_item_${id}__');

  ClientItem({
    @required this.state,
    @required this.onDismissed,
    @required this.onTap,
    //@required this.onCheckboxChanged,
    @required this.client,
  });

  @override
  Widget build(BuildContext context) {
    //var localization = AppLocalization.of(context);

    return DismissibleEntity(
      onDismissed: onDismissed,
      entity: client,
      //entityKey: clientItemKey,
      child: ListTile(
        onTap: onTap,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            client.displayName,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        subtitle: EntityStateLabel(client),
        trailing: Text(formatNumber(client.balance, state, clientId: client.id),
            style: Theme.of(context).textTheme.title),
      ),
    );
  }
}
