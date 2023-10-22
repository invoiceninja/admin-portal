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
import 'package:invoiceninja_flutter/redux/design/design_actions.dart';
import 'package:invoiceninja_flutter/redux/design/design_selectors.dart';
import 'design_screen.dart';

class DesignScreenBuilder extends StatelessWidget {
  const DesignScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DesignScreenVM>(
      converter: DesignScreenVM.fromStore,
      builder: (context, vm) {
        return DesignScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class DesignScreenVM {
  DesignScreenVM({
    required this.isInMultiselect,
    required this.designList,
    required this.userCompany,
    required this.onEntityAction,
    required this.designMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> designList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String, DesignEntity> designMap;

  static DesignScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return DesignScreenVM(
      designMap: state.designState.map,
      designList: memoizedFilteredDesignList(
          state.designState.map, state.designState.list, state.designListState),
      userCompany: state.userCompany,
      isInMultiselect: state.designListState.isInMultiselect(),
      onEntityAction: (BuildContext context, List<BaseEntity> designs,
              EntityAction action) =>
          handleDesignAction(context, designs, action),
    );
  }
}
