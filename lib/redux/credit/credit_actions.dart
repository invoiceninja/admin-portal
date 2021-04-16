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

class ViewCreditList implements PersistUI, StopLoading {
  ViewCreditList({this.force = false});

  final bool force;
}

class ViewCredit implements PersistUI, PersistPrefs {
  ViewCredit({
    this.creditId,
    this.force = false,
  });

  final String creditId;
  final bool force;
}

class EditCredit implements PersistUI, PersistPrefs {
  EditCredit(
      {this.credit, this.creditItemIndex, this.completer, this.force = false});

  final InvoiceEntity credit;
  final int creditItemIndex;
  final Completer completer;
  final bool force;
}

class ShowEmailCredit {
  ShowEmailCredit({this.credit, this.context, this.completer});

  final InvoiceEntity credit;
  final BuildContext context;
  final Completer completer;
}

class ShowPdfCredit {
  ShowPdfCredit({this.credit, this.context, this.activityId});

  final InvoiceEntity credit;
  final BuildContext context;
  final String activityId;
}

class EditCreditItem implements PersistUI {
  EditCreditItem([this.creditItemIndex]);

  final int creditItemIndex;
}

class UpdateCredit implements PersistUI {
  UpdateCredit(this.credit);

  final InvoiceEntity credit;
}

class UpdateCreditClient implements PersistUI {
  UpdateCreditClient({this.client});

  final ClientEntity client;
}

class LoadCredit {
  LoadCredit({this.completer, this.creditId});

  final Completer completer;
  final String creditId;
}

class LoadCredits {
  LoadCredits({this.completer});

  final Completer completer;
}

class LoadCreditRequest implements StartLoading {}

class LoadCreditFailure implements StopLoading {
  LoadCreditFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadCreditFailure{error: $error}';
  }
}

class LoadCreditSuccess implements StopLoading, PersistData {
  LoadCreditSuccess(this.credit);

  final InvoiceEntity credit;

  @override
  String toString() {
    return 'LoadCreditSuccess{credit: $credit}';
  }
}

class LoadCreditsRequest implements StartLoading {}

class LoadCreditsFailure implements StopLoading {
  LoadCreditsFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadCreditsFailure{error: $error}';
  }
}

class LoadCreditsSuccess implements StopLoading {
  LoadCreditsSuccess(this.credits);

  final BuiltList<InvoiceEntity> credits;

  @override
  String toString() {
    return 'LoadCreditsSuccess{credits: $credits}';
  }
}

class AddCreditContact implements PersistUI {
  AddCreditContact({this.contact, this.invitation});

  final ContactEntity contact;
  final InvitationEntity invitation;
}

class RemoveCreditContact implements PersistUI {
  RemoveCreditContact({this.invitation});

  final InvitationEntity invitation;
}

class AddCreditItem implements PersistUI {
  AddCreditItem({this.creditItem});

  final InvoiceItemEntity creditItem;
}

class MoveCreditItem implements PersistUI {
  MoveCreditItem({
    this.oldIndex,
    this.newIndex,
  });

  final int oldIndex;
  final int newIndex;
}

class AddCreditItems implements PersistUI {
  AddCreditItems(this.creditItems);

  final List<InvoiceItemEntity> creditItems;
}

class UpdateCreditItem implements PersistUI {
  UpdateCreditItem({this.index, this.creditItem});

  final int index;
  final InvoiceItemEntity creditItem;
}

class DeleteCreditItem implements PersistUI {
  DeleteCreditItem(this.index);

  final int index;
}

class SaveCreditRequest implements StartSaving {
  SaveCreditRequest({this.completer, this.credit});

  final Completer completer;
  final InvoiceEntity credit;
}

class SaveCreditSuccess implements StopSaving, PersistData, PersistUI {
  SaveCreditSuccess(this.credit);

  final InvoiceEntity credit;
}

class AddCreditSuccess implements StopSaving, PersistData, PersistUI {
  AddCreditSuccess(this.credit);

  final InvoiceEntity credit;
}

class SaveCreditFailure implements StopSaving {
  SaveCreditFailure(this.error);

  final Object error;
}

class EmailCreditRequest implements StartSaving {
  EmailCreditRequest(
      {this.completer, this.creditId, this.template, this.subject, this.body});

  final Completer completer;
  final String creditId;
  final EmailTemplate template;
  final String subject;
  final String body;
}

class EmailCreditSuccess implements StopSaving, PersistData {}

class EmailCreditFailure implements StopSaving {
  EmailCreditFailure(this.error);

  final dynamic error;
}

class MarkSentCreditRequest implements StartSaving {
  MarkSentCreditRequest(this.completer, this.creditIds);

  final Completer completer;
  final List<String> creditIds;
}

class MarkSentCreditSuccess implements StopSaving, PersistData {
  MarkSentCreditSuccess(this.credits);

  final List<InvoiceEntity> credits;
}

class MarkSentCreditFailure implements StopSaving {
  MarkSentCreditFailure(this.error);

  final Object error;
}

class BulkEmailCreditsRequest implements StartSaving {
  BulkEmailCreditsRequest(this.completer, this.creditIds);

  final Completer completer;
  final List<String> creditIds;
}

class BulkEmailCreditsSuccess implements StopSaving, PersistData {
  BulkEmailCreditsSuccess(this.credits);

  final List<InvoiceEntity> credits;
}

class BulkEmailCreditsFailure implements StopSaving {
  BulkEmailCreditsFailure(this.error);

  final dynamic error;
}

class ArchiveCreditsRequest implements StartSaving {
  ArchiveCreditsRequest(this.completer, this.creditIds);

  final Completer completer;

  final List<String> creditIds;
}

class ArchiveCreditsSuccess implements StopSaving, PersistData {
  ArchiveCreditsSuccess(this.credits);

  final List<InvoiceEntity> credits;
}

class ArchiveCreditsFailure implements StopSaving {
  ArchiveCreditsFailure(this.credits);

  final List<InvoiceEntity> credits;
}

class DeleteCreditsRequest implements StartSaving {
  DeleteCreditsRequest(this.completer, this.creditIds);

  final Completer completer;

  final List<String> creditIds;
}

class DeleteCreditsSuccess implements StopSaving, PersistData {
  DeleteCreditsSuccess(this.credits);

  final List<InvoiceEntity> credits;
}

class DeleteCreditsFailure implements StopSaving {
  DeleteCreditsFailure(this.credits);

  final List<InvoiceEntity> credits;
}

class RestoreCreditsRequest implements StartSaving {
  RestoreCreditsRequest(this.completer, this.creditIds);

  final Completer completer;

  final List<String> creditIds;
}

class RestoreCreditsSuccess implements StopSaving, PersistData {
  RestoreCreditsSuccess(this.credits);

  final List<InvoiceEntity> credits;
}

class RestoreCreditsFailure implements StopSaving {
  RestoreCreditsFailure(this.credits);

  final List<InvoiceEntity> credits;
}

class FilterCredits implements PersistUI {
  FilterCredits(this.filter);

  final String filter;
}

class SortCredits implements PersistUI {
  SortCredits(this.field);

  final String field;
}

class FilterCreditsByState implements PersistUI {
  FilterCreditsByState(this.state);

  final EntityState state;
}

class FilterCreditsByStatus implements PersistUI {
  FilterCreditsByStatus(this.status);

  final EntityStatus status;
}

class FilterCreditDropdown {
  FilterCreditDropdown(this.filter);

  final String filter;
}

class FilterCreditsByCustom1 implements PersistUI {
  FilterCreditsByCustom1(this.value);

  final String value;
}

class FilterCreditsByCustom2 implements PersistUI {
  FilterCreditsByCustom2(this.value);

  final String value;
}

class FilterCreditsByCustom3 implements PersistUI {
  FilterCreditsByCustom3(this.value);

  final String value;
}

class FilterCreditsByCustom4 implements PersistUI {
  FilterCreditsByCustom4(this.value);

  final String value;
}

class SaveCreditDocumentRequest implements StartSaving {
  SaveCreditDocumentRequest({
    @required this.completer,
    @required this.multipartFile,
    @required this.credit,
  });

  final Completer completer;
  final MultipartFile multipartFile;
  final InvoiceEntity credit;
}

class SaveCreditDocumentSuccess implements StopSaving, PersistData, PersistUI {
  SaveCreditDocumentSuccess(this.document);

  final DocumentEntity document;
}

class SaveCreditDocumentFailure implements StopSaving {
  SaveCreditDocumentFailure(this.error);

  final Object error;
}

Future handleCreditAction(
    BuildContext context, List<BaseEntity> credits, EntityAction action) async {
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final credit = credits.first as InvoiceEntity;
  final creditIds = credits.map((credit) => credit.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: credit);
      break;
    case EntityAction.viewPdf:
      store.dispatch(ShowPdfCredit(credit: credit, context: context));
      break;
    case EntityAction.clientPortal:
      if (await canLaunch(credit.invitationSilentLink)) {
        await launch(credit.invitationSilentLink,
            forceSafariVC: false, forceWebView: false);
      }
      break;
    case EntityAction.markSent:
      store.dispatch(MarkSentCreditRequest(
          snackBarCompleter<Null>(context, localization.markedCreditAsSent),
          creditIds));
      break;
    case EntityAction.emailCredit:
      bool emailValid = true;
      creditIds.forEach((element) {
        final client = state.clientState.get(credit.clientId);
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
                        entity: state.clientState.get(credit.clientId));
                  },
                  child: Text(localization.editClient.toUpperCase()))
            ]);
        return;
      }
      if (creditIds.length == 1) {
        store.dispatch(ShowEmailCredit(
            completer:
                snackBarCompleter<Null>(context, localization.emailedCredit),
            credit: credit,
            context: context));
      } else {
        store.dispatch(BulkEmailCreditsRequest(
            snackBarCompleter<Null>(
                context,
                creditIds.length == 1
                    ? localization.emailedCredit
                    : localization.emailedCredits),
            creditIds));
      }
      break;
    case EntityAction.cloneToOther:
      cloneToDialog(context: context, invoice: credit);
      break;
    case EntityAction.cloneToInvoice:
      final designId = getDesignIdForClientByEntity(
          state: state,
          clientId: credit.clientId,
          entityType: EntityType.invoice);
      createEntity(
          context: context,
          entity: credit.clone.rebuild((b) => b
            ..entityType = EntityType.invoice
            ..designId = designId));
      break;
    case EntityAction.cloneToQuote:
      final designId = getDesignIdForClientByEntity(
          state: state,
          clientId: credit.clientId,
          entityType: EntityType.quote);
      createEntity(
          context: context,
          entity: credit.clone.rebuild((b) => b
            ..entityType = EntityType.quote
            ..designId = designId));
      break;
    case EntityAction.cloneToCredit:
      createEntity(context: context, entity: credit.clone);
      break;
    case EntityAction.cloneToRecurring:
      final designId = getDesignIdForClientByEntity(
          state: state,
          clientId: credit.clientId,
          entityType: EntityType.invoice);
      createEntity(
          context: context,
          entity: credit.clone.rebuild((b) => b
            ..entityType = EntityType.recurringInvoice
            ..designId = designId));
      break;
    case EntityAction.newPayment:
      createEntity(
        context: context,
        entity: PaymentEntity(state: state).rebuild((b) => b
          ..clientId = credit.clientId
          ..credits.addAll(credits
              .map((credit) => PaymentableEntity.fromCredit(credit))
              .toList())),
        filterEntity: state.clientState.map[credit.clientId],
      );
      break;
    case EntityAction.restore:
      final message = creditIds.length > 1
          ? localization.restoredCredits
              .replaceFirst(':value', creditIds.length.toString())
          : localization.restoredCredit;
      store.dispatch(RestoreCreditsRequest(
          snackBarCompleter<Null>(context, message), creditIds));
      break;
    case EntityAction.archive:
      final message = creditIds.length > 1
          ? localization.archivedCredits
              .replaceFirst(':value', creditIds.length.toString())
          : localization.archivedCredit;
      store.dispatch(ArchiveCreditsRequest(
          snackBarCompleter<Null>(context, message), creditIds));
      break;
    case EntityAction.delete:
      final message = creditIds.length > 1
          ? localization.deletedCredits
              .replaceFirst(':value', creditIds.length.toString())
          : localization.deletedCredit;
      store.dispatch(DeleteCreditsRequest(
          snackBarCompleter<Null>(context, message), creditIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.creditListState.isInMultiselect()) {
        store.dispatch(StartCreditMultiselect());
      }
      for (final credit in credits) {
        if (!store.state.creditListState.isSelected(credit.id)) {
          store.dispatch(AddToCreditMultiselect(entity: credit));
        } else {
          store.dispatch(RemoveFromCreditMultiselect(entity: credit));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [credit],
        context: context,
      );
      break;
  }
}

class StartCreditMultiselect {}

class AddToCreditMultiselect {
  AddToCreditMultiselect({@required this.entity});

  final BaseEntity entity;
}

class RemoveFromCreditMultiselect {
  RemoveFromCreditMultiselect({@required this.entity});

  final BaseEntity entity;
}

class ClearCreditMultiselect {}

class UpdateCreditTab implements PersistUI {
  UpdateCreditTab({this.tabIndex});

  final int tabIndex;
}
