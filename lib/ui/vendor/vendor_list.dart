import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_list_item.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class VendorList extends StatelessWidget {
  const VendorList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final VendorListVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final listUIState = store.state.uiState.vendorUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final vendorList = viewModel.vendorList;

    if (isNotMobile(context) &&
        vendorList.isNotEmpty &&
        !vendorList.contains(state.vendorUIState.selectedId)) {
      viewEntityById(
          context: context,
          entityType: EntityType.vendor,
          entityId: vendorList.first);
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: !viewModel.isLoaded
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.vendorList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: viewModel.vendorList.length,
                          itemBuilder: (BuildContext context, index) {
                            final vendorId = viewModel.vendorList[index];
                            final vendor = viewModel.vendorMap[vendorId];

                            void showDialog() => showEntityActionsDialog(
                                  entities: [vendor],
                                  context: context,
                                );

                            return VendorListItem(
                              userCompany: viewModel.state.userCompany,
                              filter: viewModel.filter,
                              vendor: vendor,
                              onTap: () =>
                                  viewModel.onVendorTap(context, vendor),
                              onEntityAction: (EntityAction action) {
                                if (action == EntityAction.more) {
                                  showDialog();
                                } else {
                                  handleVendorAction(context, [vendor], action);
                                }
                              },
                              onLongPress: () async {
                                final longPressIsSelection = store
                                        .state
                                        .prefState
                                        .longPressSelectionIsDefault ??
                                    true;
                                if (longPressIsSelection && !isInMultiselect) {
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
                        ),
                ),
        ),
      ],
    );
  }
}
