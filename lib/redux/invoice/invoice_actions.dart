import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewInvoiceList implements PersistUI {
  ViewInvoiceList(this.context);

  final BuildContext context;
}

class ViewInvoice implements PersistUI {
  ViewInvoice({this.invoiceId, this.context});

  final int invoiceId;
  final BuildContext context;
}

class EditInvoice implements PersistUI {
  EditInvoice({this.invoice, this.context, this.completer, this.invoiceItem});

  final InvoiceEntity invoice;
  final InvoiceItemEntity invoiceItem;
  final BuildContext context;
  final Completer completer;
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
  final int invoiceId;
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
  final int invoiceId;
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
  final int invoiceId;
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
  final int invoiceId;
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
  final int invoiceId;
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
  final int invoiceId;
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

  final int entityId;
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
