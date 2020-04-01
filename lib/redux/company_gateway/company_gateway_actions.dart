import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewCompanyGatewayList extends AbstractNavigatorAction
    implements PersistUI {
  ViewCompanyGatewayList(
      {@required NavigatorState navigator, this.force = false})
      : super(navigator: navigator);

  final bool force;
}

class ViewCompanyGateway extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  ViewCompanyGateway({
    @required this.companyGatewayId,
    @required NavigatorState navigator,
    this.force = false,
  }) : super(navigator: navigator);

  final String companyGatewayId;
  final bool force;
}

class EditCompanyGateway extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  EditCompanyGateway(
      {@required this.companyGateway,
      @required NavigatorState navigator,
      this.completer,
      this.force = false})
      : super(navigator: navigator);

  final CompanyGatewayEntity companyGateway;
  final Completer completer;
  final bool force;
}

class UpdateCompanyGateway implements PersistUI {
  UpdateCompanyGateway(this.companyGateway);

  final CompanyGatewayEntity companyGateway;
}

class LoadCompanyGateway {
  LoadCompanyGateway({this.completer, this.companyGatewayId});

  final Completer completer;
  final String companyGatewayId;
}

class LoadCompanyGatewayActivity {
  LoadCompanyGatewayActivity({this.completer, this.companyGatewayId});

  final Completer completer;
  final String companyGatewayId;
}

class LoadCompanyGateways {
  LoadCompanyGateways({this.completer, this.force = false});

  final Completer completer;
  final bool force;
}

class LoadCompanyGatewayRequest implements StartLoading {}

class LoadCompanyGatewayFailure implements StopLoading {
  LoadCompanyGatewayFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadCompanyGatewayFailure{error: $error}';
  }
}

class LoadCompanyGatewaySuccess implements StopLoading, PersistData {
  LoadCompanyGatewaySuccess(this.companyGateway);

  final CompanyGatewayEntity companyGateway;

  @override
  String toString() {
    return 'LoadCompanyGatewaySuccess{companyGateway: $companyGateway}';
  }
}

class LoadCompanyGatewaysRequest implements StartLoading {}

class LoadCompanyGatewaysFailure implements StopLoading {
  LoadCompanyGatewaysFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadCompanyGatewaysFailure{error: $error}';
  }
}

class LoadCompanyGatewaysSuccess implements StopLoading, PersistData {
  LoadCompanyGatewaysSuccess(this.companyGateways);

  final BuiltList<CompanyGatewayEntity> companyGateways;

  @override
  String toString() {
    return 'LoadCompanyGatewaysSuccess{companyGateways: $companyGateways}';
  }
}

class SaveCompanyGatewayRequest implements StartSaving {
  SaveCompanyGatewayRequest({this.completer, this.companyGateway});

  final Completer completer;
  final CompanyGatewayEntity companyGateway;
}

class SaveCompanyGatewaySuccess implements StopSaving, PersistData, PersistUI {
  SaveCompanyGatewaySuccess(this.companyGateway);

  final CompanyGatewayEntity companyGateway;
}

class AddCompanyGatewaySuccess implements StopSaving, PersistData, PersistUI {
  AddCompanyGatewaySuccess(this.companyGateway);

  final CompanyGatewayEntity companyGateway;
}

class SaveCompanyGatewayFailure implements StopSaving {
  SaveCompanyGatewayFailure(this.error);

  final Object error;
}

class ArchiveCompanyGatewayRequest implements StartSaving {
  ArchiveCompanyGatewayRequest(this.completer, this.companyGatewayIds);

  final Completer completer;
  final List<String> companyGatewayIds;
}

class ArchiveCompanyGatewaySuccess implements StopSaving, PersistData {
  ArchiveCompanyGatewaySuccess(this.companyGateways);

  final List<CompanyGatewayEntity> companyGateways;
}

class ArchiveCompanyGatewayFailure implements StopSaving {
  ArchiveCompanyGatewayFailure(this.companyGateways);

  final List<CompanyGatewayEntity> companyGateways;
}

class DeleteCompanyGatewayRequest implements StartSaving {
  DeleteCompanyGatewayRequest(this.completer, this.companyGatewayIds);

  final Completer completer;
  final List<String> companyGatewayIds;
}

class DeleteCompanyGatewaySuccess implements StopSaving, PersistData {
  DeleteCompanyGatewaySuccess(this.companyGateways);

  final List<CompanyGatewayEntity> companyGateways;
}

class DeleteCompanyGatewayFailure implements StopSaving {
  DeleteCompanyGatewayFailure(this.companyGateways);

  final List<CompanyGatewayEntity> companyGateways;
}

class RestoreCompanyGatewayRequest implements StartSaving {
  RestoreCompanyGatewayRequest(this.completer, this.companyGatewayIds);

  final Completer completer;
  final List<String> companyGatewayIds;
}

class RestoreCompanyGatewaySuccess implements StopSaving, PersistData {
  RestoreCompanyGatewaySuccess(this.companyGateways);

  final List<CompanyGatewayEntity> companyGateways;
}

class RestoreCompanyGatewayFailure implements StopSaving {
  RestoreCompanyGatewayFailure(this.companyGateways);

  final List<CompanyGatewayEntity> companyGateways;
}

class FilterCompanyGateways implements PersistUI {
  FilterCompanyGateways(this.filter);

  final String filter;
}

class SortCompanyGateways implements PersistUI {
  SortCompanyGateways(this.field);

  final String field;
}

class FilterCompanyGatewaysByState implements PersistUI {
  FilterCompanyGatewaysByState(this.state);

  final EntityState state;
}

class FilterCompanyGatewaysByCustom1 implements PersistUI {
  FilterCompanyGatewaysByCustom1(this.value);

  final String value;
}

class FilterCompanyGatewaysByCustom2 implements PersistUI {
  FilterCompanyGatewaysByCustom2(this.value);

  final String value;
}

class FilterCompanyGatewaysByCustom3 implements PersistUI {
  FilterCompanyGatewaysByCustom3(this.value);

  final String value;
}

class FilterCompanyGatewaysByCustom4 implements PersistUI {
  FilterCompanyGatewaysByCustom4(this.value);

  final String value;
}

class FilterCompanyGatewaysByEntity implements PersistUI {
  FilterCompanyGatewaysByEntity({this.entityId, this.entityType});

  final String entityId;
  final EntityType entityType;
}

void handleCompanyGatewayAction(BuildContext context,
    List<BaseEntity> companyGateways, EntityAction action) {
  assert(
      [
            EntityAction.restore,
            EntityAction.archive,
            EntityAction.delete,
            EntityAction.toggleMultiselect
          ].contains(action) ||
          companyGateways.length == 1,
      'Cannot perform this action on more than one company gateway');

  if (companyGateways.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  final localization = AppLocalization.of(context);
  final companyGateway = companyGateways.first;
  final companyGatewayIds =
      companyGateways.map((companyGateway) => companyGateway.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: companyGateway);
      break;
    case EntityAction.restore:
      store.dispatch(RestoreCompanyGatewayRequest(
          snackBarCompleter<Null>(context, localization.restoredCompanyGateway),
          companyGatewayIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveCompanyGatewayRequest(
          snackBarCompleter<Null>(context, localization.archivedCompanyGateway),
          companyGatewayIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteCompanyGatewayRequest(
          snackBarCompleter<Null>(context, localization.deletedCompanyGateway),
          companyGatewayIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.companyGatewayListState.isInMultiselect()) {
        store.dispatch(StartCompanyGatewayMultiselect());
      }

      if (companyGateways.isEmpty) {
        break;
      }

      for (final companyGateway in companyGateways) {
        if (!store.state.companyGatewayListState
            .isSelected(companyGateway.id)) {
          store
              .dispatch(AddToCompanyGatewayMultiselect(entity: companyGateway));
        } else {
          store.dispatch(
              RemoveFromCompanyGatewayMultiselect(entity: companyGateway));
        }
      }
      break;
  }
}

class StartCompanyGatewayMultiselect {}

class AddToCompanyGatewayMultiselect {
  AddToCompanyGatewayMultiselect({@required this.entity});

  final BaseEntity entity;
}

class RemoveFromCompanyGatewayMultiselect {
  RemoveFromCompanyGatewayMultiselect({@required this.entity});

  final BaseEntity entity;
}

class ClearCompanyGatewayMultiselect {}
