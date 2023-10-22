// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/link_text.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class ProjectPresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity? userCompany) {
    return [
      ProjectFields.name,
      ProjectFields.client,
      ProjectFields.taskRate,
      ProjectFields.dueDate,
      ProjectFields.totalHours,
      ProjectFields.budgetedHours,
      ProjectFields.publicNotes,
      ProjectFields.privateNotes,
      EntityFields.state,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity? userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      ProjectFields.number,
      ProjectFields.clientNumber,
      ProjectFields.clientIdNumber,
      ProjectFields.customValue1,
      ProjectFields.customValue2,
      ProjectFields.customValue3,
      ProjectFields.customValue4,
      ProjectFields.documents,
    ];
  }

  @override
  Widget getField({String? field, required BuildContext context}) {
    final project = entity as ProjectEntity;
    final state = StoreProvider.of<AppState>(context).state;
    final client = state.clientState.get(project.clientId);

    switch (field) {
      case ProjectFields.name:
        return Text(project.name);
      case ProjectFields.client:
        return LinkTextRelatedEntity(entity: client, relation: project);
      case ProjectFields.clientIdNumber:
        return Text(client.idNumber);
      case ProjectFields.clientNumber:
        return Text(client.number);
      case ProjectFields.taskRate:
        return Text(formatNumber(project.taskRate, context,
            clientId: project.clientId)!);
      case ProjectFields.dueDate:
        return Text(formatDate(project.dueDate, context));
      case ProjectFields.publicNotes:
        return TableTooltip(message: project.publicNotes);
      case ProjectFields.privateNotes:
        return TableTooltip(message: project.privateNotes);
      case ProjectFields.budgetedHours:
        return Text(formatNumber(project.budgetedHours, context,
            formatNumberType: FormatNumberType.double)!);
      case ProjectFields.number:
        return Text(project.number);
      case ProjectFields.customValue1:
        return Text(presentCustomField(context, project.customValue1)!);
      case ProjectFields.customValue2:
        return Text(presentCustomField(context, project.customValue2)!);
      case ProjectFields.customValue3:
        return Text(presentCustomField(context, project.customValue3)!);
      case ProjectFields.customValue4:
        return Text(presentCustomField(context, project.customValue4)!);
      case ProjectFields.documents:
        return Text('${project.documents.length}');
      case ProjectFields.totalHours:
        return Text(formatNumber(project.totalHours, context,
            formatNumberType: FormatNumberType.double)!);
    }

    return super.getField(field: field, context: context);
  }
}
