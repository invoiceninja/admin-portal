import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EntityStateTitle extends StatelessWidget {
  const EntityStateTitle({
    @required this.entity,
    this.title,
    this.showStatus = false,
  });

  final BaseEntity entity;
  final String title;
  final bool showStatus;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    final state = entity.entityState;

    if (state == kEntityStateActive) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(title ?? entity.listDisplayName),
          if (showStatus) ...[
            SizedBox(width: 16),
            EntityStatusChip(
              entity: entity,
            ),
          ]
        ],
      );
    }

    return Row(
      children: <Widget>[
        Expanded(child: Text(title ?? entity.listDisplayName)),
        SizedBox(width: 20),
        Container(
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(
                width: 1.5,
                color:
                    state == kEntityStateArchived ? Colors.orange : Colors.red),
          ),
          child: Chip(
              elevation: 4,
              label: Text(localization.lookup(state),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)))),
        ),
      ],
    );
  }
}
