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
import 'package:invoiceninja_flutter/ui/app/responsive_padding.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_email_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/pdf.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
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

class AddInvoiceItem implements PersistUI {
  AddInvoiceItem({this.invoiceItem});

  final InvoiceItemEntity invoiceItem;
}

class AddInvoiceItems implements PersistUI {
  AddInvoiceItems(this.invoiceItems);

  final List<InvoiceItemEntity> invoiceItems;
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
  ArchiveInvoiceRequest(this.completer, this.invoiceId);

  final Completer completer;
  final String invoiceId;
}

class ArchiveInvoiceSuccess implements StopSaving, PersistData {
  ArchiveInvoiceSuccess(this.invoice);

  final InvoiceEntity invoice;
}

class ArchiveInvoiceFailure implements StopSaving {
  ArchiveInvoiceFailure(this.invoice);

  final InvoiceEntity invoice;
}

class DeleteInvoiceRequest implements StartSaving {
  DeleteInvoiceRequest(this.completer, this.invoiceId);

  final Completer completer;
  final String invoiceId;
}

class DeleteInvoiceSuccess implements StopSaving, PersistData {
  DeleteInvoiceSuccess(this.invoice);

  final InvoiceEntity invoice;
}

class DeleteInvoiceFailure implements StopSaving {
  DeleteInvoiceFailure(this.invoice);

  final InvoiceEntity invoice;
}

class RestoreInvoiceRequest implements StartSaving {
  RestoreInvoiceRequest(this.completer, this.invoiceId);

  final Completer completer;
  final String invoiceId;
}

class RestoreInvoiceSuccess implements StopSaving, PersistData {
  RestoreInvoiceSuccess(this.invoice);

  final InvoiceEntity invoice;
}

class RestoreInvoiceFailure implements StopSaving {
  RestoreInvoiceFailure(this.invoice);

  final InvoiceEntity invoice;
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

void handleInvoiceAction(BuildContext context, List<InvoiceEntity> invoices,
    EntityAction action) async {
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final CompanyEntity company = state.selectedCompany;
  final localization = AppLocalization.of(context);

  switch (action) {
    case EntityAction.edit:
      store.dispatch(EditInvoice(context: context, invoice: invoices[0]));
      break;
    case EntityAction.pdf:
      viewPdf(invoices[0], context);
      break;
    case EntityAction.clientPortal:
      if (await canLaunch(invoices[0].invitationSilentLink)) {
        await launch(invoices[0].invitationSilentLink,
            forceSafariVC: false, forceWebView: false);
      }
      break;
    case EntityAction.markSent:
      store.dispatch(MarkSentInvoiceRequest(
          snackBarCompleter(context, localization.markedInvoiceAsSent),
          invoices[0].id));
      break;
    case EntityAction.sendEmail:
      if (isMobile(context)) {
        store.dispatch(ShowEmailInvoice(
            completer: snackBarCompleter(context, localization.emailedInvoice),
            invoice: invoices[0],
            context: context));
      } else {
        showDialog<ResponsivePadding>(
            context: context,
            builder: (BuildContext context) {
              return ResponsivePadding(child: InvoiceEmailScreen());
            });
      }
      break;
    case EntityAction.cloneToInvoice:
      store.dispatch(
          EditInvoice(context: context, invoice: invoices[0].cloneToInvoice));
      break;
    case EntityAction.cloneToQuote:
      store.dispatch(
          EditQuote(context: context, quote: invoices[0].cloneToQuote));
      break;
    case EntityAction.enterPayment:
      store.dispatch(EditPayment(
          context: context, payment: invoices[0].createPayment(company)));
      break;
    case EntityAction.restore:
      store.dispatch(RestoreInvoiceRequest(
          snackBarCompleter(context, localization.restoredInvoice),
          invoices[0].id));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveInvoiceRequest(
          snackBarCompleter(context, localization.archivedInvoice),
          invoices[0].id));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteInvoiceRequest(
          snackBarCompleter(context, localization.deletedInvoice),
          invoices[0].id));
      break;
  }
}
