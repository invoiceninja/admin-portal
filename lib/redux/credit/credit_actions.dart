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

class ViewCreditList extends AbstractNavigatorAction implements PersistUI {
  ViewCreditList({@required NavigatorState navigator, this.force = false})
      : super(navigator: navigator);

  final bool force;
}

class ViewCredit extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  ViewCredit({
    this.creditId,
    @required NavigatorState navigator,
    this.force = false,
  }) : super(navigator: navigator);

  final String creditId;
  final bool force;
}

class EditCredit extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  EditCredit(
      {this.credit,
      @required NavigatorState navigator,
      this.creditItemIndex,
      this.completer,
      this.force = false})
      : super(navigator: navigator);

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
  LoadCredits({this.completer, this.force = false});

  final Completer completer;
  final bool force;
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

class LoadCreditsSuccess implements StopLoading, PersistData {
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

class FilterCreditsByEntity implements PersistUI {
  FilterCreditsByEntity({this.entityId, this.entityType});

  final String entityId;
  final EntityType entityType;
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

Future handleCreditAction(
    BuildContext context, List<BaseEntity> credits, EntityAction action) async {
  assert(
      [
            EntityAction.restore,
            EntityAction.archive,
            EntityAction.delete,
            EntityAction.toggleMultiselect
          ].contains(action) ||
          credits.length == 1,
      'Cannot perform this action on more than one credit');

  final store = StoreProvider.of<AppState>(context);
  final localization = AppLocalization.of(context);
  final credit = credits.first as InvoiceEntity;
  final creditIds = credits.map((credit) => credit.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: credit);
      break;
    case EntityAction.pdf:
      viewPdf(credit, context);
      break;
    case EntityAction.clientPortal:
      if (await canLaunch(credit.invitationSilentLink)) {
        await launch(credit.invitationSilentLink,
            forceSafariVC: false, forceWebView: false);
      }
      break;
    case EntityAction.viewInvoice:
      viewEntityById(
          context: context,
          // TODO fix this
          // entityId: credit.creditInvoiceId,
          entityType: EntityType.invoice);
      break;
    case EntityAction.markSent:
      store.dispatch(MarkSentCreditRequest(
          snackBarCompleter<Null>(context, localization.markedCreditAsSent),
          creditIds));
      break;
    case EntityAction.sendEmail:
      store.dispatch(ShowEmailCredit(
          completer:
              snackBarCompleter<Null>(context, localization.emailedCredit),
          credit: credit,
          context: context));
      break;
    case EntityAction.cloneToInvoice:
      createEntity(context: context, entity: credit.clone);
      break;
    case EntityAction.cloneToCredit:
      createEntity(context: context, entity: credit.clone);
      createEntity(context: context, entity: credit.clone);
      break;
    case EntityAction.restore:
      store.dispatch(RestoreCreditsRequest(
          snackBarCompleter<Null>(context, localization.restoredCredit),
          creditIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveCreditsRequest(
          snackBarCompleter<Null>(context, localization.archivedCredit),
          creditIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteCreditsRequest(
          snackBarCompleter<Null>(context, localization.deletedCredit),
          creditIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.creditListState.isInMultiselect()) {
        store.dispatch(StartCreditMultiselect());
      }

      if (credits.isEmpty) {
        break;
      }

      for (final credit in credits) {
        if (!store.state.creditListState.isSelected(credit.id)) {
          store.dispatch(AddToCreditMultiselect(entity: credit));
        } else {
          store.dispatch(RemoveFromCreditMultiselect(entity: credit));
        }
      }
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
