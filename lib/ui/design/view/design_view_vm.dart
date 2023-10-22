// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/design/design_screen.dart';
import 'package:invoiceninja_flutter/ui/design/view/design_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DesignViewScreen extends StatelessWidget {
  const DesignViewScreen({
    Key? key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;

  static const String route = '/$kSettings/$kSettingsCustomDesignsView';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DesignViewVM>(
      converter: (Store<AppState> store) {
        return DesignViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return DesignView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class DesignViewVM {
  DesignViewVM({
    required this.state,
    required this.design,
    required this.company,
    required this.onEntityAction,
    required this.onRefreshed,
    required this.isSaving,
    required this.onBackPressed,
    required this.isLoading,
    required this.isDirty,
  });

  factory DesignViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final design = state.designState.map[state.designUIState.selectedId] ??
        DesignEntity(id: state.designUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(LoadDesign(completer: completer, designId: design.id));
      return completer.future;
    }

    return DesignViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: design.isNew,
      design: design,
      onBackPressed: () {
        store.dispatch(UpdateCurrentRoute(DesignScreen.route));
      },
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([design], action, autoPop: true),
    );
  }

  final AppState state;
  final DesignEntity design;
  final CompanyEntity? company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
  final Function onBackPressed;
}
