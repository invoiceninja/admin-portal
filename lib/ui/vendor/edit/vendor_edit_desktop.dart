// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_address.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_contacts_vm.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_details.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_notes.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_settings.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_vm.dart';

class VendorEditDesktop extends StatelessWidget {
  const VendorEditDesktop({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final VendorEditVM viewModel;

  @override
  Widget build(BuildContext context) {
    return ScrollableListView(
      primary: true,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FocusTraversalGroup(
                child: Column(
                  children: [
                    VendorEditDetails(
                      viewModel: viewModel,
                    ),
                    VendorEditNotes(
                      viewModel: viewModel,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FocusTraversalGroup(
                child: Column(
                  children: [
                    VendorEditContactsScreen(
                      viewModel: viewModel,
                    ),
                    VendorEditSettings(
                      viewModel: viewModel,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FocusTraversalGroup(
                child: Column(
                  children: [
                    VendorEditAddress(
                      viewModel: viewModel,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: kMobileDialogPadding,
        ),
      ],
    );
  }
}
