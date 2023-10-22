// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/bottom_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view_documents.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view_overview.dart';
import 'package:invoiceninja_flutter/ui/project/view/project_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProjectView extends StatefulWidget {
  const ProjectView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
    required this.tabIndex,
  }) : super(key: key);

  final ProjectViewVM viewModel;
  final bool isFilter;
  final int tabIndex;

  @override
  _ProjectViewState createState() => new _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();

    final state = widget.viewModel.state;
    _controller = TabController(
        vsync: this,
        length: 2,
        initialIndex: widget.isFilter ? 0 : state.projectUIState.tabIndex);
    _controller!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (widget.isFilter) {
      return;
    }

    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateProjectTab(tabIndex: _controller!.index));
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.tabIndex != widget.tabIndex) {
      _controller!.index = widget.tabIndex;
    }
  }

  @override
  void dispose() {
    _controller!.removeListener(_onTabChanged);
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final project = viewModel.project;
    final state = viewModel.state;
    final company = state.company;
    final localization = AppLocalization.of(context);
    final documents = project.documents;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: project,
      appBarBottom: company.isModuleEnabled(EntityType.document)
          ? TabBar(
              controller: _controller,
              isScrollable: false,
              tabs: [
                Tab(
                  text: localization!.overview,
                ),
                Tab(
                  text: documents.isEmpty
                      ? localization.documents
                      : '${localization.documents} (${documents.length})',
                ),
              ],
            )
          : null,
      body: Builder(builder: (context) {
        return Column(
          children: <Widget>[
            Expanded(
              child: company.isModuleEnabled(EntityType.document)
                  ? TabBarView(
                      controller: _controller,
                      children: <Widget>[
                        RefreshIndicator(
                          onRefresh: () => viewModel.onRefreshed(context),
                          child: ProjectOverview(
                            viewModel: viewModel,
                            isFilter: widget.isFilter,
                          ),
                        ),
                        RefreshIndicator(
                          onRefresh: () => viewModel.onRefreshed(context),
                          child: ProjectViewDocuments(
                            viewModel: viewModel,
                            key: ValueKey(viewModel.project.id),
                          ),
                        ),
                      ],
                    )
                  : RefreshIndicator(
                      onRefresh: () => viewModel.onRefreshed(context),
                      child: ProjectOverview(
                        viewModel: viewModel,
                        isFilter: widget.isFilter,
                      ),
                    ),
            ),
            BottomButtons(
              entity: project,
              action1: EntityAction.newTask,
              action2: EntityAction.invoiceProject,
            ),
          ],
        );
      }),
    );
  }
}
