import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/task_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class TaskPresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      TaskFields.client,
      TaskFields.project,
      TaskFields.description,
      TaskFields.duration,
      EntityFields.state,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final state = StoreProvider.of<AppState>(context).state;
    final task = entity as TaskEntity;

    switch (field) {
      case TaskFields.client:
        return Text(state.clientState.map[task.clientId] ?? '');
      case TaskFields.project:
        return Text(state.productState.map[task.projectId] ?? '');
      case TaskFields.description:
        return Text(task.description);
      case TaskFields.duration:
        return Text('');
    }

    return super.getField(field: field, context: context);
  }
}
