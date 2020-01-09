import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';

class TaskPresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      TaskFields.description,
      EntityFields.state,
    ];
  }

  @override
  String getField({String field, BuildContext context}) {
    final task = entity as TaskEntity;

    switch (field) {
      case TaskFields.description:
        return task.description;
    }

    return super.getField(field: field, context: context);
  }
}
