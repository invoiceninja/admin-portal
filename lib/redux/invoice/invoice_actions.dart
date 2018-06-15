import 'dart:async';

import 'package:invoiceninja/data/models/models.dart';
import 'package:built_collection/built_collection.dart';

class LoadInvoicesAction {
  final Completer completer;
  final bool force;

  LoadInvoicesAction([this.completer, this.force = false]);
}

class LoadInvoicesRequest {}

class LoadInvoicesFailure {
  final dynamic error;
  LoadInvoicesFailure(this.error);

  @override
  String toString() {
    return 'LoadInvoicesFailure{error: $error}';
  }
}

class LoadInvoicesSuccess {
  final BuiltList<InvoiceEntity> invoices;
  LoadInvoicesSuccess(this.invoices);

  @override
  String toString() {
    return 'LoadInvoicesSuccess{invoices: $invoices}';
  }
}

class SelectInvoiceAction {
  final InvoiceEntity invoice;
  SelectInvoiceAction(this.invoice);
}

class SaveInvoiceRequest {
  final Completer completer;
  final InvoiceEntity invoice;
  SaveInvoiceRequest(this.completer, this.invoice);
}

class SaveInvoiceSuccess {
  final InvoiceEntity invoice;

  SaveInvoiceSuccess(this.invoice);
}

class ArchiveInvoiceRequest {
  final Completer completer;
  final int invoiceId;

  ArchiveInvoiceRequest(this.completer, this.invoiceId);
}
class ArchiveInvoiceSuccess {
  final InvoiceEntity invoice;
  ArchiveInvoiceSuccess(this.invoice);
}
class ArchiveInvoiceFailure {
  final InvoiceEntity invoice;
  ArchiveInvoiceFailure(this.invoice);
}

class DeleteInvoiceRequest {
  final Completer completer;
  final int invoiceId;

  DeleteInvoiceRequest(this.completer, this.invoiceId);
}
class DeleteInvoiceSuccess {
  final InvoiceEntity invoice;
  DeleteInvoiceSuccess(this.invoice);
}
class DeleteInvoiceFailure {
  final InvoiceEntity invoice;
  DeleteInvoiceFailure(this.invoice);
}

class RestoreInvoiceRequest {
  final Completer completer;
  final int invoiceId;
  RestoreInvoiceRequest(this.completer, this.invoiceId);
}
class RestoreInvoiceSuccess {
  final InvoiceEntity invoice;
  RestoreInvoiceSuccess(this.invoice);
}
class RestoreInvoiceFailure {
  final InvoiceEntity invoice;
  RestoreInvoiceFailure(this.invoice);
}

class AddInvoiceSuccess {
  final InvoiceEntity invoice;
  AddInvoiceSuccess(this.invoice);
}

class SaveInvoiceFailure {
  final String error;
  SaveInvoiceFailure (this.error);
}


class SearchInvoices {
  final String search;
  SearchInvoices(this.search);
}

class SortInvoices {
  final String field;
  SortInvoices(this.field);
}

class FilterInvoicesByState {
  final EntityState state;

  FilterInvoicesByState(this.state);
}
