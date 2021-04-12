import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/kanban_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class KanbanScreen extends StatefulWidget {
  const KanbanScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final KanbanVM viewModel;

  @override
  _KanbanScreenState createState() => _KanbanScreenState();
}

class _KanbanScreenState extends State<KanbanScreen> {
  @override
  Widget build(BuildContext context) {
    final state = widget.viewModel.state;

    return Scaffold(
      drawer: isMobile(context) || state.prefState.isMenuFloated
          ? MenuDrawerBuilder()
          : null,
      endDrawer: isMobile(context) || state.prefState.isHistoryFloated
          ? HistoryDrawerBuilder()
          : null,
      appBar: AppBar(
        centerTitle: false,
        leading: isMobile(context) || state.prefState.isMenuFloated
            ? null
            : SizedBox(),
        title: ListFilter(
          key: ValueKey('__cleared_at_${state.uiState.filterClearedAt}__'),
          entityType: EntityType.kanban,
          entityIds: [],
          filter: state.uiState.filter,
          onFilterChanged: (value) {
            //store.dispatch(FilterCompany(value));
          },
        ),
      ),
      body: Placeholder(),
    );
  }
}
