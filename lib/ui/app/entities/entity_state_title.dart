import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EntityStateTitle extends StatelessWidget {
  const EntityStateTitle({@required this.entity});

  final BaseEntity entity;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final titleText = localization.lookup('${entity.entityType}') +
        '  ›  ' +
        entity.listDisplayName;

    return Text(
      titleText,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
