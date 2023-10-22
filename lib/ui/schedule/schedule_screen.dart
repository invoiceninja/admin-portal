import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/schedule/schedule_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/schedule/schedule_list_vm.dart';
import 'package:invoiceninja_flutter/ui/schedule/schedule_presenter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

import 'schedule_screen_vm.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsSchedules';

  final ScheduleScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);

    return ListScaffold(
      entityType: EntityType.schedule,
      onHamburgerLongPress: () => store.dispatch(StartScheduleMultiselect()),
      appBarTitle: ListFilter(
        key: ValueKey('__filter_${state.scheduleListState.filterClearedAt}__'),
        entityType: EntityType.schedule,
        entityIds: viewModel.scheduleList,
        filter: state.scheduleListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterSchedules(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterSchedulesByState(state));
        },
      ),
      onCheckboxPressed: () {
        if (store.state.scheduleListState.isInMultiselect()) {
          store.dispatch(ClearScheduleMultiselect());
        } else {
          store.dispatch(StartScheduleMultiselect());
        }
      },
      body: ScheduleListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.schedule,
        tableColumns: SchedulePresenter.getAllTableFields(userCompany),
        defaultTableColumns:
            SchedulePresenter.getDefaultTableFields(userCompany),
        onSelectedSortField: (value) {
          store.dispatch(SortSchedules(value));
        },
        sortFields: [
          ScheduleFields.template,
          ScheduleFields.nextRun,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterSchedulesByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.scheduleListState.isInMultiselect()) {
            store.dispatch(ClearScheduleMultiselect());
          } else {
            store.dispatch(StartScheduleMultiselect());
          }
        },
        onSelectedCustom1: (value) =>
            store.dispatch(FilterSchedulesByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterSchedulesByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterSchedulesByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterSchedulesByCustom4(value)),
      ),
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.schedule)
          ? FloatingActionButton(
              heroTag: 'schedule_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.schedule);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization!.newSchedule,
            )
          : null,
    );
  }
}
