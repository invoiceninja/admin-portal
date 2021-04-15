import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewCompanyGatewayList implements PersistUI, StopLoading {
  ViewCompanyGatewayList({this.force = false});

  final bool force;
}

class ViewCompanyGateway implements PersistUI, PersistPrefs {
  ViewCompanyGateway({
    @required this.companyGatewayId,
    this.force = false,
  });

  final String companyGatewayId;
  final bool force;
}

class EditCompanyGateway implements PersistUI, PersistPrefs {
  EditCompanyGateway(
      {@required this.companyGateway, this.completer, this.force = false});

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
  LoadCompanyGateways({this.completer});

  final Completer completer;
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

class LoadCompanyGatewaysSuccess implements StopLoading {
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

void handleCompanyGatewayAction(BuildContext context,
    List<BaseEntity> companyGateways, EntityAction action) {
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
      final message = companyGatewayIds.length > 1
          ? localization.restoredCompanyGateways
              .replaceFirst(':value', companyGatewayIds.length.toString())
          : localization.restoredCompanyGateway;
      store.dispatch(RestoreCompanyGatewayRequest(
          snackBarCompleter<Null>(context, message), companyGatewayIds));
      break;
    case EntityAction.archive:
      final message = companyGatewayIds.length > 1
          ? localization.archivedCompanyGateways
              .replaceFirst(':value', companyGatewayIds.length.toString())
          : localization.archivedCompanyGateway;
      store.dispatch(ArchiveCompanyGatewayRequest(
          snackBarCompleter<Null>(context, message), companyGatewayIds));
      break;
    case EntityAction.delete:
      final message = companyGatewayIds.length > 1
          ? localization.deletedCompanyGateways
              .replaceFirst(':value', companyGatewayIds.length.toString())
          : localization.deletedCompanyGateway;
      store.dispatch(DeleteCompanyGatewayRequest(
          snackBarCompleter<Null>(context, message), companyGatewayIds));
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
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [companyGateway],
        context: context,
      );
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
