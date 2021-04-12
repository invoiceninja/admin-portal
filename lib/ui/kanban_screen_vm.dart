import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_actions.dart';
import 'package:invoiceninja_flutter/ui/kanban_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

class KanbanScreenBuilder extends StatefulWidget {
  const KanbanScreenBuilder({Key key}) : super(key: key);
  static const String route = '/kanban';

  @override
  _KanbanScreenBuilderState createState() => _KanbanScreenBuilderState();
}

class _KanbanScreenBuilderState extends State<KanbanScreenBuilder> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, KanbanVM>(
      converter: KanbanVM.fromStore,
      builder: (context, viewModel) {
        final state = viewModel.state;
        final company = state.company;
        return KanbanScreen(
          viewModel: viewModel,
          key: ValueKey('__${company.id}__'),
        );
      },
    );
  }
}

class KanbanVM {
  KanbanVM({
    @required this.state,
    @required this.onStatusOrderChanged,
  });

  static KanbanVM fromStore(Store<AppState> store) {
    final state = store.state;

    return KanbanVM(
        state: state,
        onStatusOrderChanged: (context, statusId, index) {
          final localization = AppLocalization.of(context);
          final taskStatus = state.taskStatusState.get(statusId);
          final completer = snackBarCompleter<TaskStatusEntity>(
              context, localization.updatedTaskStatus);
          store.dispatch(SaveTaskStatusRequest(
              completer: completer,
              taskStatus: taskStatus.rebuild((b) => b.statusOrder = index)));
        });
  }

  final AppState state;
  final Function(BuildContext, String, int) onStatusOrderChanged;
}
