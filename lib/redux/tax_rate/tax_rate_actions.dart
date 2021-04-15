import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/tax_rate_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class ViewTaxRateList implements PersistUI, StopLoading {
  ViewTaxRateList({this.force = false});

  final bool force;
}

class ViewTaxRate implements PersistUI {
  ViewTaxRate({
    @required this.taxRateId,
    this.force = false,
  });

  final String taxRateId;
  final bool force;
}

class EditTaxRate implements PersistUI {
  EditTaxRate({@required this.taxRate, this.completer, this.force = false});

  final TaxRateEntity taxRate;
  final Completer completer;
  final bool force;
}

class UpdateTaxRate implements PersistUI {
  UpdateTaxRate(this.taxRate);

  final TaxRateEntity taxRate;
}

class LoadTaxRate {
  LoadTaxRate({this.completer, this.taxRateId});

  final Completer completer;
  final String taxRateId;
}

class LoadTaxRateActivity {
  LoadTaxRateActivity({this.completer, this.taxRateId});

  final Completer completer;
  final String taxRateId;
}

class LoadTaxRates {
  LoadTaxRates({this.completer});

  final Completer completer;
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

class LoadTaxRatesSuccess implements StopLoading {
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
  ArchiveTaxRateRequest(this.completer, this.taxRateIds);

  final Completer completer;
  final List<String> taxRateIds;
}

class ArchiveTaxRatesSuccess implements StopSaving, PersistData {
  ArchiveTaxRatesSuccess(this.taxRates);

  final List<TaxRateEntity> taxRates;
}

class ArchiveTaxRateFailure implements StopSaving {
  ArchiveTaxRateFailure(this.taxRates);

  final List<TaxRateEntity> taxRates;
}

class DeleteTaxRateRequest implements StartSaving {
  DeleteTaxRateRequest(this.completer, this.taxRateIds);

  final Completer completer;
  final List<String> taxRateIds;
}

class DeleteTaxRatesSuccess implements StopSaving, PersistData {
  DeleteTaxRatesSuccess(this.taxRates);

  final List<TaxRateEntity> taxRates;
}

class DeleteTaxRateFailure implements StopSaving {
  DeleteTaxRateFailure(this.taxRates);

  final List<TaxRateEntity> taxRates;
}

class RestoreTaxRateRequest implements StartSaving {
  RestoreTaxRateRequest(this.completer, this.taxRateIds);

  final Completer completer;
  final List<String> taxRateIds;
}

class RestoreTaxRatesSuccess implements StopSaving, PersistData {
  RestoreTaxRatesSuccess(this.taxRates);

  final List<TaxRateEntity> taxRates;
}

class RestoreTaxRateFailure implements StopSaving {
  RestoreTaxRateFailure(this.taxRates);

  final List<TaxRateEntity> taxRates;
}

class FilterTaxRates implements PersistUI {
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

void handleTaxRateAction(
    BuildContext context, List<BaseEntity> taxRates, EntityAction action) {
  assert(
      [
            EntityAction.restore,
            EntityAction.archive,
            EntityAction.delete,
            EntityAction.toggleMultiselect
          ].contains(action) ||
          taxRates.length == 1,
      'Cannot perform this action on more than one tax rate');

  if (taxRates.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  final localization = AppLocalization.of(context);
  final taxRate = taxRates.first;
  final taxRateIds = taxRates.map((taxRate) => taxRate.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: taxRate);
      break;
    case EntityAction.restore:
      final message = taxRateIds.length > 1
          ? localization.restoredTaxRates
              .replaceFirst(':value', taxRateIds.length.toString())
          : localization.restoredTaxRate;
      store.dispatch(RestoreTaxRateRequest(
          snackBarCompleter<Null>(context, message), taxRateIds));
      break;
    case EntityAction.archive:
      final message = taxRateIds.length > 1
          ? localization.archivedTaxRates
              .replaceFirst(':value', taxRateIds.length.toString())
          : localization.archivedTaxRate;
      store.dispatch(ArchiveTaxRateRequest(
          snackBarCompleter<Null>(context, message), taxRateIds));
      break;
    case EntityAction.delete:
      final message = taxRateIds.length > 1
          ? localization.deletedTaxRates
              .replaceFirst(':value', taxRateIds.length.toString())
          : localization.deletedTaxRate;
      store.dispatch(DeleteTaxRateRequest(
          snackBarCompleter<Null>(context, message), taxRateIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.taxRateListState.isInMultiselect()) {
        store.dispatch(StartTaxRateMultiselect());
      }

      if (taxRates.isEmpty) {
        break;
      }

      for (final taxRate in taxRates) {
        if (!store.state.taxRateListState.isSelected(taxRate.id)) {
          store.dispatch(AddToTaxRateMultiselect(entity: taxRate));
        } else {
          store.dispatch(RemoveFromTaxRateMultiselect(entity: taxRate));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [taxRate],
        context: context,
      );
      break;
  }
}

class StartTaxRateMultiselect {}

class AddToTaxRateMultiselect {
  AddToTaxRateMultiselect({@required this.entity});

  final BaseEntity entity;
}

class RemoveFromTaxRateMultiselect {
  RemoveFromTaxRateMultiselect({@required this.entity});

  final BaseEntity entity;
}

class ClearTaxRateMultiselect {}
