import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class ViewCompanyGatewayList implements PersistUI {
  ViewCompanyGatewayList({@required this.context, this.force = false});

  final BuildContext context;
  final bool force;
}

class ViewCompanyGateway implements PersistUI {
  ViewCompanyGateway({
              @required this.companyGatewayId,
              @required this.context,
              this.force = false,
            });

  final String companyGatewayId;
  final BuildContext context;
  final bool force;
}

class EditCompanyGateway implements PersistUI {
  EditCompanyGateway(
                {@required this.companyGateway,
                @required this.context,
                this.completer,
                this.force = false});

  final CompanyGatewayEntity companyGateway;
  final BuildContext context;
  final Completer completer;
  final bool force;
}

class UpdateCompanyGateway implements PersistUI {
  UpdateCompanyGateway(this.companyGateway);

  final CompanyGatewayEntity companyGateway;
}

class LoadCompanyGateway {
  LoadCompanyGateway({this.completer, this.companyGatewayId, this.loadActivities = false});

  final Completer completer;
  final String companyGatewayId;
  final bool loadActivities;
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
  SaveCompanyGatewayFailure (this.error);

  final Object error;
}

class ArchiveCompanyGatewayRequest implements StartSaving {
  ArchiveCompanyGatewayRequest(this.completer, this.companyGatewayId);

  final Completer completer;
  final String companyGatewayId;
}

class ArchiveCompanyGatewaySuccess implements StopSaving, PersistData {
  ArchiveCompanyGatewaySuccess(this.companyGateway);

  final CompanyGatewayEntity companyGateway;
}

class ArchiveCompanyGatewayFailure implements StopSaving {
  ArchiveCompanyGatewayFailure(this.companyGateway);

  final CompanyGatewayEntity companyGateway;
}

class DeleteCompanyGatewayRequest implements StartSaving {
  DeleteCompanyGatewayRequest(this.completer, this.companyGatewayId);

  final Completer completer;
  final String companyGatewayId;
}

class DeleteCompanyGatewaySuccess implements StopSaving, PersistData {
  DeleteCompanyGatewaySuccess(this.companyGateway);

  final CompanyGatewayEntity companyGateway;
}

class DeleteCompanyGatewayFailure implements StopSaving {
  DeleteCompanyGatewayFailure(this.companyGateway);

  final CompanyGatewayEntity companyGateway;
}

class RestoreCompanyGatewayRequest implements StartSaving {
  RestoreCompanyGatewayRequest(this.completer, this.companyGatewayId);

  final Completer completer;
  final String companyGatewayId;
}

class RestoreCompanyGatewaySuccess implements StopSaving, PersistData {
  RestoreCompanyGatewaySuccess(this.companyGateway);

  final CompanyGatewayEntity companyGateway;
}

class RestoreCompanyGatewayFailure implements StopSaving {
  RestoreCompanyGatewayFailure(this.companyGateway);

  final CompanyGatewayEntity companyGateway;
}




class FilterCompanyGateways {
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

class FilterCompanyGatewaysByEntity implements PersistUI {
  FilterCompanyGatewaysByEntity({this.entityId, this.entityType});

  final String entityId;
  final EntityType entityType;
}


void handleCompanyGatewayAction(
    BuildContext context, List<CompanyGatewayEntity> companyGateways, EntityAction action) {
  final store = StoreProvider.of<AppState>(context);
  final localization = AppLocalization.of(context);
  final companyGateway = companyGateways.first;

  switch (action) {
    case EntityAction.edit:
      store.dispatch(EditCompanyGateway(context: context, companyGateway: companyGateway));
      break;
    case EntityAction.restore:
      store.dispatch(RestoreCompanyGatewayRequest(
          snackBarCompleter(context, localization.restoredCompanyGateway), companyGateway.id));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveCompanyGatewayRequest(
          snackBarCompleter(context, localization.archivedCompanyGateway), companyGateway.id));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteCompanyGatewayRequest(
          snackBarCompleter(context, localization.deletedCompanyGateway), companyGateway.id));
      break;
  }
}