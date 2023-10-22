// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_billing_address.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_contacts_vm.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_details.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_notes.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_settings.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_shipping_address.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';

class ClientEditDesktop extends StatelessWidget {
  const ClientEditDesktop({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final ClientEditVM viewModel;

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
                    ClientEditDetails(
                      viewModel: viewModel,
                    ),
                    ClientEditNotes(
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
                    ClientEditContactsScreen(
                      viewModel: viewModel,
                    ),
                    ClientEditSettings(
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
                    ClientEditBillingAddress(
                      viewModel: viewModel,
                    ),
                    ClientEditShippingAddress(
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
