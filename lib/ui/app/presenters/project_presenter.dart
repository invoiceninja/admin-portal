import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';

class ProjectPresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      ProjectFields.name,
      EntityFields.state,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final project = entity as ProjectEntity;

    switch (field) {
      case ProjectFields.name:
        return Text(project.name);
    }

    return super.getField(field: field, context: context);
  }
}
