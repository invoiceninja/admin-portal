// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_contacts.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit_vm.dart';

class VendorEditContactsScreen extends StatelessWidget {
  const VendorEditContactsScreen({Key? key, required this.viewModel})
      : super(key: key);

  final VendorEditVM viewModel;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VendorEditContactsVM>(
      converter: (Store<AppState> store) {
        return VendorEditContactsVM.fromStore(store);
      },
      builder: (context, vm) {
        return VendorEditContacts(
          viewModel: vm,
          vendorViewModel: viewModel,
        );
      },
    );
  }
}

class VendorEditContactsVM {
  VendorEditContactsVM({
    required this.company,
    required this.vendor,
    required this.contact,
    required this.onAddContactPressed,
    required this.onRemoveContactPressed,
    required this.onDoneContactPressed,
    required this.onChangedContact,
  });

  factory VendorEditContactsVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final vendor = state.vendorUIState.editing;

    return VendorEditContactsVM(
        company: state.company,
        vendor: vendor,
        contact: state.vendorUIState.editingContact,
        onAddContactPressed: () {
          final contact = VendorContactEntity();
          store.dispatch(AddVendorContact(contact));
          store.dispatch(EditVendorContact(contact));
        },
        onRemoveContactPressed: (index) =>
            store.dispatch(DeleteVendorContact(index)),
        onDoneContactPressed: () => store.dispatch(EditVendorContact()),
        onChangedContact: (contact, index) {
          store.dispatch(UpdateVendorContact(contact: contact, index: index));
        });
  }

  final CompanyEntity? company;
  final VendorEntity? vendor;
  final VendorContactEntity? contact;
  final Function() onAddContactPressed;
  final Function(int) onRemoveContactPressed;
  final Function onDoneContactPressed;
  final Function(VendorContactEntity, int) onChangedContact;
}
