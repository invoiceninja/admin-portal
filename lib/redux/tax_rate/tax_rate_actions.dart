import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/tax_rate_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class ViewTaxRateList implements PersistUI {
  ViewTaxRateList({@required this.context, this.force = false});

  final BuildContext context;
  final bool force;
}

class ViewTaxRate implements PersistUI {
  ViewTaxRate({
    @required this.taxRateId,
    @required this.context,
    this.force = false,
  });

  final String taxRateId;
  final BuildContext context;
  final bool force;
}

class EditTaxRate implements PersistUI {
  EditTaxRate(
      {@required this.taxRate,
      @required this.context,
      this.completer,
      this.force = false});

  final TaxRateEntity taxRate;
  final BuildContext context;
  final Completer completer;
  final bool force;
}

class UpdateTaxRate implements PersistUI {
  UpdateTaxRate(this.taxRate);

  final TaxRateEntity taxRate;
}

class LoadTaxRate {
  LoadTaxRate({this.completer, this.taxRateId, this.loadActivities = false});

  final Completer completer;
  final String taxRateId;
  final bool loadActivities;
}

class LoadTaxRateActivity {
  LoadTaxRateActivity({this.completer, this.taxRateId});

  final Completer completer;
  final String taxRateId;
}

class LoadTaxRates {
  LoadTaxRates({this.completer, this.force = false});

  final Completer completer;
  final bool force;
}

class LoadTaxRateRequest implements StartLoading {}

class LoadTaxRateFailure implements StopLoading {
  LoadTaxRateFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadTaxRateFailure{error: $error}';
  }
}

class LoadTaxRateSuccess implements StopLoading, PersistData {
  LoadTaxRateSuccess(this.taxRate);

  final TaxRateEntity taxRate;

  @override
  String toString() {
    return 'LoadTaxRateSuccess{taxRate: $taxRate}';
  }
}

class LoadTaxRatesRequest implements StartLoading {}

class LoadTaxRatesFailure implements StopLoading {
  LoadTaxRatesFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadTaxRatesFailure{error: $error}';
  }
}

class LoadTaxRatesSuccess implements StopLoading, PersistData {
  LoadTaxRatesSuccess(this.taxRates);

  final BuiltList<TaxRateEntity> taxRates;

  @override
  String toString() {
    return 'LoadTaxRatesSuccess{taxRates: $taxRates}';
  }
}

class SaveTaxRateRequest implements StartSaving {
  SaveTaxRateRequest({this.completer, this.taxRate});

  final Completer completer;
  final TaxRateEntity taxRate;
}

class SaveTaxRateSuccess implements StopSaving, PersistData, PersistUI {
  SaveTaxRateSuccess(this.taxRate);

  final TaxRateEntity taxRate;
}

class AddTaxRateSuccess implements StopSaving, PersistData, PersistUI {
  AddTaxRateSuccess(this.taxRate);

  final TaxRateEntity taxRate;
}

class SaveTaxRateFailure implements StopSaving {
  SaveTaxRateFailure(this.error);

  final Object error;
}

class ArchiveTaxRateRequest implements StartSaving {
  ArchiveTaxRateRequest(this.completer, this.taxRateId);

  final Completer completer;
  final String taxRateId;
}

class ArchiveTaxRateSuccess implements StopSaving, PersistData {
  ArchiveTaxRateSuccess(this.taxRate);

  final TaxRateEntity taxRate;
}

class ArchiveTaxRateFailure implements StopSaving {
  ArchiveTaxRateFailure(this.taxRate);

  final TaxRateEntity taxRate;
}

class DeleteTaxRateRequest implements StartSaving {
  DeleteTaxRateRequest(this.completer, this.taxRateId);

  final Completer completer;
  final String taxRateId;
}

class DeleteTaxRateSuccess implements StopSaving, PersistData {
  DeleteTaxRateSuccess(this.taxRate);

  final TaxRateEntity taxRate;
}

class DeleteTaxRateFailure implements StopSaving {
  DeleteTaxRateFailure(this.taxRate);

  final TaxRateEntity taxRate;
}

class RestoreTaxRateRequest implements StartSaving {
  RestoreTaxRateRequest(this.completer, this.taxRateId);

  final Completer completer;
  final String taxRateId;
}

class RestoreTaxRateSuccess implements StopSaving, PersistData {
  RestoreTaxRateSuccess(this.taxRate);

  final TaxRateEntity taxRate;
}

class RestoreTaxRateFailure implements StopSaving {
  RestoreTaxRateFailure(this.taxRate);

  final TaxRateEntity taxRate;
}

class FilterTaxRates {
  FilterTaxRates(this.filter);

  final String filter;
}

class SortTaxRates implements PersistUI {
  SortTaxRates(this.field);

  final String field;
}

class FilterTaxRatesByState implements PersistUI {
  FilterTaxRatesByState(this.state);

  final EntityState state;
}

class FilterTaxRatesByCustom1 implements PersistUI {
  FilterTaxRatesByCustom1(this.value);

  final String value;
}

class FilterTaxRatesByCustom2 implements PersistUI {
  FilterTaxRatesByCustom2(this.value);

  final String value;
}

class FilterTaxRatesByEntity implements PersistUI {
  FilterTaxRatesByEntity({this.entityId, this.entityType});

  final String entityId;
  final EntityType entityType;
}

void handleTaxRateAction(
    BuildContext context, List<TaxRateEntity> taxRates, EntityAction action) {
  assert(
      [
            EntityAction.restore,
            EntityAction.archive,
            EntityAction.delete,
            EntityAction.toggleMultiselect
          ].contains(action) ||
          taxRates.length == 1,
      'Cannot perform this action on more than one tax rate');

  final store = StoreProvider.of<AppState>(context);
  final localization = AppLocalization.of(context);
  final taxRate = taxRates.first;

  switch (action) {
    case EntityAction.edit:
      store.dispatch(EditTaxRate(context: context, taxRate: taxRate));
      break;
    case EntityAction.restore:
      store.dispatch(RestoreTaxRateRequest(
          snackBarCompleter(context, localization.restoredTaxRate),
          taxRate.id));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveTaxRateRequest(
          snackBarCompleter(context, localization.archivedTaxRate),
          taxRate.id));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteTaxRateRequest(
          snackBarCompleter(context, localization.deletedTaxRate), taxRate.id));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.taxRateListState.isInMultiselect()) {
        store.dispatch(StartTaxRateMultiselect(context: context));
      }

      if (taxRates.isEmpty) {
        break;
      }

      for (final taxRate in taxRates) {
        if (!store.state.taxRateListState.isSelected(taxRate)) {
          store.dispatch(
              AddToTaxRateMultiselect(context: context, entity: taxRate));
        } else {
          store.dispatch(
              RemoveFromTaxRateMultiselect(context: context, entity: taxRate));
        }
      }
      break;
  }
}

class StartTaxRateMultiselect {
  StartTaxRateMultiselect({@required this.context});

  final BuildContext context;
}

class AddToTaxRateMultiselect {
  AddToTaxRateMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class RemoveFromTaxRateMultiselect {
  RemoveFromTaxRateMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class ClearTaxRateMultiselect {
  ClearTaxRateMultiselect({@required this.context});

  final BuildContext context;
}