import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
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

  void _showMenu(BuildContext context, VendorEntity vendor) async {
    if (vendor == null) {
      return;
    }

    final user = viewModel.user;
    final message = await showDialog<String>(
        context: context,
        builder: (BuildContext dialogContext) => SimpleDialog(
                children: vendor
                    .getEntityActions(user: user, includeEdit: true)
                    .map((entityAction) {
              if (entityAction == null) {
                return Divider();
              } else {
                return ListTile(
                  leading: Icon(getEntityActionIcon(entityAction)),
                  title: Text(AppLocalization.of(context)
                      .lookup(entityAction.toString())),
                  onTap: () {
                    Navigator.of(dialogContext).pop();
                    viewModel.onEntityAction(context, vendor, entityAction);
                  },
                );
              }
            }).toList()));

    if (message != null) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: SnackBarRow(
        message: message,
      )));
    }
  }

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
                            final vendorId = viewModel.vendorList[index];
                            final vendor = viewModel.vendorMap[vendorId];
                            return VendorListItem(
                              user: viewModel.user,
                              filter: viewModel.filter,
                              vendor: vendor,
                              onTap: () =>
                                  viewModel.onVendorTap(context, vendor),
                              onEntityAction: (EntityAction action) {
                                if (action == EntityAction.more) {
                                  _showMenu(context, vendor);
                                } else {
                                  viewModel.onEntityAction(
                                      context, vendor, action);
                                }
                              },
                              onLongPress: () => _showMenu(context, vendor),
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }
}
