import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_list_item.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class VendorList extends StatelessWidget {
  const VendorList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final VendorListVM viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: !viewModel.isLoaded
              ? (viewModel.isLoading ? LoadingIndicator() : SizedBox())
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.vendorList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: viewModel.vendorList.length,
                          itemBuilder: (BuildContext context, index) {
                            final userCompany = viewModel.state.userCompany;
                            final vendorId = viewModel.vendorList[index];
                            final vendor = viewModel.vendorMap[vendorId];

                            void showDialog() => showEntityActionsDialog(
                                entities: [vendor],
                                context: context,
                                userCompany: userCompany,
                                onEntityAction: viewModel.onEntityAction);

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
                                  viewModel.onEntityAction(
                                      context, vendor, action);
                                }
                              },
                              onLongPress: () => showDialog(),
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }
}
