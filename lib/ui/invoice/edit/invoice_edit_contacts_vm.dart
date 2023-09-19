// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_contacts.dart';

class InvoiceEditContactsScreen extends StatelessWidget {
  const InvoiceEditContactsScreen({Key? key, required this.entityType})
      : super(key: key);

  final EntityType? entityType;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceEditContactsVM>(
      converter: (Store<AppState> store) {
        return InvoiceEditContactsVM.fromStore(store, entityType);
      },
      builder: (context, viewModel) {
        return InvoiceEditContacts(
          viewModel: viewModel,
        );
      },
    );
  }
}

class EntityEditContactsVM {
  EntityEditContactsVM({
    required this.state,
    required this.company,
    required this.invoice,
    required this.client,
    required this.vendor,
    required this.onAddClientContact,
    required this.onAddVendorContact,
    required this.onRemoveContact,
  });

  final AppState state;
  final CompanyEntity? company;
  final InvoiceEntity? invoice;
  final ClientEntity? client;
  final VendorEntity? vendor;
  final Function(ClientContactEntity) onAddClientContact;
  final Function(VendorContactEntity) onAddVendorContact;
  final Function(InvitationEntity) onRemoveContact;
}

class InvoiceEditContactsVM extends EntityEditContactsVM {
  InvoiceEditContactsVM({
    required AppState state,
    required CompanyEntity? company,
    required InvoiceEntity? invoice,
    required ClientEntity? client,
    required VendorEntity? vendor,
    required Function(ClientContactEntity) onAddClientContact,
    required Function(VendorContactEntity) onAddVendorContact,
    required Function(InvitationEntity) onRemoveContact,
  }) : super(
          state: state,
          company: company,
          invoice: invoice,
          client: client,
          vendor: vendor,
          onAddClientContact: onAddClientContact,
          onAddVendorContact: onAddVendorContact,
          onRemoveContact: onRemoveContact,
        );

  factory InvoiceEditContactsVM.fromStore(
      Store<AppState> store, EntityType? entityType) {
    final AppState state = store.state;

    BaseEntity? entity;
    if (entityType == EntityType.invoice) {
      entity = state.invoiceUIState.editing;
    } else if (entityType == EntityType.quote) {
      entity = state.quoteUIState.editing;
    } else if (entityType == EntityType.credit) {
      entity = state.creditUIState.editing;
    } else if (entityType == EntityType.recurringInvoice) {
      entity = state.recurringInvoiceUIState.editing;
    } else if (entityType == EntityType.purchaseOrder) {
      entity = state.purchaseOrderUIState.editing;
    } else {
      print(
          'ERROR: entityType $entityType not handled in invoice_edit_contacts_vm');
    }

    return InvoiceEditContactsVM(
      state: state,
      company: state.company,
      invoice: entity as InvoiceEntity?,
      client: state.clientState.map[(entity as BelongsToClient).clientId],
      vendor: state.vendorState.map[(entity as BelongsToVendor).vendorId],
      onAddClientContact: (ClientContactEntity contact) {
        InvitationEntity? invitation;
        // prevent un-checking/checking a contact from creating a new invitation
        if (entity!.isOld) {
          final origEntity =
              state.getEntityMap(entityType)![entity.id] as InvoiceEntity;
          invitation = origEntity.getInvitationForClientContact(contact);
        }

        if (entity.entityType == EntityType.quote) {
          store.dispatch(
              AddQuoteContact(contact: contact, invitation: invitation));
        } else if (entity.entityType == EntityType.credit) {
          store.dispatch(
              AddCreditContact(contact: contact, invitation: invitation));
        } else if (entity.entityType == EntityType.recurringInvoice) {
          store.dispatch(AddRecurringInvoiceContact(
              contact: contact, invitation: invitation));
        } else if (entity.entityType == EntityType.invoice) {
          store.dispatch(
              AddInvoiceContact(contact: contact, invitation: invitation));
        } else {
          print(
              'ERROR: entityType $entityType not handled in invoice_edit_contacts_vm');
        }
      },
      onAddVendorContact: (VendorContactEntity contact) {
        InvitationEntity? invitation;
        // prevent un-checking/checking a contact from creating a new invitation
        if (entity!.isOld) {
          final origEntity =
              state.getEntityMap(entityType)![entity.id] as InvoiceEntity;
          invitation = origEntity.getInvitationForVendorContact(contact);
        }

        if (entity.entityType == EntityType.purchaseOrder) {
          store.dispatch(AddPurchaseOrderContact(
              contact: contact, invitation: invitation));
        } else {
          print(
              'ERROR: entityType $entityType not handled in invoice_edit_contacts_vm');
        }
      },
      onRemoveContact: (InvitationEntity invitation) {
        if (entity!.entityType == EntityType.quote) {
          store.dispatch(RemoveQuoteContact(invitation: invitation));
        } else if (entity.entityType == EntityType.credit) {
          store.dispatch(RemoveCreditContact(invitation: invitation));
        } else if (entity.entityType == EntityType.recurringInvoice) {
          store.dispatch(RemoveRecurringInvoiceContact(invitation: invitation));
        } else if (entity.entityType == EntityType.invoice) {
          store.dispatch(RemoveInvoiceContact(invitation: invitation));
        } else if (entity.entityType == EntityType.purchaseOrder) {
          store.dispatch(RemovePurchaseOrderContact(invitation: invitation));
        } else {
          print(
              'ERROR: entityType $entityType not handled in invoice_edit_contacts_vm');
        }
      },
    );
  }
}
