import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewQuoteList implements PersistUI {
  final BuildContext context;

  ViewQuoteList(this.context);
}

class ViewQuote implements PersistUI {
  final int quoteId;
  final BuildContext context;

  ViewQuote({this.quoteId, this.context});
}

class EditQuote implements PersistUI {
  final InvoiceEntity quote;
  final InvoiceItemEntity quoteItem;
  final BuildContext context;
  final Completer completer;

  EditQuote({this.quote, this.context, this.completer, this.quoteItem});
}

class ShowEmailQuote {
  final InvoiceEntity quote;
  final BuildContext context;
  final Completer completer;

  ShowEmailQuote({this.quote, this.context, this.completer});
}

class EditQuoteItem implements PersistUI {
  final InvoiceItemEntity quoteItem;

  EditQuoteItem([this.quoteItem]);
}

class UpdateQuote implements PersistUI {
  final InvoiceEntity quote;

  UpdateQuote(this.quote);
}

class LoadQuote {
  final Completer completer;
  final int quoteId;

  LoadQuote({this.completer, this.quoteId});
}

class LoadQuotes {
  final Completer completer;
  final bool force;

  LoadQuotes({this.completer, this.force = false});
}

class LoadQuoteRequest implements StartLoading {}

class LoadQuoteFailure implements StopLoading {
  final dynamic error;

  LoadQuoteFailure(this.error);

  @override
  String toString() {
    return 'LoadQuoteFailure{error: $error}';
  }
}

class LoadQuoteSuccess implements StopLoading, PersistData {
  final InvoiceEntity quote;

  LoadQuoteSuccess(this.quote);

  @override
  String toString() {
    return 'LoadQuoteSuccess{quote: $quote}';
  }
}

class LoadQuotesRequest implements StartLoading {}

class LoadQuotesFailure implements StopLoading {
  final dynamic error;

  LoadQuotesFailure(this.error);

  @override
  String toString() {
    return 'LoadQuotesFailure{error: $error}';
  }
}

class LoadQuotesSuccess implements StopLoading, PersistData {
  final BuiltList<InvoiceEntity> quotes;

  LoadQuotesSuccess(this.quotes);

  @override
  String toString() {
    return 'LoadQuotesSuccess{quotes: $quotes}';
  }
}

class AddQuoteItem implements PersistUI {
  final InvoiceItemEntity quoteItem;

  AddQuoteItem({this.quoteItem});
}

class AddQuoteItems implements PersistUI {
  final List<InvoiceItemEntity> quoteItems;

  AddQuoteItems(this.quoteItems);
}

class UpdateQuoteItem implements PersistUI {
  final int index;
  final InvoiceItemEntity quoteItem;

  UpdateQuoteItem({this.index, this.quoteItem});
}

class DeleteQuoteItem implements PersistUI {
  final int index;

  DeleteQuoteItem(this.index);
}

class SaveQuoteRequest implements StartSaving {
  final Completer completer;
  final InvoiceEntity quote;

  SaveQuoteRequest({this.completer, this.quote});
}

class SaveQuoteSuccess implements StopSaving, PersistData, PersistUI {
  final InvoiceEntity quote;

  SaveQuoteSuccess(this.quote);
}

class AddQuoteSuccess implements StopSaving, PersistData, PersistUI {
  final InvoiceEntity quote;

  AddQuoteSuccess(this.quote);
}

class SaveQuoteFailure implements StopSaving {
  final Object error;

  SaveQuoteFailure(this.error);
}

class EmailQuoteRequest implements StartSaving {
  final Completer completer;
  final int quoteId;
  final EmailTemplate template;
  final String subject;
  final String body;

  EmailQuoteRequest(
      {this.completer, this.quoteId, this.template, this.subject, this.body});
}

class EmailQuoteSuccess implements StopSaving, PersistData {}

class EmailQuoteFailure implements StopSaving {
  final dynamic error;

  EmailQuoteFailure(this.error);
}

class MarkSentQuoteRequest implements StartSaving {
  final Completer completer;
  final int quoteId;

  MarkSentQuoteRequest(this.completer, this.quoteId);
}

class MarkSentQuoteSuccess implements StopSaving, PersistData {
  final InvoiceEntity quote;

  MarkSentQuoteSuccess(this.quote);
}

class MarkSentQuoteFailure implements StopSaving {
  final InvoiceEntity quote;

  MarkSentQuoteFailure(this.quote);
}

class ArchiveQuoteRequest implements StartSaving {
  final Completer completer;
  final int quoteId;

  ArchiveQuoteRequest(this.completer, this.quoteId);
}

class ArchiveQuoteSuccess implements StopSaving, PersistData {
  final InvoiceEntity quote;

  ArchiveQuoteSuccess(this.quote);
}

class ArchiveQuoteFailure implements StopSaving {
  final InvoiceEntity quote;

  ArchiveQuoteFailure(this.quote);
}

class DeleteQuoteRequest implements StartSaving {
  final Completer completer;
  final int quoteId;

  DeleteQuoteRequest(this.completer, this.quoteId);
}

class DeleteQuoteSuccess implements StopSaving, PersistData {
  final InvoiceEntity quote;

  DeleteQuoteSuccess(this.quote);
}

class DeleteQuoteFailure implements StopSaving {
  final InvoiceEntity quote;

  DeleteQuoteFailure(this.quote);
}

class RestoreQuoteRequest implements StartSaving {
  final Completer completer;
  final int quoteId;

  RestoreQuoteRequest(this.completer, this.quoteId);
}

class RestoreQuoteSuccess implements StopSaving, PersistData {
  final InvoiceEntity quote;

  RestoreQuoteSuccess(this.quote);
}

class RestoreQuoteFailure implements StopSaving {
  final InvoiceEntity quote;

  RestoreQuoteFailure(this.quote);
}

class FilterQuotes {
  final String filter;

  FilterQuotes(this.filter);
}

class SortQuotes implements PersistUI {
  final String field;

  SortQuotes(this.field);
}

class FilterQuotesByState implements PersistUI {
  final EntityState state;

  FilterQuotesByState(this.state);
}

class FilterQuotesByStatus implements PersistUI {
  final EntityStatus status;

  FilterQuotesByStatus(this.status);
}

class FilterQuotesByEntity implements PersistUI {
  final int entityId;
  final EntityType entityType;

  FilterQuotesByEntity({this.entityId, this.entityType});
}

class FilterQuoteDropdown {
  final String filter;

  FilterQuoteDropdown(this.filter);
}

class FilterQuotesByCustom1 implements PersistUI {
  final String value;

  FilterQuotesByCustom1(this.value);
}

class FilterQuotesByCustom2 implements PersistUI {
  final String value;

  FilterQuotesByCustom2(this.value);
}


class ConvertQuote implements PersistData {
  final int quoteId;
  final Completer completer;

  ConvertQuote(this.completer, this.quoteId);
}

class ConvertQuoteSuccess implements StopSaving, PersistData {
  final InvoiceEntity quote;
  final InvoiceEntity invoice;

  ConvertQuoteSuccess({this.quote, this.invoice});
}

class ConvertQuoteFailure implements StopSaving {
  final dynamic error;

  ConvertQuoteFailure(this.error);
}
