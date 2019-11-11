import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ListFilterMessage extends StatelessWidget {
  const ListFilterMessage({
    @required this.filterEntityId,
    @required this.filterEntityType,
    @required this.onPressed,
    @required this.onClearPressed,
  });

  final String filterEntityId;
  final EntityType filterEntityType;
  final Function(BuildContext) onPressed;
  final Function() onClearPressed;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;

    final filteredEntity = state.getEntityMap(filterEntityType)[filterEntityId];
    String filteredMessage;

    switch (filterEntityType) {
      case EntityType.group:
        filteredMessage = localization.filteredByGroup;
        break;
      case EntityType.invoice:
        filteredMessage = localization.filteredByInvoice;
        break;
      case EntityType.client:
        filteredMessage = localization.filteredByClient;
        break;
      case EntityType.user:
        filteredMessage = localization.filteredByUser;
        break;
      case EntityType.project:
        filteredMessage = localization.filteredByProject;
        break;
      case EntityType.vendor:
        filteredMessage = localization.filteredByVendor;
        break;
    }

    return Material(
      color: Colors.orangeAccent,
      elevation: 6.0,
      child: InkWell(
        onTap: () => onPressed(context),
        child: Row(
          children: <Widget>[
            SizedBox(width: 18.0),
            Expanded(
              child: Text(
                '$filteredMessage: ${filteredEntity?.listDisplayName ?? ''}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () => onClearPressed(),
            )
          ],
        ),
      ),
    );
  }
}
