import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewRecurringInvoiceList extends AbstractNavigatorAction
    implements PersistUI, StopLoading {
  ViewRecurringInvoiceList({
    @required NavigatorState navigator,
    this.force = false,
  }) : super(navigator: navigator);

  final bool force;
}

class ViewRecurringInvoice extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  ViewRecurringInvoice({
    @required NavigatorState navigator,
    @required this.recurringInvoiceId,
    this.force = false,
  }) : super(navigator: navigator);

  final String recurringInvoiceId;
  final bool force;
}

class EditRecurringInvoice extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  EditRecurringInvoice(
      {@required this.recurringInvoice,
      @required NavigatorState navigator,
      this.completer,
      this.cancelCompleter,
      this.force = false})
      : super(navigator: navigator);

  final InvoiceEntity recurringInvoice;
  final Completer completer;
  final Completer cancelCompleter;
  final bool force;
}

class UpdateRecurringInvoice implements PersistUI {
  UpdateRecurringInvoice(this.recurringInvoice);

  final InvoiceEntity recurringInvoice;
}

class LoadRecurringInvoice {
  LoadRecurringInvoice({this.completer, this.recurringInvoiceId});

  final Completer completer;
  final String recurringInvoiceId;
}

class LoadRecurringInvoiceActivity {
  LoadRecurringInvoiceActivity({this.completer, this.recurringInvoiceId});

  final Completer completer;
  final String recurringInvoiceId;
}

class LoadRecurringInvoices {
  LoadRecurringInvoices({this.completer});

  final Completer completer;
}

class LoadRecurringInvoiceRequest implements StartLoading {}

class LoadRecurringInvoiceFailure implements StopLoading {
  LoadRecurringInvoiceFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadRecurringInvoiceFailure{error: $error}';
  }
}

class LoadRecurringInvoiceSuccess implements StopLoading, PersistData {
  LoadRecurringInvoiceSuccess(this.recurringInvoice);

  final InvoiceEntity recurringInvoice;

  @override
  String toString() {
    return 'LoadRecurringInvoiceSuccess{recurringInvoice: $recurringInvoice}';
  }
}

class LoadRecurringInvoicesRequest implements StartLoading {}

class LoadRecurringInvoicesFailure implements StopLoading {
  LoadRecurringInvoicesFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadRecurringInvoicesFailure{error: $error}';
  }
}

class LoadRecurringInvoicesSuccess implements StopLoading {
  LoadRecurringInvoicesSuccess(this.recurringInvoices);

  final BuiltList<InvoiceEntity> recurringInvoices;

  @override
  String toString() {
    return 'LoadRecurringInvoicesSuccess{recurringInvoices: $recurringInvoices}';
  }
}

class SaveRecurringInvoiceRequest implements StartSaving {
  SaveRecurringInvoiceRequest({this.completer, this.recurringInvoice});

  final Completer completer;
  final InvoiceEntity recurringInvoice;
}

class SaveRecurringInvoiceSuccess
    implements StopSaving, PersistData, PersistUI {
  SaveRecurringInvoiceSuccess(this.recurringInvoice);

  final InvoiceEntity recurringInvoice;
}

class AddRecurringInvoiceSuccess implements StopSaving, PersistData, PersistUI {
  AddRecurringInvoiceSuccess(this.recurringInvoice);

  final InvoiceEntity recurringInvoice;
}

class SaveRecurringInvoiceFailure implements StopSaving {
  SaveRecurringInvoiceFailure(this.error);

  final Object error;
}

class ArchiveRecurringInvoicesRequest implements StartSaving {
  ArchiveRecurringInvoicesRequest(this.completer, this.recurringInvoiceIds);

  final Completer completer;
  final List<String> recurringInvoiceIds;
}

class ArchiveRecurringInvoicesSuccess implements StopSaving, PersistData {
  ArchiveRecurringInvoicesSuccess(this.recurringInvoices);

  final List<InvoiceEntity> recurringInvoices;
}

class ArchiveRecurringInvoicesFailure implements StopSaving {
  ArchiveRecurringInvoicesFailure(this.recurringInvoices);

  final List<InvoiceEntity> recurringInvoices;
}

class DeleteRecurringInvoicesRequest implements StartSaving {
  DeleteRecurringInvoicesRequest(this.completer, this.recurringInvoiceIds);

  final Completer completer;
  final List<String> recurringInvoiceIds;
}

class DeleteRecurringInvoicesSuccess implements StopSaving, PersistData {
  DeleteRecurringInvoicesSuccess(this.recurringInvoices);

  final List<InvoiceEntity> recurringInvoices;
}

class DeleteRecurringInvoicesFailure implements StopSaving {
  DeleteRecurringInvoicesFailure(this.recurringInvoices);

  final List<InvoiceEntity> recurringInvoices;
}

class RestoreRecurringInvoicesRequest implements StartSaving {
  RestoreRecurringInvoicesRequest(this.completer, this.recurringInvoiceIds);

  final Completer completer;
  final List<String> recurringInvoiceIds;
}

class RestoreRecurringInvoicesSuccess implements StopSaving, PersistData {
  RestoreRecurringInvoicesSuccess(this.recurringInvoices);

  final List<InvoiceEntity> recurringInvoices;
}

class RestoreRecurringInvoicesFailure implements StopSaving {
  RestoreRecurringInvoicesFailure(this.recurringInvoices);

  final List<InvoiceEntity> recurringInvoices;
}

class FilterRecurringInvoices implements PersistUI {
  FilterRecurringInvoices(this.filter);

  final String filter;
}

class SortRecurringInvoices implements PersistUI {
  SortRecurringInvoices(this.field);

  final String field;
}

class FilterRecurringInvoicesByState implements PersistUI {
  FilterRecurringInvoicesByState(this.state);

  final EntityState state;
}

class FilterRecurringInvoicesByCustom1 implements PersistUI {
  FilterRecurringInvoicesByCustom1(this.value);

  final String value;
}

class FilterRecurringInvoicesByCustom2 implements PersistUI {
  FilterRecurringInvoicesByCustom2(this.value);

  final String value;
}

class FilterRecurringInvoicesByCustom3 implements PersistUI {
  FilterRecurringInvoicesByCustom3(this.value);

  final String value;
}

class FilterRecurringInvoicesByCustom4 implements PersistUI {
  FilterRecurringInvoicesByCustom4(this.value);

  final String value;
}

void handleRecurringInvoiceAction(BuildContext context,
    List<BaseEntity> recurringInvoices, EntityAction action) {
  if (recurringInvoices.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  final localization = AppLocalization.of(context);
  final recurringInvoice = recurringInvoices.first as InvoiceEntity;
  final recurringInvoiceIds =
      recurringInvoices.map((recurringInvoice) => recurringInvoice.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: recurringInvoice);
      break;
    case EntityAction.restore:
      store.dispatch(RestoreRecurringInvoicesRequest(
          snackBarCompleter<Null>(
              context, localization.restoredRecurringInvoice),
          recurringInvoiceIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveRecurringInvoicesRequest(
          snackBarCompleter<Null>(
              context, localization.archivedRecurringInvoice),
          recurringInvoiceIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteRecurringInvoicesRequest(
          snackBarCompleter<Null>(
              context, localization.deletedRecurringInvoice),
          recurringInvoiceIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.recurringInvoiceListState.isInMultiselect()) {
        store.dispatch(StartRecurringInvoiceMultiselect());
      }

      if (recurringInvoices.isEmpty) {
        break;
      }

      for (final recurringInvoice in recurringInvoices) {
        if (!store.state.recurringInvoiceListState
            .isSelected(recurringInvoice.id)) {
          store.dispatch(
              AddToRecurringInvoiceMultiselect(entity: recurringInvoice));
        } else {
          store.dispatch(
              RemoveFromRecurringInvoiceMultiselect(entity: recurringInvoice));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [recurringInvoice],
        context: context,
      );
      break;
  }
}

class StartRecurringInvoiceMultiselect {
  StartRecurringInvoiceMultiselect();
}

class AddToRecurringInvoiceMultiselect {
  AddToRecurringInvoiceMultiselect({@required this.entity});

  final BaseEntity entity;
}

class RemoveFromRecurringInvoiceMultiselect {
  RemoveFromRecurringInvoiceMultiselect({@required this.entity});

  final BaseEntity entity;
}

class ClearRecurringInvoiceMultiselect {
  ClearRecurringInvoiceMultiselect();
}
