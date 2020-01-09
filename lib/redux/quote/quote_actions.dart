import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/pdf.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:flutter/material.dart';

class ViewQuoteList implements PersistUI {
  ViewQuoteList({this.context, this.force = false});

  final BuildContext context;
  final bool force;
}

class ViewQuote implements PersistUI {
  ViewQuote({this.quoteId, this.context, this.force = false});

  final int quoteId;
  final BuildContext context;
  final bool force;
}

class EditQuote implements PersistUI {
  EditQuote(
      {this.quote,
      this.context,
      this.completer,
      this.quoteItem,
      this.force = false});

  final InvoiceEntity quote;
  final InvoiceItemEntity quoteItem;
  final BuildContext context;
  final Completer completer;
  final bool force;
}

class ShowEmailQuote {
  ShowEmailQuote({this.quote, this.context, this.completer});

  final InvoiceEntity quote;
  final BuildContext context;
  final Completer completer;
}

class EditQuoteItem implements PersistUI {
  EditQuoteItem([this.quoteItem]);

  final InvoiceItemEntity quoteItem;
}

class UpdateQuote implements PersistUI {
  UpdateQuote(this.quote);

  final InvoiceEntity quote;
}

class LoadQuote {
  LoadQuote({this.completer, this.quoteId});

  final Completer completer;
  final int quoteId;
}

class LoadQuotes {
  LoadQuotes({this.completer, this.force = false});

  final Completer completer;
  final bool force;
}

class LoadQuoteRequest implements StartLoading {}

class LoadQuoteFailure implements StopLoading {
  LoadQuoteFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadQuoteFailure{error: $error}';
  }
}

class LoadQuoteSuccess implements StopLoading, PersistData {
  LoadQuoteSuccess(this.quote);

  final InvoiceEntity quote;

  @override
  String toString() {
    return 'LoadQuoteSuccess{quote: $quote}';
  }
}

class LoadQuotesRequest implements StartLoading {}

class LoadQuotesFailure implements StopLoading {
  LoadQuotesFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadQuotesFailure{error: $error}';
  }
}

class LoadQuotesSuccess implements StopLoading, PersistData {
  LoadQuotesSuccess(this.quotes);

  final BuiltList<InvoiceEntity> quotes;

  @override
  String toString() {
    return 'LoadQuotesSuccess{quotes: $quotes}';
  }
}

class AddQuoteItem implements PersistUI {
  AddQuoteItem({this.quoteItem});

  final InvoiceItemEntity quoteItem;
}

class AddQuoteItems implements PersistUI {
  AddQuoteItems(this.quoteItems);

  final List<InvoiceItemEntity> quoteItems;
}

class UpdateQuoteItem implements PersistUI {
  UpdateQuoteItem({this.index, this.quoteItem});

  final int index;
  final InvoiceItemEntity quoteItem;
}

class DeleteQuoteItem implements PersistUI {
  DeleteQuoteItem(this.index);

  final int index;
}

class SaveQuoteRequest implements StartSaving {
  SaveQuoteRequest({this.completer, this.quote});

  final Completer completer;
  final InvoiceEntity quote;
}

class SaveQuoteSuccess implements StopSaving, PersistData, PersistUI {
  SaveQuoteSuccess(this.quote);

  final InvoiceEntity quote;
}

class AddQuoteSuccess implements StopSaving, PersistData, PersistUI {
  AddQuoteSuccess(this.quote);

  final InvoiceEntity quote;
}

class SaveQuoteFailure implements StopSaving {
  SaveQuoteFailure(this.error);

  final Object error;
}

class EmailQuoteRequest implements StartSaving {
  EmailQuoteRequest(
      {this.completer, this.quoteId, this.template, this.subject, this.body});

  final Completer completer;
  final int quoteId;
  final EmailTemplate template;
  final String subject;
  final String body;
}

class EmailQuoteSuccess implements StopSaving, PersistData {}

class EmailQuoteFailure implements StopSaving {
  EmailQuoteFailure(this.error);

  final dynamic error;
}

class MarkSentQuoteRequest implements StartSaving {
  MarkSentQuoteRequest(this.completer, this.quoteId);

  final Completer completer;
  final int quoteId;
}

class MarkSentQuoteSuccess implements StopSaving, PersistData {
  MarkSentQuoteSuccess(this.quote);

  final InvoiceEntity quote;
}

class MarkSentQuoteFailure implements StopSaving {
  MarkSentQuoteFailure(this.quote);

  final InvoiceEntity quote;
}

class ArchiveQuoteRequest implements StartSaving {
  ArchiveQuoteRequest(this.completer, this.quoteId);

  final Completer completer;
  final int quoteId;
}

class ArchiveQuoteSuccess implements StopSaving, PersistData {
  ArchiveQuoteSuccess(this.quote);

  final InvoiceEntity quote;
}

class ArchiveQuoteFailure implements StopSaving {
  ArchiveQuoteFailure(this.quote);

  final InvoiceEntity quote;
}

class DeleteQuoteRequest implements StartSaving {
  DeleteQuoteRequest(this.completer, this.quoteId);

  final Completer completer;
  final int quoteId;
}

class DeleteQuoteSuccess implements StopSaving, PersistData {
  DeleteQuoteSuccess(this.quote);

  final InvoiceEntity quote;
}

class DeleteQuoteFailure implements StopSaving {
  DeleteQuoteFailure(this.quote);

  final InvoiceEntity quote;
}

class RestoreQuoteRequest implements StartSaving {
  RestoreQuoteRequest(this.completer, this.quoteId);

  final Completer completer;
  final int quoteId;
}

class RestoreQuoteSuccess implements StopSaving, PersistData {
  RestoreQuoteSuccess(this.quote);

  final InvoiceEntity quote;
}

class RestoreQuoteFailure implements StopSaving {
  RestoreQuoteFailure(this.quote);

  final InvoiceEntity quote;
}

class FilterQuotes {
  FilterQuotes(this.filter);

  final String filter;
}

class SortQuotes implements PersistUI {
  SortQuotes(this.field);

  final String field;
}

class FilterQuotesByState implements PersistUI {
  FilterQuotesByState(this.state);

  final EntityState state;
}

class FilterQuotesByStatus implements PersistUI {
  FilterQuotesByStatus(this.status);

  final EntityStatus status;
}

class FilterQuotesByEntity implements PersistUI {
  FilterQuotesByEntity({this.entityId, this.entityType});

  final int entityId;
  final EntityType entityType;
}

class FilterQuoteDropdown {
  FilterQuoteDropdown(this.filter);

  final String filter;
}

class FilterQuotesByCustom1 implements PersistUI {
  FilterQuotesByCustom1(this.value);

  final String value;
}

class FilterQuotesByCustom2 implements PersistUI {
  FilterQuotesByCustom2(this.value);

  final String value;
}

class ConvertQuote implements PersistData {
  ConvertQuote(this.completer, this.quoteId);

  final int quoteId;
  final Completer completer;
}

class ConvertQuoteSuccess implements StopSaving, PersistData {
  ConvertQuoteSuccess({this.quote, this.invoice});

  final InvoiceEntity quote;
  final InvoiceEntity invoice;
}

class ConvertQuoteFailure implements StopSaving {
  ConvertQuoteFailure(this.error);

  final dynamic error;
}

Future handleQuoteAction(
    BuildContext context, InvoiceEntity quote, EntityAction action) async {
  final store = StoreProvider.of<AppState>(context);
  final localization = AppLocalization.of(context);

  switch (action) {
    case EntityAction.edit:
      store.dispatch(EditQuote(context: context, quote: quote));
      break;
    case EntityAction.pdf:
      viewPdf(quote, context);
      break;
    case EntityAction.clientPortal:
      if (await canLaunch(quote.invitationSilentLink)) {
        await launch(quote.invitationSilentLink,
            forceSafariVC: false, forceWebView: false);
      }
      break;
    case EntityAction.viewInvoice:
      store.dispatch(
          ViewInvoice(context: context, invoiceId: quote.quoteInvoiceId));
      break;
    case EntityAction.convert:
      final Completer<InvoiceEntity> completer = Completer<InvoiceEntity>();
      store.dispatch(ConvertQuote(completer, quote.id));
      completer.future.then((InvoiceEntity invoice) {
        store.dispatch(ViewInvoice(invoiceId: invoice.id, context: context));
      });
      break;
    case EntityAction.markSent:
      store.dispatch(MarkSentQuoteRequest(
          snackBarCompleter(context, localization.markedQuoteAsSent),
          quote.id));
      break;
    case EntityAction.sendEmail:
      store.dispatch(ShowEmailQuote(
          completer: snackBarCompleter(context, localization.emailedQuote),
          quote: quote,
          context: context));
      break;
    case EntityAction.cloneToInvoice:
      store.dispatch(
          EditInvoice(context: context, invoice: quote.cloneToInvoice));
      break;
    case EntityAction.cloneToQuote:
      store.dispatch(EditQuote(context: context, quote: quote.cloneToQuote));
      break;
    case EntityAction.restore:
      store.dispatch(RestoreQuoteRequest(
          snackBarCompleter(context, localization.restoredQuote), quote.id));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveQuoteRequest(
          snackBarCompleter(context, localization.archivedQuote), quote.id));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteQuoteRequest(
          snackBarCompleter(context, localization.deletedQuote), quote.id));
      break;
  }
}
