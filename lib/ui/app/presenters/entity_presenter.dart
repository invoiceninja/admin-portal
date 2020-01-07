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

  String getField({String field, BuildContext context}) {
    final localization = AppLocalization.of(context);

    switch (field) {
      case EntityFields.id:
        return entity.id;
      case EntityFields.createdAt:
        return formatDate(
            convertTimestampToDateString(entity.createdAt), context);
      case EntityFields.updatedAt:
        return formatDate(
            convertTimestampToDateString(entity.updatedAt), context);
      case EntityFields.state:
        return entity.isActive
            ? localization.active
            : entity.isArchived ? localization.archived : localization.deleted;
    }

    return 'Error: $field not found';
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
