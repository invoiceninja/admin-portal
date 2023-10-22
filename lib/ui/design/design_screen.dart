// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/design/design_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'design_screen_vm.dart';

class DesignScreen extends StatelessWidget {
  const DesignScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsCustomDesigns';

  final DesignScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);

    return ListScaffold(
      entityType: EntityType.design,
      onHamburgerLongPress: () => store.dispatch(StartDesignMultiselect()),
      onCancelSettingsSection: kSettingsInvoiceDesign,
      appBarTitle: ListFilter(
        key: ValueKey('__filter_${state.designListState.filterClearedAt}__'),
        entityType: EntityType.design,
        entityIds: viewModel.designList,
        filter: state.designListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterDesigns(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterDesignsByState(state));
        },
      ),
      onCheckboxPressed: () {
        if (store.state.designListState.isInMultiselect()) {
          store.dispatch(ClearDesignMultiselect());
        } else {
          store.dispatch(StartDesignMultiselect());
        }
      },
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
                  entity: DesignEntity(
                      design: state.designState.cleanDesign.design),
                );
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization!.newDesign,
            )
          : null,
    );
  }
}
