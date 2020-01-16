import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/vendor_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_datatable.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_list_item.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class VendorList extends StatefulWidget {
  const VendorList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final VendorListVM viewModel;

  @override
  _VendorListState createState() => _VendorListState();
}

class _VendorListState extends State<VendorList> {
  EntityDataTableSource dataTableSource;

  @override
  void initState() {
    super.initState();

    final viewModel = widget.viewModel;

    dataTableSource = EntityDataTableSource(
        context: context,
        entityType: EntityType.vendor,
        editingId: viewModel.state.vendorUIState.editing.id,
        tableColumns: viewModel.tableColumns,
        entityList: viewModel.vendorList,
        entityMap: viewModel.vendorMap,
        entityPresenter: VendorPresenter(),
        onTap: (BaseEntity vendor) => viewModel.onVendorTap(context, vendor));
  }

  @override
  void didUpdateWidget(VendorList oldWidget) {
    super.didUpdateWidget(oldWidget);

    final viewModel = widget.viewModel;
    dataTableSource.editingId = viewModel.state.vendorUIState.editing.id;
    dataTableSource.entityList = viewModel.vendorList;
    dataTableSource.entityMap = viewModel.vendorMap;

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    dataTableSource.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final listUIState = store.state.uiState.vendorUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final vendorList = widget.viewModel.vendorList;

    if (isNotMobile(context) &&
        vendorList.isNotEmpty &&
        !state.uiState.isEditing &&
        !vendorList.contains(state.vendorUIState.selectedId)) {
      viewEntityById(
          context: context,
          entityType: EntityType.vendor,
          entityId: vendorList.first);
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: !widget.viewModel.isLoaded
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => widget.viewModel.onRefreshed(context),
                  child: widget.viewModel.vendorList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : state.prefState.moduleLayout == ModuleLayout.list
                          ? ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  ListDivider(),
                              itemCount: widget.viewModel.vendorList.length,
                              itemBuilder: (BuildContext context, index) {
                                final vendorId =
                                    widget.viewModel.vendorList[index];
                                final vendor =
                                    widget.viewModel.vendorMap[vendorId];

                                void showDialog() => showEntityActionsDialog(
                                      entities: [vendor],
                                      context: context,
                                    );

                                return VendorListItem(
                                  userCompany:
                                      widget.viewModel.state.userCompany,
                                  filter: widget.viewModel.filter,
                                  vendor: vendor,
                                  onTap: () => widget.viewModel
                                      .onVendorTap(context, vendor),
                                  onEntityAction: (EntityAction action) {
                                    if (action == EntityAction.more) {
                                      showDialog();
                                    } else {
                                      handleVendorAction(
                                          context, [vendor], action);
                                    }
                                  },
                                  onLongPress: () async {
                                    final longPressIsSelection = store
                                            .state
                                            .prefState
                                            .longPressSelectionIsDefault ??
                                        true;
                                    if (longPressIsSelection &&
                                        !isInMultiselect) {
                                      handleVendorAction(context, [vendor],
                                          EntityAction.toggleMultiselect);
                                    } else {
                                      showDialog();
                                    }
                                  },
                                  isChecked: isInMultiselect &&
                                      listUIState.isSelected(vendor.id),
                                );
                              },
                            )
                          : SingleChildScrollView(
                              child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: PaginatedDataTable(
                                onSelectAll: (value) {
                                  final vendors = widget.viewModel.vendorList
                                      .map<VendorEntity>((vendorId) =>
                                          widget.viewModel.vendorMap[vendorId])
                                      .where((vendor) =>
                                          value !=
                                          listUIState.isSelected(vendor.id))
                                      .toList();
                                  handleVendorAction(context, vendors,
                                      EntityAction.toggleMultiselect);
                                },
                                columns: [
                                  if (!listUIState.isInMultiselect())
                                    DataColumn(label: SizedBox()),
                                  ...widget.viewModel.tableColumns.map(
                                      (field) => DataColumn(
                                          label: Text(
                                              AppLocalization.of(context)
                                                  .lookup(field)),
                                          numeric:
                                              EntityPresenter.isFieldNumeric(
                                                  field),
                                          onSort: (int columnIndex,
                                                  bool ascending) =>
                                              store.dispatch(
                                                  SortVendors(field)))),
                                ],
                                source: dataTableSource,
                                header: DatatableHeader(
                                  entityType: EntityType.vendor,
                                  onClearPressed: widget
                                      .viewModel.onClearEntityFilterPressed,
                                ),
                              ),
                            )),
                ),
        ),
      ],
    );
  }
}
