import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/ui/design/design_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_datatable.dart';
import 'package:invoiceninja_flutter/ui/design/design_list_item.dart';
import 'package:invoiceninja_flutter/ui/design/design_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DesignList extends StatefulWidget {
  const DesignList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DesignListVM viewModel;

  @override
  _DesignListState createState() => _DesignListState();
}

class _DesignListState extends State<DesignList> {
  EntityDataTableSource dataTableSource;

  @override
  void initState() {
    super.initState();

    final viewModel = widget.viewModel;

    dataTableSource = EntityDataTableSource(
        context: context,
        entityType: EntityType.design,
        editingId: viewModel.state.designUIState.editing.id,
        tableColumns: viewModel.tableColumns,
        entityList: viewModel.designList,
        entityMap: viewModel.designMap,
        entityPresenter: DesignPresenter(),
        onTap: (BaseEntity design) => viewModel.onDesignTap(context, design));
  }

  @override
  void didUpdateWidget(DesignList oldWidget) {
    super.didUpdateWidget(oldWidget);

    final viewModel = widget.viewModel;
    dataTableSource.editingId = viewModel.state.designUIState.editing.id;
    dataTableSource.entityList = viewModel.designList;
    dataTableSource.entityMap = viewModel.designMap;

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    dataTableSource.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final listUIState = state.uiState.designUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final isList = state.prefState.moduleLayout == ModuleLayout.list;
    final designList = viewModel.designList;

    if (!viewModel.isLoaded) {
      return viewModel.isLoading ? LoadingIndicator() : SizedBox();
    } else if (viewModel.designMap.isEmpty) {
      return HelpText(AppLocalization.of(context).noRecordsFound);
    }

    if (state.shouldSelectEntity(
        entityType: EntityType.design, hasRecords: designList.isNotEmpty)) {
      viewEntityById(
        context: context,
        entityType: EntityType.design,
        entityId: designList.isEmpty ? null : designList.first,
      );
    }

    final listOrTable = () {
      if (isList) {
        return ListView.separated(
            separatorBuilder: (context, index) => ListDivider(),
            itemCount: viewModel.designList.length,
            itemBuilder: (BuildContext context, index) {
              final designId = viewModel.designList[index];
              final design = viewModel.designMap[designId];

              return DesignListItem(
                user: viewModel.state.user,
                filter: viewModel.filter,
                design: design,
                onEntityAction: (EntityAction action) {
                  if (action == EntityAction.more) {
                    showEntityActionsDialog(
                      entities: [design],
                      context: context,
                    );
                  } else {
                    handleDesignAction(context, [design], action);
                  }
                },
                onTap: () => viewModel.onDesignTap(context, design),
                onLongPress: () async {
                  final longPressIsSelection =
                      state.prefState.longPressSelectionIsDefault ?? true;
                  if (longPressIsSelection && !isInMultiselect) {
                    handleDesignAction(
                        context, [design], EntityAction.toggleMultiselect);
                  } else {
                    showEntityActionsDialog(
                      entities: [design],
                      context: context,
                    );
                  }
                },
                isChecked: isInMultiselect && listUIState.isSelected(design.id),
              );
            });
      } else {
        return SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(12),
          child: PaginatedDataTable(
            onSelectAll: (value) {
              final designs = viewModel.designList
                  .map<DesignEntity>(
                      (designId) => viewModel.designMap[designId])
                  .where((design) => value != listUIState.isSelected(design.id))
                  .toList();
              handleDesignAction(
                  context, designs, EntityAction.toggleMultiselect);
            },
            columns: [
              if (!listUIState.isInMultiselect()) DataColumn(label: SizedBox()),
              ...viewModel.tableColumns.map((field) => DataColumn(
                  label: Text(AppLocalization.of(context).lookup(field)),
                  numeric: EntityPresenter.isFieldNumeric(field),
                  onSort: (int columnIndex, bool ascending) =>
                      store.dispatch(SortDesigns(field)))),
            ],
            source: dataTableSource,
            header: DatatableHeader(
              entityType: EntityType.design,
              onClearPressed: viewModel.onClearEntityFilterPressed,
            ),
          ),
        ));
      }
    };

    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: listOrTable(),
    );
  }
}
