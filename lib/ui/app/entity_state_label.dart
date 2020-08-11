import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EntityStateLabel extends StatelessWidget {
  const EntityStateLabel(this.entity);

  final BaseEntity entity;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return entity.isDeleted
        ? Text(localization.deleted,
            style: TextStyle(color: Colors.red, fontSize: 14.0))
        : entity.isArchived
            ? Text(localization.archived,
                style: TextStyle(color: Colors.orange, fontSize: 14.0))
            : Container();
  }
}
