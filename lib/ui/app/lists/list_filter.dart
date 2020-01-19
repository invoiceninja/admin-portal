import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
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

  static Widget getFilterListTile(
      {BuildContext context, EntityType filterEntityType, BaseEntity entity}) {
    final localization = AppLocalization.of(context);

    return ListTile(
      leading: Icon(getEntityIcon(filterEntityType)),
      title: Text(localization.filteredBy
          .replaceFirst(':value', entity.listDisplayName)),
      subtitle: Text(localization.lookup(filterEntityType.toString())),
    );
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
              child: ListFilterMessage.getFilterListTile(
                  context: context,
                  entity: filteredEntity,
                  filterEntityType: filterEntityType),
              /*
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
               */
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
