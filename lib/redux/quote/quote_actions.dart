import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/pdf.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewQuoteList extends AbstractNavigatorAction implements PersistUI {
  ViewQuoteList({@required NavigatorState navigator, this.force = false})
      : super(navigator: navigator);

  final bool force;
}

class ViewQuote extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  ViewQuote({
    this.quoteId,
    @required NavigatorState navigator,
    this.force = false,
  }) : super(navigator: navigator);

  final String quoteId;
  final bool force;
}

class EditQuote extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  EditQuote(
      {this.quote,
      @required NavigatorState navigator,
      this.quoteItemIndex,
      this.completer,
      this.force = false})
      : super(navigator: navigator);

  final InvoiceEntity quote;
  final int quoteItemIndex;
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
  EditQuoteItem([this.quoteItemIndex]);

  final int quoteItemIndex;
}

class UpdateQuote implements PersistUI {
  UpdateQuote(this.quote);

  final InvoiceEntity quote;
}

class UpdateQuoteClient implements PersistUI {
  UpdateQuoteClient({this.client});

  final ClientEntity client;
}

class LoadQuote {
  LoadQuote({this.completer, this.quoteId});

  final Completer completer;
  final String quoteId;
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

class AddQuoteContact implements PersistUI {
  AddQuoteContact({this.contact, this.invitation});

  final ContactEntity contact;
  final InvitationEntity invitation;
}

class RemoveQuoteContact implements PersistUI {
  RemoveQuoteContact({this.invitation});

  final InvitationEntity invitation;
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
  final String quoteId;
  final EmailTemplate template;
  final String subject;
  final String body;
}

class EmailQuoteSuccess implements StopSaving, PersistData {}

class EmailQuoteFailure implements StopSaving {
  EmailQuoteFailure(this.error);

  final dynamic error;
}

class MarkSentQuotesRequest implements StartSaving {
  MarkSentQuotesRequest(this.completer, this.quoteIds);

  final Completer completer;
  final List<String> quoteIds;
}

class MarkSentQuoteSuccess implements StopSaving, PersistData {
  MarkSentQuoteSuccess(this.quotes);

  final List<InvoiceEntity> quotes;
}

class MarkSentQuoteFailure implements StopSaving {
  MarkSentQuoteFailure(this.error);

  final Object error;
}

class ArchiveQuotesRequest implements StartSaving {
  ArchiveQuotesRequest(this.completer, this.quoteIds);

  final Completer completer;

  final List<String> quoteIds;
}

class ArchiveQuotesSuccess implements StopSaving, PersistData {
  ArchiveQuotesSuccess(this.quotes);

  final List<InvoiceEntity> quotes;
}

class ArchiveQuotesFailure implements StopSaving {
  ArchiveQuotesFailure(this.quotes);

  final List<InvoiceEntity> quotes;
}

class DeleteQuotesRequest implements StartSaving {
  DeleteQuotesRequest(this.completer, this.quoteIds);

  final Completer completer;

  final List<String> quoteIds;
}

class DeleteQuotesSuccess implements StopSaving, PersistData {
  DeleteQuotesSuccess(this.quotes);

  final List<InvoiceEntity> quotes;
}

class DeleteQuotesFailure implements StopSaving {
  DeleteQuotesFailure(this.quotes);

  final List<InvoiceEntity> quotes;
}

class RestoreQuotesRequest implements StartSaving {
  RestoreQuotesRequest(this.completer, this.quoteIds);

  final Completer completer;

  final List<String> quoteIds;
}

class RestoreQuotesSuccess implements StopSaving, PersistData {
  RestoreQuotesSuccess(this.quotes);

  final List<InvoiceEntity> quotes;
}

class RestoreQuotesFailure implements StopSaving {
  RestoreQuotesFailure(this.quotes);

  final List<InvoiceEntity> quotes;
}

class FilterQuotes implements PersistUI {
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

  final String entityId;
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

class FilterQuotesByCustom3 implements PersistUI {
  FilterQuotesByCustom3(this.value);

  final String value;
}

class FilterQuotesByCustom4 implements PersistUI {
  FilterQuotesByCustom4(this.value);

  final String value;
}

class ConvertQuotes implements PersistData {
  ConvertQuotes(this.completer, this.quoteIds);

  final List<String> quoteIds;
  final Completer completer;
}

class ConvertQuoteSuccess implements StopSaving, PersistData {
  ConvertQuoteSuccess({this.quotes});

  final List<InvoiceEntity> quotes;
}

class ConvertQuoteFailure implements StopSaving {
  ConvertQuoteFailure(this.error);

  final dynamic error;
}

Future handleQuoteAction(
    BuildContext context, List<BaseEntity> quotes, EntityAction action) async {
  assert(
      [
            EntityAction.restore,
            EntityAction.archive,
            EntityAction.delete,
            EntityAction.toggleMultiselect
          ].contains(action) ||
          quotes.length == 1,
      'Cannot perform this action on more than one quote');

  final store = StoreProvider.of<AppState>(context);
  final localization = AppLocalization.of(context);
  final quote = quotes.first as InvoiceEntity;
  final quoteIds = quotes.map((quote) => quote.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: quote);
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
      viewEntityById(
          context: context,
          entityId: quote.invoiceId,
          entityType: EntityType.invoice);
      break;
    case EntityAction.convert:
      store.dispatch(ConvertQuotes(
          snackBarCompleter<Null>(context, localization.convertedQuote),
          quoteIds));
      break;
    case EntityAction.markSent:
      store.dispatch(MarkSentQuotesRequest(
          snackBarCompleter<Null>(context, localization.markedQuoteAsSent),
          quoteIds));
      break;
    case EntityAction.sendEmail:
      store.dispatch(ShowEmailQuote(
          completer:
              snackBarCompleter<Null>(context, localization.emailedQuote),
          quote: quote,
          context: context));
      break;
    case EntityAction.cloneToInvoice:
      createEntity(context: context, entity: quote.clone);
      break;
    case EntityAction.cloneToQuote:
      createEntity(context: context, entity: quote.clone);
      createEntity(context: context, entity: quote.clone);
      break;
    case EntityAction.restore:
      store.dispatch(RestoreQuotesRequest(
          snackBarCompleter<Null>(context, localization.restoredQuote),
          quoteIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveQuotesRequest(
          snackBarCompleter<Null>(context, localization.archivedQuote),
          quoteIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteQuotesRequest(
          snackBarCompleter<Null>(context, localization.deletedQuote),
          quoteIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.quoteListState.isInMultiselect()) {
        store.dispatch(StartQuoteMultiselect());
      }

      if (quotes.isEmpty) {
        break;
      }

      for (final quote in quotes) {
        if (!store.state.quoteListState.isSelected(quote.id)) {
          store.dispatch(AddToQuoteMultiselect(entity: quote));
        } else {
          store.dispatch(RemoveFromQuoteMultiselect(entity: quote));
        }
      }
      break;
  }
}

class StartQuoteMultiselect {}

class AddToQuoteMultiselect {
  AddToQuoteMultiselect({@required this.entity});

  final BaseEntity entity;
}

class RemoveFromQuoteMultiselect {
  RemoveFromQuoteMultiselect({@required this.entity});

  final BaseEntity entity;
}

class ClearQuoteMultiselect {}
