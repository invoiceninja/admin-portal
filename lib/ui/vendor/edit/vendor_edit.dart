import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_address.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_contacts_vm.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_details.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_notes.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_icon_button.dart';

class VendorEdit extends StatefulWidget {
  const VendorEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final VendorEditVM viewModel;

  @override
  _VendorEditState createState() => _VendorEditState();
}

class _VendorEditState extends State<VendorEdit>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final vendor = viewModel.vendor;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              vendor.isNew ? localization.newVendor : localization.editVendor),
          actions: <Widget>[
            ActionIconButton(
              icon: Icons.cloud_upload,
              tooltip: localization.save,
              isVisible: !vendor.isDeleted,
              isDirty: vendor.isNew || vendor != viewModel.origVendor,
              isSaving: viewModel.isSaving,
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }
                viewModel.onSavePressed(context);
              },
            )
          ],
          bottom: TabBar(
            controller: _controller,
            //isScrollable: true,
            tabs: [
              Tab(
                text: localization.details,
              ),
              Tab(
                text: localization.contacts,
              ),
              Tab(
                text: localization.notes,
              ),
              Tab(
                text: localization.address,
              ),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: TabBarView(
            controller: _controller,
            children: <Widget>[
              VendorEditDetails(
                viewModel: widget.viewModel,
              ),
              VendorEditContactsScreen(),
              VendorEditNotes(
                viewModel: widget.viewModel,
              ),
              VendorEditAddress(
                viewModel: widget.viewModel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
