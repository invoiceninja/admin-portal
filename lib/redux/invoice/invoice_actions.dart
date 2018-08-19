import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewInvoiceList implements PersistUI {
  final BuildContext context;

  ViewInvoiceList(this.context);
}

class ViewInvoice implements PersistUI {
  final int invoiceId;
  final BuildContext context;

  ViewInvoice({this.invoiceId, this.context});
}

class EditInvoice implements PersistUI {
  final InvoiceEntity invoice;
  final InvoiceItemEntity invoiceItem;
  final BuildContext context;
  final Completer completer;

  EditInvoice({this.invoice, this.context, this.completer, this.invoiceItem});
}

class ShowEmailInvoice {
  final InvoiceEntity invoice;
  final BuildContext context;
  final Completer completer;

  ShowEmailInvoice({this.invoice, this.context, this.completer});
}

class EditInvoiceItem implements PersistUI {
  final InvoiceItemEntity invoiceItem;

  EditInvoiceItem([this.invoiceItem]);
}

class UpdateInvoice implements PersistUI {
  final InvoiceEntity invoice;

  UpdateInvoice(this.invoice);
}

class LoadInvoice {
  final Completer completer;
  final int invoiceId;

  LoadInvoice({this.completer, this.invoiceId});
}

class LoadInvoices {
  final Completer completer;
  final bool force;

  LoadInvoices({this.completer, this.force = false});
}

class LoadInvoiceRequest implements StartLoading {}

class LoadInvoiceFailure implements StopLoading {
  final dynamic error;

  LoadInvoiceFailure(this.error);

  @override
  String toString() {
    return 'LoadInvoiceFailure{error: $error}';
  }
}

class LoadInvoiceSuccess implements StopLoading, PersistData {
  final InvoiceEntity invoice;

  LoadInvoiceSuccess(this.invoice);

  @override
  String toString() {
    return 'LoadInvoiceSuccess{invoice: $invoice}';
  }
}

class LoadInvoicesRequest implements StartLoading {}

class LoadInvoicesFailure implements StopLoading {
  final dynamic error;

  LoadInvoicesFailure(this.error);

  @override
  String toString() {
    return 'LoadInvoicesFailure{error: $error}';
  }
}

class LoadInvoicesSuccess implements StopLoading, PersistData {
  final BuiltList<InvoiceEntity> invoices;

  LoadInvoicesSuccess(this.invoices);

  @override
  String toString() {
    return 'LoadInvoicesSuccess{invoices: $invoices}';
  }
}

class AddInvoiceItem implements PersistUI {
  final InvoiceItemEntity invoiceItem;

  AddInvoiceItem({this.invoiceItem});
}

class AddInvoiceItems implements PersistUI {
  final List<InvoiceItemEntity> invoiceItems;

  AddInvoiceItems(this.invoiceItems);
}

class UpdateInvoiceItem implements PersistUI {
  final int index;
  final InvoiceItemEntity invoiceItem;

  UpdateInvoiceItem({this.index, this.invoiceItem});
}

class DeleteInvoiceItem implements PersistUI {
  final int index;

  DeleteInvoiceItem(this.index);
}

class SaveInvoiceRequest implements StartSaving {
  final Completer completer;
  final InvoiceEntity invoice;

  SaveInvoiceRequest({this.completer, this.invoice});
}

class SaveInvoiceSuccess implements StopSaving, PersistData, PersistUI {
  final InvoiceEntity invoice;

  SaveInvoiceSuccess(this.invoice);
}

class AddInvoiceSuccess implements StopSaving, PersistData, PersistUI {
  final InvoiceEntity invoice;

  AddInvoiceSuccess(this.invoice);
}

class SaveInvoiceFailure implements StopSaving {
  final Object error;

  SaveInvoiceFailure(this.error);
}

class EmailInvoiceRequest implements StartSaving {
  final Completer completer;
  final int invoiceId;
  final EmailTemplate template;
  final String subject;
  final String body;

  EmailInvoiceRequest(
      {this.completer, this.invoiceId, this.template, this.subject, this.body});
}

class EmailInvoiceSuccess implements StopSaving, PersistData {}

class EmailInvoiceFailure implements StopSaving {
  final dynamic error;

  EmailInvoiceFailure(this.error);
}

class MarkSentInvoiceRequest implements StartSaving {
  final Completer completer;
  final int invoiceId;

  MarkSentInvoiceRequest(this.completer, this.invoiceId);
}

class MarkSentInvoiceSuccess implements StopSaving, PersistData {
  final InvoiceEntity invoice;

  MarkSentInvoiceSuccess(this.invoice);
}

class MarkSentInvoiceFailure implements StopSaving {
  final InvoiceEntity invoice;

  MarkSentInvoiceFailure(this.invoice);
}

class ArchiveInvoiceRequest implements StartSaving {
  final Completer completer;
  final int invoiceId;

  ArchiveInvoiceRequest(this.completer, this.invoiceId);
}

class ArchiveInvoiceSuccess implements StopSaving, PersistData {
  final InvoiceEntity invoice;

  ArchiveInvoiceSuccess(this.invoice);
}

class ArchiveInvoiceFailure implements StopSaving {
  final InvoiceEntity invoice;

  ArchiveInvoiceFailure(this.invoice);
}

class DeleteInvoiceRequest implements StartSaving {
  final Completer completer;
  final int invoiceId;

  DeleteInvoiceRequest(this.completer, this.invoiceId);
}

class DeleteInvoiceSuccess implements StopSaving, PersistData {
  final InvoiceEntity invoice;

  DeleteInvoiceSuccess(this.invoice);
}

class DeleteInvoiceFailure implements StopSaving {
  final InvoiceEntity invoice;

  DeleteInvoiceFailure(this.invoice);
}

class RestoreInvoiceRequest implements StartSaving {
  final Completer completer;
  final int invoiceId;

  RestoreInvoiceRequest(this.completer, this.invoiceId);
}

class RestoreInvoiceSuccess implements StopSaving, PersistData {
  final InvoiceEntity invoice;

  RestoreInvoiceSuccess(this.invoice);
}

class RestoreInvoiceFailure implements StopSaving {
  final InvoiceEntity invoice;

  RestoreInvoiceFailure(this.invoice);
}

class FilterInvoices {
  final String filter;

  FilterInvoices(this.filter);
}

class SortInvoices implements PersistUI {
  final String field;

  SortInvoices(this.field);
}

class FilterInvoicesByState implements PersistUI {
  final EntityState state;

  FilterInvoicesByState(this.state);
}

class FilterInvoicesByStatus implements PersistUI {
  final EntityStatus status;

  FilterInvoicesByStatus(this.status);
}

class FilterInvoicesByClient implements PersistUI {
  final int clientId;

  FilterInvoicesByClient([this.clientId]);
}

class FilterInvoiceDropdown {
  final String filter;

  FilterInvoiceDropdown(this.filter);
}

class FilterInvoicesByCustom1 implements PersistUI {
  final String value;

  FilterInvoicesByCustom1(this.value);
}

class FilterInvoicesByCustom2 implements PersistUI {
  final String value;

  FilterInvoicesByCustom2(this.value);
}
