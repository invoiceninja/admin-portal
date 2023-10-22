// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'project_screen.dart';

class ProjectScreenBuilder extends StatelessWidget {
  const ProjectScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProjectScreenVM>(
      converter: ProjectScreenVM.fromStore,
      builder: (context, vm) {
        return ProjectScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class ProjectScreenVM {
  ProjectScreenVM({
    required this.isInMultiselect,
    required this.projectList,
    required this.userCompany,
    required this.projectMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> projectList;
  final BuiltMap<String, ProjectEntity> projectMap;

  static ProjectScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return ProjectScreenVM(
      projectMap: state.projectState.map,
      projectList: memoizedFilteredProjectList(
        state.getUISelection(EntityType.project),
        state.projectState.map,
        state.projectState.list,
        state.projectListState,
        state.clientState.map,
        state.userState.map,
      ),
      userCompany: state.userCompany,
      isInMultiselect: state.projectListState.isInMultiselect(),
    );
  }
}
