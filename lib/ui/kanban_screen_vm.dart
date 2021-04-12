import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/kanban_screen.dart';
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
  });

  static KanbanVM fromStore(Store<AppState> store) {
    final state = store.state;

    return KanbanVM(
      state: state,
    );
  }

  final AppState state;
}
