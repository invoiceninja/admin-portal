import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_list_item.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_list_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
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
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.vendorList.isEmpty
                      ? Opacity(
                          opacity: 0.5,
                          child: Center(
                            child: Text(
                              AppLocalization.of(context).noRecordsFound,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: viewModel.vendorList.length,
                          itemBuilder: (BuildContext context, index) {
                            final user = viewModel.user;
                            final vendorId = viewModel.vendorList[index];
                            final vendor = viewModel.vendorMap[vendorId];

                            void showDialog() => showEntityActionsDialog(
                                entity: vendor,
                                context: context,
                                user: user,
                                onEntityAction: viewModel.onEntityAction);

                            return VendorListItem(
                              user: viewModel.user,
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
