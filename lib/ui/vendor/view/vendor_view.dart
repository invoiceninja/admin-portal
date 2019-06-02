import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

class VendorView extends StatefulWidget {

  const VendorView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final VendorViewVM viewModel;

  @override
  _VendorViewState createState() => new _VendorViewState();
}

class _VendorViewState extends State<VendorView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final vendor = viewModel.vendor;

    return Scaffold(
      appBar: AppBar(
        title: Text(vendor.name),
        actions: vendor.isNew
            ? []
            : [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    viewModel.onEditPressed(context);
                  },
                ),
                ActionMenuButton(
                  user: viewModel.company.user,
                  isSaving: viewModel.isSaving,
                  entity: vendor,
                  onSelected: viewModel.onActionSelected,
                ),
              ],
      ),
      body: FormCard(
        children: [
          // STARTER: widgets - do not remove comment
        ]
      ),
    );
  }
}
