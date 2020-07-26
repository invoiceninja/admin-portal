import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/design/design_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'design_screen_vm.dart';

class DesignScreen extends StatelessWidget {
  const DesignScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsCustomDesigns';

  final DesignScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.designUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return ListScaffold(
      entityType: EntityType.design,
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.designList.length,
      showCheckbox: isInMultiselect,
      onHamburgerLongPress: () => store.dispatch(StartDesignMultiselect()),
      onCheckboxChanged: (value) {
        final designs = viewModel.designList
            .map<DesignEntity>((designId) => viewModel.designMap[designId])
            .where((design) => value != listUIState.isSelected(design.id))
            .toList();

        handleDesignAction(context, designs, EntityAction.toggleMultiselect);
      },
      appBarTitle: ListFilter(
        entityType: EntityType.design,
        entityIds: viewModel.designList,
        filter: state.designListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterDesigns(value));
        },
      ),
      appBarActions: [
        if (viewModel.isInMultiselect)
          SaveCancelButtons(
            saveLabel: localization.done,
            onSavePressed: listUIState.selectedIds.isEmpty
                ? null
                : (context) async {
                    final designs = listUIState.selectedIds
                        .map<DesignEntity>(
                            (designId) => viewModel.designMap[designId])
                        .toList();

                    await showEntityActionsDialog(
                      entities: designs,
                      context: context,
                      multiselect: true,
                      completer: Completer<Null>()
                        ..future.then<dynamic>(
                            (_) => store.dispatch(ClearDesignMultiselect())),
                    );
                  },
            onCancelPressed: (context) =>
                store.dispatch(ClearDesignMultiselect()),
          ),
      ],
      body: DesignListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.design,
        onSelectedSortField: (value) {
          store.dispatch(SortDesigns(value));
        },
        sortFields: [
          DesignFields.name,
          DesignFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterDesignsByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.designListState.isInMultiselect()) {
            store.dispatch(ClearDesignMultiselect());
          } else {
            store.dispatch(StartDesignMultiselect());
          }
        },
        onSelectedCustom1: (value) =>
            store.dispatch(FilterDesignsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterDesignsByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterDesignsByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterDesignsByCustom4(value)),
      ),
      floatingActionButton: state.prefState.isMobile && userCompany.isAdmin
          ? FloatingActionButton(
              heroTag: 'design_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntity(
                  context: context,
                  entity: DesignEntity(
                      design: state.designState.cleanDesign.design),
                );
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization.newDesign,
            )
          : null,
    );
  }
}
