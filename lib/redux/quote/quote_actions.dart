import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewQuoteList implements PersistUI, StopLoading {
  ViewQuoteList({this.force = false});

  final bool force;
}

class ViewQuote implements PersistUI, PersistPrefs {
  ViewQuote({
    this.quoteId,
    this.force = false,
  });

  final String quoteId;
  final bool force;
}

class EditQuote implements PersistUI, PersistPrefs {
  EditQuote(
      {this.quote, this.quoteItemIndex, this.completer, this.force = false});

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

class ShowPdfQuote {
  ShowPdfQuote({this.quote, this.context, this.activityId});

  final InvoiceEntity quote;
  final BuildContext context;
  final String activityId;
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
  LoadQuotes({this.completer});

  final Completer completer;
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

class LoadQuotesSuccess implements StopLoading {
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

class MoveQuoteItem implements PersistUI {
  MoveQuoteItem({
    this.oldIndex,
    this.newIndex,
  });

  final int oldIndex;
  final int newIndex;
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

class BulkEmailQuotesRequest implements StartSaving {
  BulkEmailQuotesRequest(this.completer, this.quoteIds);

  final Completer completer;
  final List<String> quoteIds;
}

class BulkEmailQuotesSuccess implements StopSaving, PersistData {
  BulkEmailQuotesSuccess(this.quotes);

  final List<InvoiceEntity> quotes;
}

class BulkEmailQuotesFailure implements StopSaving {
  BulkEmailQuotesFailure(this.error);

  final dynamic error;
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

class ConvertQuotes implements StartSaving {
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

class SaveQuoteDocumentRequest implements StartSaving {
  SaveQuoteDocumentRequest({
    @required this.completer,
    @required this.multipartFile,
    @required this.quote,
  });

  final Completer completer;
  final MultipartFile multipartFile;
  final InvoiceEntity quote;
}

class SaveQuoteDocumentSuccess implements StopSaving, PersistData, PersistUI {
  SaveQuoteDocumentSuccess(this.document);

  final DocumentEntity document;
}

class SaveQuoteDocumentFailure implements StopSaving {
  SaveQuoteDocumentFailure(this.error);

  final Object error;
}

Future handleQuoteAction(
    BuildContext context, List<BaseEntity> quotes, EntityAction action) async {
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final quote = quotes.first as InvoiceEntity;
  final quoteIds = quotes.map((quote) => quote.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: quote);
      break;
    case EntityAction.viewPdf:
      store.dispatch(ShowPdfQuote(quote: quote, context: context));
      break;
    case EntityAction.clientPortal:
      if (await canLaunch(quote.invitationSilentLink)) {
        await launch(quote.invitationSilentLink,
            forceSafariVC: false, forceWebView: false);
      }
      break;
    case EntityAction.convertToInvoice:
      store.dispatch(ConvertQuotes(
          snackBarCompleter<Null>(context, localization.convertedQuote),
          quoteIds));
      break;
    case EntityAction.markSent:
      store.dispatch(MarkSentQuotesRequest(
          snackBarCompleter<Null>(context, localization.markedQuoteAsSent),
          quoteIds));
      break;
    case EntityAction.emailQuote:
      bool emailValid = true;
      quoteIds.forEach((element) {
        final client = state.clientState.get(quote.clientId);
        if (!client.hasEmailAddress) {
          emailValid = false;
        }
      });
      if (!emailValid) {
        showMessageDialog(
            context: context,
            message: localization.clientEmailNotSet,
            secondaryActions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    editEntity(
                        context: context,
                        entity: state.clientState.get(quote.clientId));
                  },
                  child: Text(localization.editClient.toUpperCase()))
            ]);
        return;
      }
      if (quoteIds.length == 1) {
        store.dispatch(ShowEmailQuote(
            completer:
                snackBarCompleter<Null>(context, localization.emailedQuote),
            quote: quote,
            context: context));
      } else {
        store.dispatch(BulkEmailQuotesRequest(
            snackBarCompleter<Null>(
                context,
                quoteIds.length == 1
                    ? localization.emailedQuote
                    : localization.emailedQuotes),
            quoteIds));
      }
      break;
    case EntityAction.cloneToOther:
      cloneToDialog(context: context, invoice: quote);
      break;
    case EntityAction.cloneToInvoice:
      final designId = getDesignIdForClientByEntity(
          state: state,
          clientId: quote.clientId,
          entityType: EntityType.invoice);
      createEntity(
          context: context,
          entity: quote.clone.rebuild((b) => b
            ..entityType = EntityType.invoice
            ..designId = designId));
      break;
    case EntityAction.cloneToQuote:
      createEntity(context: context, entity: quote.clone);
      break;
    case EntityAction.cloneToCredit:
      final designId = getDesignIdForClientByEntity(
          state: state,
          clientId: quote.clientId,
          entityType: EntityType.credit);
      createEntity(
          context: context,
          entity: quote.clone.rebuild((b) => b
            ..entityType = EntityType.credit
            ..designId = designId));
      break;
    case EntityAction.cloneToRecurring:
      final designId = getDesignIdForClientByEntity(
          state: state,
          clientId: quote.clientId,
          entityType: EntityType.invoice);
      createEntity(
          context: context,
          entity: quote.clone.rebuild((b) => b
            ..entityType = EntityType.recurringInvoice
            ..designId = designId));
      break;
    case EntityAction.restore:
      final message = quoteIds.length > 1
          ? localization.restoredQuotes
              .replaceFirst(':value', quoteIds.length.toString())
          : localization.restoredQuote;
      store.dispatch(RestoreQuotesRequest(
          snackBarCompleter<Null>(context, message), quoteIds));
      break;
    case EntityAction.archive:
      final message = quoteIds.length > 1
          ? localization.archivedQuotes
              .replaceFirst(':value', quoteIds.length.toString())
          : localization.archivedQuote;
      store.dispatch(ArchiveQuotesRequest(
          snackBarCompleter<Null>(context, message), quoteIds));
      break;
    case EntityAction.delete:
      final message = quoteIds.length > 1
          ? localization.deletedQuotes
              .replaceFirst(':value', quoteIds.length.toString())
          : localization.deletedQuote;
      store.dispatch(DeleteQuotesRequest(
          snackBarCompleter<Null>(context, message), quoteIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.quoteListState.isInMultiselect()) {
        store.dispatch(StartQuoteMultiselect());
      }
      for (final quote in quotes) {
        if (!store.state.quoteListState.isSelected(quote.id)) {
          store.dispatch(AddToQuoteMultiselect(entity: quote));
        } else {
          store.dispatch(RemoveFromQuoteMultiselect(entity: quote));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [quote],
        context: context,
      );
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

class UpdateQuoteTab implements PersistUI {
  UpdateQuoteTab({this.tabIndex});

  final int tabIndex;
}
