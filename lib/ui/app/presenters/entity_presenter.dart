import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EntityPresenter {
  BaseEntity entity;
  BuildContext context;

  void initialize({BaseEntity entity, BuildContext context}) {
    this.entity = entity;
    this.context = context;
  }

  Widget getField({String field, BuildContext context}) {
    final localization = AppLocalization.of(context);

    switch (field) {
      case EntityFields.id:
        return Text(entity.id);
      case EntityFields.createdAt:
        return Text(formatDate(
            convertTimestampToDateString(entity.createdAt), context));
      case EntityFields.updatedAt:
        return Text(formatDate(
            convertTimestampToDateString(entity.updatedAt), context));
      case EntityFields.state:
        return Text(entity.isActive
            ? localization.active
            : entity.isArchived ? localization.archived : localization.deleted);
    }

    return Text('Error: $field not found');
  }

  static bool isFieldNumeric(String field) => [
        'cost',
        'price',
        'amount',
        'total',
        'balance',
        'quantity'
      ].contains(field);
}
