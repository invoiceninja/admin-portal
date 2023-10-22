// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_contacts.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';

class ClientEditContactsScreen extends StatelessWidget {
  const ClientEditContactsScreen({Key? key, required this.viewModel})
      : super(key: key);

  final ClientEditVM viewModel;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClientEditContactsVM>(
      converter: (Store<AppState> store) {
        return ClientEditContactsVM.fromStore(store);
      },
      builder: (context, vm) {
        return ClientEditContacts(
          viewModel: vm,
          clientViewModel: viewModel,
        );
      },
    );
  }
}

class ClientEditContactsVM {
  ClientEditContactsVM({
    required this.company,
    required this.client,
    required this.contact,
    required this.onAddContactPressed,
    required this.onRemoveContactPressed,
    required this.onDoneContactPressed,
    required this.onChangedContact,
  });

  factory ClientEditContactsVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final client = state.clientUIState.editing;

    return ClientEditContactsVM(
        company: state.company,
        client: client,
        contact: state.clientUIState.editingContact,
        onAddContactPressed: () {
          final contact = ClientContactEntity();
          store.dispatch(AddContact(contact));
          store.dispatch(EditContact(contact));
        },
        onRemoveContactPressed: (index) => store.dispatch(DeleteContact(index)),
        onDoneContactPressed: (_) {
          store.dispatch(EditContact());
        },
        onChangedContact: (contact, index) {
          store.dispatch(UpdateContact(contact: contact, index: index));
        });
  }

  final CompanyEntity? company;
  final ClientEntity? client;
  final ClientContactEntity? contact;
  final Function() onAddContactPressed;
  final Function(int) onRemoveContactPressed;
  final Function(BuildContext) onDoneContactPressed;
  final Function(ClientContactEntity, int) onChangedContact;
}
