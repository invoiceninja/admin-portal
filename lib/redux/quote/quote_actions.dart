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

class ViewQuoteList extends AbstractEntityAction implements PersistUI {
  ViewQuoteList({@required NavigatorState navigator, this.force = false})
      : super(navigator: navigator);

  final bool force;
}

class ViewQuote extends AbstractEntityAction
    implements PersistUI, PersistPrefs {
  ViewQuote({
    this.quoteId,
    @required NavigatorState navigator,
    this.force = false,
  }) : super(navigator: navigator);

  final String quoteId;
  final bool force;
}

class EditQuote extends AbstractEntityAction
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

class MarkSentQuoteRequest implements StartSaving {
  MarkSentQuoteRequest(this.completer, this.quoteId);

  final Completer completer;
  final String quoteId;
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
  ArchiveQuoteRequest(this.completer, this.quoteIds);

  final Completer completer;

  final List<String> quoteIds;
}

class ArchiveQuoteSuccess implements StopSaving, PersistData {
  ArchiveQuoteSuccess(this.quotes);

  final List<InvoiceEntity> quotes;
}

class ArchiveQuoteFailure implements StopSaving {
  ArchiveQuoteFailure(this.quotes);

  final List<InvoiceEntity> quotes;
}

class DeleteQuoteRequest implements StartSaving {
  DeleteQuoteRequest(this.completer, this.quoteIds);

  final Completer completer;

  final List<String> quoteIds;
}

class DeleteQuoteSuccess implements StopSaving, PersistData {
  DeleteQuoteSuccess(this.quotes);

  final List<InvoiceEntity> quotes;
}

class DeleteQuoteFailure implements StopSaving {
  DeleteQuoteFailure(this.quotes);

  final List<InvoiceEntity> quotes;
}

class RestoreQuoteRequest implements StartSaving {
  RestoreQuoteRequest(this.completer, this.quoteIds);

  final Completer completer;

  final List<String> quoteIds;
}

class RestoreQuoteSuccess implements StopSaving, PersistData {
  RestoreQuoteSuccess(this.quotes);

  final List<InvoiceEntity> quotes;
}

class RestoreQuoteFailure implements StopSaving {
  RestoreQuoteFailure(this.quotes);

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

class ConvertQuote implements PersistData {
  ConvertQuote(this.completer, this.quoteId);

  final String quoteId;
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
          entityId: quote.quoteInvoiceId,
          entityType: EntityType.invoice);
      break;
    case EntityAction.convert:
      final Completer<InvoiceEntity> completer = Completer<InvoiceEntity>();
      store.dispatch(ConvertQuote(completer, quote.id));
      completer.future.then((InvoiceEntity invoice) {
        viewEntityById(
            context: context,
            entityType: EntityType.invoice,
            entityId: invoice.id);
      });
      break;
    case EntityAction.markSent:
      store.dispatch(MarkSentQuoteRequest(
          snackBarCompleter<Null>(context, localization.markedQuoteAsSent),
          quote.id));
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
      createEntity(context: context, entity: quote.clone); createEntity(context: context, entity: quote.clone);
      break;
    case EntityAction.restore:
      store.dispatch(RestoreQuoteRequest(
          snackBarCompleter<Null>(context, localization.restoredQuote),
          quoteIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveQuoteRequest(
          snackBarCompleter<Null>(context, localization.archivedQuote),
          quoteIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteQuoteRequest(
          snackBarCompleter<Null>(context, localization.deletedQuote),
          quoteIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.quoteListState.isInMultiselect()) {
        store.dispatch(StartQuoteMultiselect(context: context));
      }

      if (quotes.isEmpty) {
        break;
      }

      for (final quote in quotes) {
        if (!store.state.quoteListState.isSelected(quote.id)) {
          store
              .dispatch(AddToQuoteMultiselect(context: context, entity: quote));
        } else {
          store.dispatch(
              RemoveFromQuoteMultiselect(context: context, entity: quote));
        }
      }
      break;
  }
}

class StartQuoteMultiselect {
  StartQuoteMultiselect({@required this.context});

  final BuildContext context;
}

class AddToQuoteMultiselect {
  AddToQuoteMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class RemoveFromQuoteMultiselect {
  RemoveFromQuoteMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class ClearQuoteMultiselect {
  ClearQuoteMultiselect({@required this.context});

  final BuildContext context;
}
