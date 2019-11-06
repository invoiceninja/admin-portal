import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/pdf.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewInvoiceList implements PersistUI {
  ViewInvoiceList({this.context, this.force = false});

  final BuildContext context;
  final bool force;
}

class ViewInvoice implements PersistUI {
  ViewInvoice({this.invoiceId, this.context, this.force = false});

  final String invoiceId;
  final BuildContext context;
  final bool force;
}

class EditInvoice implements PersistUI {
  EditInvoice(
      {this.invoice,
      this.context,
      this.completer,
      this.invoiceItem,
      this.force = false});

  final InvoiceEntity invoice;
  final InvoiceItemEntity invoiceItem;
  final BuildContext context;
  final Completer completer;
  final bool force;
}

class ShowEmailInvoice {
  ShowEmailInvoice({this.invoice, this.context, this.completer});

  final InvoiceEntity invoice;
  final BuildContext context;
  final Completer completer;
}

class EditInvoiceItem implements PersistUI {
  EditInvoiceItem([this.invoiceItem]);

  final InvoiceItemEntity invoiceItem;
}

class UpdateInvoice implements PersistUI {
  UpdateInvoice(this.invoice);

  final InvoiceEntity invoice;
}

class LoadInvoice {
  LoadInvoice({this.completer, this.invoiceId});

  final Completer completer;
  final String invoiceId;
}

class LoadInvoices {
  LoadInvoices({this.completer, this.force = false});

  final Completer completer;
  final bool force;
}

class LoadInvoiceRequest implements StartLoading {}

class LoadInvoiceFailure implements StopLoading {
  LoadInvoiceFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadInvoiceFailure{error: $error}';
  }
}

class LoadInvoiceSuccess implements StopLoading, PersistData {
  LoadInvoiceSuccess(this.invoice);

  final InvoiceEntity invoice;

  @override
  String toString() {
    return 'LoadInvoiceSuccess{invoice: $invoice}';
  }
}

class LoadInvoicesRequest implements StartLoading {}

class LoadInvoicesFailure implements StopLoading {
  LoadInvoicesFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadInvoicesFailure{error: $error}';
  }
}

class LoadInvoicesSuccess implements StopLoading, PersistData {
  LoadInvoicesSuccess(this.invoices);

  final BuiltList<InvoiceEntity> invoices;

  @override
  String toString() {
    return 'LoadInvoicesSuccess{invoices: $invoices}';
  }
}

class AddInvoiceContact implements PersistUI {
  AddInvoiceContact({this.contact, this.invitation});

  final ContactEntity contact;
  final InvitationEntity invitation;
}

class RemoveInvoiceContact implements PersistUI {
  RemoveInvoiceContact({this.invitation});

  final InvitationEntity invitation;
}

class AddInvoiceItem implements PersistUI {
  AddInvoiceItem({this.invoiceItem});

  final InvoiceItemEntity invoiceItem;
}

class AddInvoiceItems implements PersistUI {
  AddInvoiceItems(this.lineItems);

  final List<InvoiceItemEntity> lineItems;
}

class UpdateInvoiceItem implements PersistUI {
  UpdateInvoiceItem({this.index, this.invoiceItem});

  final int index;
  final InvoiceItemEntity invoiceItem;
}

class DeleteInvoiceItem implements PersistUI {
  DeleteInvoiceItem(this.index);

  final int index;
}

class SaveInvoiceRequest implements StartSaving {
  SaveInvoiceRequest({this.completer, this.invoice});

  final Completer completer;
  final InvoiceEntity invoice;
}

class SaveInvoiceSuccess implements StopSaving, PersistData, PersistUI {
  SaveInvoiceSuccess(this.invoice);

  final InvoiceEntity invoice;
}

class AddInvoiceSuccess implements StopSaving, PersistData, PersistUI {
  AddInvoiceSuccess(this.invoice);

  final InvoiceEntity invoice;
}

class SaveInvoiceFailure implements StopSaving {
  SaveInvoiceFailure(this.error);

  final Object error;
}

class EmailInvoiceRequest implements StartSaving {
  EmailInvoiceRequest(
      {this.completer, this.invoiceId, this.template, this.subject, this.body});

  final Completer completer;
  final String invoiceId;
  final EmailTemplate template;
  final String subject;
  final String body;
}

class EmailInvoiceSuccess implements StopSaving, PersistData {}

class EmailInvoiceFailure implements StopSaving {
  EmailInvoiceFailure(this.error);

  final dynamic error;
}

class MarkSentInvoiceRequest implements StartSaving {
  MarkSentInvoiceRequest(this.completer, this.invoiceId);

  final Completer completer;
  final String invoiceId;
}

class MarkSentInvoiceSuccess implements StopSaving, PersistData {
  MarkSentInvoiceSuccess(this.invoice);

  final InvoiceEntity invoice;
}

class MarkSentInvoiceFailure implements StopSaving {
  MarkSentInvoiceFailure(this.invoice);

  final InvoiceEntity invoice;
}

class ArchiveInvoiceRequest implements StartSaving {
  ArchiveInvoiceRequest(this.completer, this.invoiceIds);

  final Completer completer;
  final List<String> invoiceIds;
}

class ArchiveInvoiceSuccess implements StopSaving, PersistData {
  ArchiveInvoiceSuccess(this.invoices);

  final List<InvoiceEntity> invoices;
}

class ArchiveInvoiceFailure implements StopSaving {
  ArchiveInvoiceFailure(this.invoices);

  final List<InvoiceEntity> invoices;
}

class DeleteInvoiceRequest implements StartSaving {
  DeleteInvoiceRequest(this.completer, this.invoiceIds);

  final Completer completer;
  final List<String> invoiceIds;
}

class DeleteInvoiceSuccess implements StopSaving, PersistData {
  DeleteInvoiceSuccess(this.invoices);

  final List<InvoiceEntity> invoices;
}

class DeleteInvoiceFailure implements StopSaving {
  DeleteInvoiceFailure(this.invoices);

  final List<InvoiceEntity> invoices;
}

class RestoreInvoiceRequest implements StartSaving {
  RestoreInvoiceRequest(this.completer, this.invoiceIds);

  final Completer completer;
  final List<String> invoiceIds;
}

class RestoreInvoiceSuccess implements StopSaving, PersistData {
  RestoreInvoiceSuccess(this.invoices);

  final List<InvoiceEntity> invoices;
}

class RestoreInvoiceFailure implements StopSaving {
  RestoreInvoiceFailure(this.invoices);

  final List<InvoiceEntity> invoices;
}

class FilterInvoices {
  FilterInvoices(this.filter);

  final String filter;
}

class SortInvoices implements PersistUI {
  SortInvoices(this.field);

  final String field;
}

class FilterInvoicesByState implements PersistUI {
  FilterInvoicesByState(this.state);

  final EntityState state;
}

class FilterInvoicesByStatus implements PersistUI {
  FilterInvoicesByStatus(this.status);

  final EntityStatus status;
}

class FilterInvoicesByEntity implements PersistUI {
  FilterInvoicesByEntity({this.entityId, this.entityType});

  final String entityId;
  final EntityType entityType;
}

class FilterInvoiceDropdown {
  FilterInvoiceDropdown(this.filter);

  final String filter;
}

class FilterInvoicesByCustom1 implements PersistUI {
  FilterInvoicesByCustom1(this.value);

  final String value;
}

class FilterInvoicesByCustom2 implements PersistUI {
  FilterInvoicesByCustom2(this.value);

  final String value;
}

void handleInvoiceAction(BuildContext context, List<BaseEntity> invoices,
    EntityAction action) async {
  assert(
      [
            EntityAction.restore,
            EntityAction.archive,
            EntityAction.delete,
            EntityAction.toggleMultiselect
          ].contains(action) ||
          invoices.length == 1,
      'Cannot perform this action on more than one invoice');

  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final CompanyEntity company = state.selectedCompany;
  final localization = AppLocalization.of(context);
  final invoice = invoices.first as InvoiceEntity;
  final invoiceIds = invoices.map((invoice) => invoice.id).toList();

  switch (action) {
    case EntityAction.edit:
      store.dispatch(EditInvoice(context: context, invoice: invoice));
      break;
    case EntityAction.pdf:
      viewPdf(invoice, context);
      break;
    case EntityAction.clientPortal:
      if (await canLaunch(invoice.invitationSilentLink)) {
        await launch(invoice.invitationSilentLink,
            forceSafariVC: false, forceWebView: false);
      }
      break;
    case EntityAction.markSent:
      store.dispatch(MarkSentInvoiceRequest(
          snackBarCompleter(context, localization.markedInvoiceAsSent),
          invoice.id));
      break;
    case EntityAction.sendEmail:
      store.dispatch(ShowEmailInvoice(
          completer: snackBarCompleter(context, localization.emailedInvoice),
          invoice: invoice,
          context: context));
      break;
    case EntityAction.cloneToInvoice:
      store.dispatch(EditInvoice(context: context, invoice: invoice.clone));
      break;
    case EntityAction.cloneToQuote:
      store.dispatch(
          EditQuote(context: context, quote: invoice.clone)); // TODO fix this
      break;
    case EntityAction.enterPayment:
      store.dispatch(EditPayment(
          context: context, payment: invoice.createPayment(company)));
      break;
    case EntityAction.restore:
      store.dispatch(RestoreInvoiceRequest(
          snackBarCompleter(context, localization.restoredInvoice),
          invoiceIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveInvoiceRequest(
          snackBarCompleter(context, localization.archivedInvoice),
          invoiceIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteInvoiceRequest(
          snackBarCompleter(context, localization.deletedInvoice), invoiceIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.invoiceListState.isInMultiselect()) {
        store.dispatch(StartInvoiceMultiselect(context: context));
      }

      if (invoices.isEmpty) {
        break;
      }

      for (final invoice in invoices) {
        if (!store.state.invoiceListState.isSelected(invoice.id)) {
          store.dispatch(
              AddToInvoiceMultiselect(context: context, entity: invoice));
        } else {
          store.dispatch(
              RemoveFromInvoiceMultiselect(context: context, entity: invoice));
        }
      }
      break;
  }
}

class StartInvoiceMultiselect {
  StartInvoiceMultiselect({@required this.context});

  final BuildContext context;
}

class AddToInvoiceMultiselect {
  AddToInvoiceMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class RemoveFromInvoiceMultiselect {
  RemoveFromInvoiceMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class ClearInvoiceMultiselect {
  ClearInvoiceMultiselect({@required this.context});

  final BuildContext context;
}
