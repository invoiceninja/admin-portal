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

  static String getMessage(
      {BuildContext context, EntityType filterEntityType, BaseEntity entity}) {
    final localization = AppLocalization.of(context);
    String message;

    switch (filterEntityType) {
      case EntityType.group:
        return localization.filteredByGroup;
        break;
      case EntityType.invoice:
        message = localization.filteredByInvoice;
        break;
      case EntityType.client:
        message = localization.filteredByClient;
        break;
      case EntityType.user:
        message = localization.filteredByUser;
        break;
      case EntityType.project:
        message = localization.filteredByProject;
        break;
      case EntityType.vendor:
        message = localization.filteredByVendor;
        break;
    }

    return '$message: ${entity?.listDisplayName ?? ''}';
  }

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final filteredEntity = state.getEntityMap(filterEntityType)[filterEntityId];

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
                ListFilterMessage.getMessage(
                    context: context,
                    entity: filteredEntity,
                    filterEntityType: filterEntityType),
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
