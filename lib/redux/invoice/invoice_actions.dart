import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja/redux/app/app_actions.dart';

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
  final BuildContext context;
  EditInvoice({this.invoice, this.context});
}

class UpdateInvoice implements PersistUI {
  final InvoiceEntity invoice;
  UpdateInvoice(this.invoice);
}


class LoadInvoices {
  final Completer completer;
  final bool force;

  LoadInvoices([this.completer, this.force = false]);
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

class SaveInvoiceRequest implements StartLoading {
  final Completer completer;
  final InvoiceEntity invoice;
  SaveInvoiceRequest({this.completer, this.invoice});
}

class SaveInvoiceSuccess implements StopLoading, PersistData, PersistUI {
  final InvoiceEntity invoice;

  SaveInvoiceSuccess(this.invoice);
}

class AddInvoiceSuccess implements StopLoading, PersistData, PersistUI {
  final InvoiceEntity invoice;
  AddInvoiceSuccess(this.invoice);
}

class SaveInvoiceFailure implements StopLoading {
  final Object error;
  SaveInvoiceFailure (this.error);
}

class EmailInvoiceRequest implements StartLoading {
  final Completer completer;
  final int invoiceId;

  EmailInvoiceRequest(this.completer, this.invoiceId);
}

class EmailInvoiceSuccess implements StopLoading, PersistData {}

class EmailInvoiceFailure implements StopLoading {
  final dynamic error;
  EmailInvoiceFailure(this.error);
}

class ArchiveInvoiceRequest implements StartLoading {
  final Completer completer;
  final int invoiceId;

  ArchiveInvoiceRequest(this.completer, this.invoiceId);
}

class ArchiveInvoiceSuccess implements StopLoading, PersistData {
  final InvoiceEntity invoice;
  ArchiveInvoiceSuccess(this.invoice);
}

class ArchiveInvoiceFailure implements StopLoading {
  final InvoiceEntity invoice;
  ArchiveInvoiceFailure(this.invoice);
}

class DeleteInvoiceRequest implements StartLoading {
  final Completer completer;
  final int invoiceId;

  DeleteInvoiceRequest(this.completer, this.invoiceId);
}

class DeleteInvoiceSuccess implements StopLoading, PersistData {
  final InvoiceEntity invoice;
  DeleteInvoiceSuccess(this.invoice);
}

class DeleteInvoiceFailure implements StopLoading {
  final InvoiceEntity invoice;
  DeleteInvoiceFailure(this.invoice);
}

class RestoreInvoiceRequest implements StartLoading {
  final Completer completer;
  final int invoiceId;
  RestoreInvoiceRequest(this.completer, this.invoiceId);
}

class RestoreInvoiceSuccess implements StopLoading, PersistData {
  final InvoiceEntity invoice;
  RestoreInvoiceSuccess(this.invoice);
}

class RestoreInvoiceFailure implements StopLoading {
  final InvoiceEntity invoice;
  RestoreInvoiceFailure(this.invoice);
}




class SearchInvoices {
  final String search;
  SearchInvoices(this.search);
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

