import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class ProjectPresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      ProjectFields.name,
      ProjectFields.client,
      ProjectFields.taskRate,
      ProjectFields.dueDate,
      ProjectFields.privateNotes,
      ProjectFields.budgetedHours,
      EntityFields.state,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final project = entity as ProjectEntity;
    final state = StoreProvider.of<AppState>(context).state;

    switch (field) {
      case ProjectFields.name:
        return Text(project.name);
      case ProjectFields.client:
        return Text(state.clientState.map[project.clientId] ?? '');
      case ProjectFields.taskRate:
        return Text(formatNumber(project.taskRate, context));
      case ProjectFields.dueDate:
        return Text(formatDate(project.dueDate, context));
      case ProjectFields.privateNotes:
        return Text(project.privateNotes);
      case ProjectFields.budgetedHours:
        return Text(formatNumber(project.budgetedHours, context,
            formatNumberType: FormatNumberType.double));
    }

    return super.getField(field: field, context: context);
  }
}
