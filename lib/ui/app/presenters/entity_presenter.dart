import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class EntityPresenter {
  BaseEntity entity;
  BuildContext context;

  void initialize({BaseEntity entity, BuildContext context}) {
    this.entity = entity;
    this.context = context;
  }

  String getField(String field) {
    switch (field) {
      case EntityFields.id:
        return entity.id;
      case EntityFields.createdAt:
        return formatDate(
            convertTimestampToDateString(entity.createdAt), context);
      case EntityFields.updatedAt:
        return formatDate(
            convertTimestampToDateString(entity.updatedAt), context);
    }

    return 'Error: $field not found';
  }
}
