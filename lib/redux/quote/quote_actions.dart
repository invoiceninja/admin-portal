// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/utils/files.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

import 'package:http/http.dart' as http;
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:printing/printing.dart';

class ViewQuoteList implements PersistUI {
  ViewQuoteList({
    this.force = false,
    this.page = 0,
  });

  final bool force;
  final int? page;
}

class ViewQuote implements PersistUI, PersistPrefs {
  ViewQuote({
    this.quoteId,
    this.force = false,
  });

  final String? quoteId;
  final bool force;
}

class EditQuote implements PersistUI, PersistPrefs {
  EditQuote(
      {this.quote, this.quoteItemIndex, this.completer, this.force = false});

  final InvoiceEntity? quote;
  final int? quoteItemIndex;
  final Completer? completer;
  final bool force;
}

class ShowEmailQuote {
  ShowEmailQuote({this.quote, this.context, this.completer});

  final InvoiceEntity? quote;
  final BuildContext? context;
  final Completer? completer;
}

class ShowPdfQuote {
  ShowPdfQuote({this.quote, this.context, this.activityId});

  final InvoiceEntity? quote;
  final BuildContext? context;
  final String? activityId;
}

class EditQuoteItem implements PersistUI {
  EditQuoteItem([this.quoteItemIndex]);

  final int? quoteItemIndex;
}

class UpdateQuote implements PersistUI {
  UpdateQuote(this.quote);

  final InvoiceEntity quote;
}

class UpdateQuoteClient implements PersistUI {
  UpdateQuoteClient({this.client});

  final ClientEntity? client;
}

class LoadQuote {
  LoadQuote({this.completer, this.quoteId});

  final Completer? completer;
  final String? quoteId;
}

class LoadQuotes {
  LoadQuotes({this.completer, this.page = 1});

  final Completer? completer;
  final int page;
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

  final ClientContactEntity? contact;
  final InvitationEntity? invitation;
}

class RemoveQuoteContact implements PersistUI {
  RemoveQuoteContact({this.invitation});

  final InvitationEntity? invitation;
}

class AddQuoteItem implements PersistUI {
  AddQuoteItem({this.quoteItem});

  final InvoiceItemEntity? quoteItem;
}

class MoveQuoteItem implements PersistUI {
  MoveQuoteItem({
    this.oldIndex,
    this.newIndex,
  });

  final int? oldIndex;
  final int? newIndex;
}

class AddQuoteItems implements PersistUI {
  AddQuoteItems(this.quoteItems);

  final List<InvoiceItemEntity> quoteItems;
}

class UpdateQuoteItem implements PersistUI {
  UpdateQuoteItem({
    required this.index,
    required this.quoteItem,
  });

  final int index;
  final InvoiceItemEntity quoteItem;
}

class DeleteQuoteItem implements PersistUI {
  DeleteQuoteItem(this.index);

  final int index;
}

class SaveQuoteRequest implements StartSaving {
  SaveQuoteRequest({
    required this.completer,
    required this.quote,
    required this.action,
  });

  final Completer completer;
  final InvoiceEntity quote;
  final EntityAction? action;
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
  EmailQuoteRequest({
    required this.completer,
    required this.quoteId,
    required this.template,
    required this.subject,
    required this.body,
    required this.ccEmail,
  });

  final Completer completer;
  final String quoteId;
  final EmailTemplate template;
  final String subject;
  final String body;
  final String ccEmail;
}

class EmailQuoteSuccess implements StopSaving, PersistData {
  EmailQuoteSuccess(this.quote);

  final InvoiceEntity quote;
}

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
  BulkEmailQuotesRequest({this.completer, this.quoteIds, this.template});

  final Completer? completer;
  final List<String>? quoteIds;
  final EmailTemplate? template;
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

  final List<InvoiceEntity?> quotes;
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

  final List<InvoiceEntity?> quotes;
}

class DownloadQuotesRequest implements StartSaving {
  DownloadQuotesRequest(this.completer, this.invoiceIds);

  final Completer completer;
  final List<String> invoiceIds;
}

class DownloadQuotesSuccess implements StopSaving {}

class DownloadQuotesFailure implements StopSaving {
  DownloadQuotesFailure(this.error);

  final Object error;
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

  final List<InvoiceEntity?> quotes;
}

class FilterQuotes implements PersistUI {
  FilterQuotes(this.filter);

  final String? filter;
}

class SortQuotes implements PersistUI, PersistPrefs {
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

  final String? filter;
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

class ConvertQuotesToInvoices implements StartSaving {
  ConvertQuotesToInvoices(this.completer, this.quoteIds);

  final List<String> quoteIds;
  final Completer completer;
}

class ConvertQuotesToInvoicesSuccess implements StopSaving {
  ConvertQuotesToInvoicesSuccess({this.quotes});

  final List<InvoiceEntity>? quotes;
}

class ConvertQuotesToInvoicesFailure implements StopSaving {
  ConvertQuotesToInvoicesFailure(this.error);

  final dynamic error;
}

class ConvertQuotesToProjects implements StartSaving {
  ConvertQuotesToProjects(this.completer, this.quoteIds);

  final List<String> quoteIds;
  final Completer completer;
}

class ConvertQuotesToProjectsSuccess implements StopSaving {
  ConvertQuotesToProjectsSuccess({this.quotes});

  final List<InvoiceEntity>? quotes;
}

class ConvertQuotesToProjectsFailure implements StopSaving {
  ConvertQuotesToProjectsFailure(this.error);

  final dynamic error;
}

class ApproveQuotes implements StartSaving {
  ApproveQuotes(this.completer, this.quoteIds);

  final List<String> quoteIds;
  final Completer completer;
}

class ApproveQuoteSuccess implements StopSaving {
  ApproveQuoteSuccess({this.quotes});

  final List<InvoiceEntity>? quotes;
}

class ApproveQuoteFailure implements StopSaving {
  ApproveQuoteFailure(this.error);

  final dynamic error;
}

class SaveQuoteDocumentRequest implements StartSaving {
  SaveQuoteDocumentRequest({
    required this.isPrivate,
    required this.completer,
    required this.multipartFile,
    required this.quote,
  });

  final bool? isPrivate;
  final Completer completer;
  final List<MultipartFile> multipartFile;
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
    BuildContext context, List<BaseEntity> quotes, EntityAction? action) async {
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final quote = quotes.first as InvoiceEntity;
  final quoteIds = quotes.map((quote) => quote.id).toList();
  final client = state.clientState.get(quote.clientId);

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: quote);
      break;
    case EntityAction.viewPdf:
      store.dispatch(ShowPdfQuote(quote: quote, context: context));
      break;
    case EntityAction.clientPortal:
      launchUrl(Uri.parse(quote.invitationSilentLink));
      break;
    case EntityAction.convertToInvoice:
      confirmCallback(
          context: context,
          message: localization!.convertToInvoice,
          callback: (_) {
            store.dispatch(ConvertQuotesToInvoices(
                snackBarCompleter<Null>(localization.convertedQuote),
                quoteIds));
          });
      break;
    case EntityAction.convertToProject:
      confirmCallback(
          context: context,
          message: localization!.convertToProject,
          callback: (_) {
            store.dispatch(ConvertQuotesToProjects(
                snackBarCompleter<Null>(localization.convertedQuote),
                quoteIds));
          });
      break;
    case EntityAction.approve:
      final message = quoteIds.length > 1
          ? localization!.approvedQuotes
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', quoteIds.length.toString())
          : localization!.approveQuote;
      store.dispatch(ApproveQuotes(snackBarCompleter<Null>(message), quoteIds));
      break;
    case EntityAction.viewInvoice:
      viewEntityById(entityId: quote.invoiceId, entityType: EntityType.invoice);
      break;
    case EntityAction.markSent:
      store.dispatch(MarkSentQuotesRequest(
          snackBarCompleter<Null>(localization!.markedQuoteAsSent), quoteIds));
      break;
    case EntityAction.sendEmail:
    case EntityAction.bulkSendEmail:
    case EntityAction.schedule:
      bool emailValid = true;
      quotes.forEach((quote) {
        final client = state.clientState.get(
          (quote as InvoiceEntity).clientId,
        );
        if (!client.hasEmailAddress) {
          emailValid = false;
        }
      });
      if (!emailValid) {
        showMessageDialog(
            message: localization!.clientEmailNotSet,
            secondaryActions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    editEntity(entity: state.clientState.get(quote.clientId));
                  },
                  child: Text(localization.editClient.toUpperCase()))
            ]);
        return;
      }
      if (action == EntityAction.sendEmail) {
        store.dispatch(ShowEmailQuote(
            completer: snackBarCompleter<Null>(localization!.emailedQuote),
            quote: quote,
            context: context));
      } else if (action == EntityAction.schedule) {
        if (!state.isProPlan) {
          showMessageDialog(
              message: localization!.upgradeToPaidPlanToSchedule,
              secondaryActions: [
                TextButton(
                    onPressed: () {
                      store.dispatch(
                          ViewSettings(section: kSettingsAccountManagement));
                      Navigator.of(context).pop();
                    },
                    child: Text(localization.upgrade.toUpperCase())),
              ]);
          return;
        }

        createEntity(
            entity: ScheduleEntity(ScheduleEntity.TEMPLATE_EMAIL_RECORD)
                .rebuild((b) => b
                  ..parameters.entityType = EntityType.quote.apiValue
                  ..parameters.entityId = quote.id));
      } else {
        confirmCallback(
            context: context,
            message: localization!.bulkEmailQuotes,
            callback: (_) {
              store.dispatch(BulkEmailQuotesRequest(
                  completer: snackBarCompleter<Null>(quoteIds.length == 1
                      ? localization.emailedQuote
                      : localization.emailedQuotes),
                  quoteIds: quoteIds));
            });
      }
      break;
    case EntityAction.cloneToPurchaseOrder:
      final designId = getDesignIdForVendorByEntity(
          state: state,
          vendorId: quote.vendorId,
          entityType: EntityType.purchaseOrder);
      createEntity(
          entity: quote.clone.rebuild((b) => b
            ..entityType = EntityType.purchaseOrder
            ..designId = designId));
      break;
    case EntityAction.cloneToOther:
      cloneToDialog(invoice: quote);
      break;
    case EntityAction.cloneToInvoice:
      final designId = getDesignIdForClientByEntity(
          state: state,
          clientId: quote.clientId,
          entityType: EntityType.invoice);
      createEntity(
          entity: quote.clone.rebuild((b) => b
            ..entityType = EntityType.invoice
            ..designId = designId));
      break;
    case EntityAction.clone:
    case EntityAction.cloneToQuote:
      createEntity(entity: quote.clone);
      break;
    case EntityAction.cloneToCredit:
      final designId = getDesignIdForClientByEntity(
          state: state,
          clientId: quote.clientId,
          entityType: EntityType.credit);
      createEntity(
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
          entity: quote.clone.rebuild((b) => b
            ..entityType = EntityType.recurringInvoice
            ..designId = designId));
      break;
    case EntityAction.download:
      store.dispatch(StartLoading());
      await WebClient()
          .get(quote.invitationDownloadLink, state.token, rawResponse: true)
          .then((response) {
        store.dispatch(StopLoading());
        saveDownloadedFile(
          response.bodyBytes,
          quote.number + '.pdf',
          prefix: EntityType.quote.apiValue,
          languageId: client.languageId,
        );
      }).catchError((_) {
        store.dispatch(StopLoading());
      });
      break;
    case EntityAction.bulkDownload:
      store.dispatch(DownloadQuotesRequest(
          snackBarCompleter<Null>(localization!.exportedData), quoteIds));
      break;
    case EntityAction.restore:
      final message = quoteIds.length > 1
          ? localization!.restoredQuotes
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', quoteIds.length.toString())
          : localization!.restoredQuote;
      store.dispatch(
          RestoreQuotesRequest(snackBarCompleter<Null>(message), quoteIds));
      break;
    case EntityAction.archive:
      final message = quoteIds.length > 1
          ? localization!.archivedQuotes
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', quoteIds.length.toString())
          : localization!.archivedQuote;
      store.dispatch(
          ArchiveQuotesRequest(snackBarCompleter<Null>(message), quoteIds));
      break;
    case EntityAction.delete:
      final message = quoteIds.length > 1
          ? localization!.deletedQuotes
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', quoteIds.length.toString())
          : localization!.deletedQuote;
      store.dispatch(
          DeleteQuotesRequest(snackBarCompleter<Null>(message), quoteIds));
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
    case EntityAction.printPdf:
      final invitation = quote.invitations.first;
      final url = invitation.downloadLink;
      store.dispatch(StartSaving());
      final http.Response? response =
          await WebClient().get(url, state.token, rawResponse: true);
      store.dispatch(StopSaving());
      await Printing.layoutPdf(onLayout: (_) => response!.bodyBytes);
      break;
    case EntityAction.bulkPrint:
      store.dispatch(StartSaving());
      final url = state.credentials.url + '/quotes/bulk';
      final data = json.encode(
          {'ids': quoteIds, 'action': EntityAction.bulkPrint.toApiParam()});
      final http.Response? response = await WebClient()
          .post(url, state.credentials.token, data: data, rawResponse: true);
      store.dispatch(StopSaving());
      await Printing.layoutPdf(onLayout: (_) => response!.bodyBytes);
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [quote],
      );
      break;
    case EntityAction.documents:
      final documentIds = <String>[];
      for (var quote in quotes) {
        for (var document in (quote as InvoiceEntity).documents) {
          documentIds.add(document.id);
        }
      }
      if (documentIds.isEmpty) {
        showMessageDialog(message: localization!.noDocumentsToDownload);
      } else {
        store.dispatch(
          DownloadDocumentsRequest(
            documentIds: documentIds,
            completer: snackBarCompleter<Null>(
              localization!.exportedData,
            ),
          ),
        );
      }
      break;
    default:
      print('## ERROR: unhandled action $action in quote_actions');
      break;
  }
}

class StartQuoteMultiselect {}

class AddToQuoteMultiselect {
  AddToQuoteMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromQuoteMultiselect {
  RemoveFromQuoteMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearQuoteMultiselect {}

class UpdateQuoteTab implements PersistUI {
  UpdateQuoteTab({this.tabIndex});

  final int? tabIndex;
}
