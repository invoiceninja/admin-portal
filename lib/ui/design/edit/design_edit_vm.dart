import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/design/design_actions.dart';
import 'package:invoiceninja_flutter/data/models/design_model.dart';
import 'package:invoiceninja_flutter/ui/design/edit/design_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class DesignEditScreen extends StatelessWidget {
  const DesignEditScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsCustomDesignsEdit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DesignEditVM>(
      converter: (Store<AppState> store) {
        return DesignEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return DesignEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.design.id),
        );
      },
    );
  }
}

class DesignEditVM {
  DesignEditVM({
    @required this.state,
    @required this.design,
    @required this.company,
    @required this.onChanged,
    @required this.isSaving,
    @required this.origDesign,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.isLoading,
  });

  factory DesignEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final design = state.designUIState.editing;

    return DesignEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origDesign: state.designState.map[design.id],
      design: design,
      company: state.company,
      onChanged: (DesignEntity design) {
        store.dispatch(UpdateDesign(design));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(context: context, entity: DesignEntity(), force: true);
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
      onSavePressed: (BuildContext context) {
        Debouncer.runOnComplete(() {
          final design = store.state.designUIState.editing;
          final completer = snackBarCompleter<DesignEntity>(
              context, AppLocalization.of(context).savedDesign);
          store.dispatch(
              SaveDesignRequest(completer: completer, design: design));
        });
      },
    );
  }

  final DesignEntity design;
  final CompanyEntity company;
  final Function(DesignEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final DesignEntity origDesign;
  final AppState state;
}
