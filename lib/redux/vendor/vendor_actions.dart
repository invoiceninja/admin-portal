import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class ViewVendorList implements PersistUI {
  ViewVendorList({@required this.context, this.force = false});

  final BuildContext context;
  final bool force;
}

class ViewVendor implements PersistUI {
  ViewVendor({
    @required this.vendorId,
    @required this.context,
    this.force = false,
  });

  final int vendorId;
  final BuildContext context;
  final bool force;
}

class EditVendor implements PersistUI {
  EditVendor(
      {@required this.vendor,
      @required this.context,
      this.contact,
      this.completer,
      this.cancelCompleter,
      this.force = false});

  final VendorEntity vendor;
  final VendorContactEntity contact;
  final BuildContext context;
  final Completer completer;
  final Completer cancelCompleter;
  final bool force;
}

class UpdateVendor implements PersistUI {
  UpdateVendor(this.vendor);

  final VendorEntity vendor;
}

class LoadVendor {
  LoadVendor({this.completer, this.vendorId, this.loadActivities = false});

  final Completer completer;
  final int vendorId;
  final bool loadActivities;
}

class LoadVendorActivity {
  LoadVendorActivity({this.completer, this.vendorId});

  final Completer completer;
  final int vendorId;
}

class LoadVendors {
  LoadVendors({this.completer, this.force = false});

  final Completer completer;
  final bool force;
}

class LoadVendorRequest implements StartLoading {}

class LoadVendorFailure implements StopLoading {
  LoadVendorFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadVendorFailure{error: $error}';
  }
}

class LoadVendorSuccess implements StopLoading, PersistData {
  LoadVendorSuccess(this.vendor);

  final VendorEntity vendor;

  @override
  String toString() {
    return 'LoadVendorSuccess{vendor: $vendor}';
  }
}

class LoadVendorsRequest implements StartLoading {}

class LoadVendorsFailure implements StopLoading {
  LoadVendorsFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadVendorsFailure{error: $error}';
  }
}

class LoadVendorsSuccess implements StopLoading, PersistData {
  LoadVendorsSuccess(this.vendors);

  final BuiltList<VendorEntity> vendors;

  @override
  String toString() {
    return 'LoadVendorsSuccess{vendors: $vendors}';
  }
}

class SaveVendorRequest implements StartSaving {
  SaveVendorRequest({this.completer, this.vendor});

  final Completer completer;
  final VendorEntity vendor;
}

class SaveVendorSuccess implements StopSaving, PersistData, PersistUI {
  SaveVendorSuccess(this.vendor);

  final VendorEntity vendor;
}

class AddVendorSuccess implements StopSaving, PersistData, PersistUI {
  AddVendorSuccess(this.vendor);

  final VendorEntity vendor;
}

class SaveVendorFailure implements StopSaving {
  SaveVendorFailure(this.error);

  final Object error;
}

class ArchiveVendorRequest implements StartSaving {
  ArchiveVendorRequest(this.completer, this.vendorId);

  final Completer completer;
  final int vendorId;
}

class ArchiveVendorSuccess implements StopSaving, PersistData {
  ArchiveVendorSuccess(this.vendor);

  final VendorEntity vendor;
}

class ArchiveVendorFailure implements StopSaving {
  ArchiveVendorFailure(this.vendor);

  final VendorEntity vendor;
}

class DeleteVendorRequest implements StartSaving {
  DeleteVendorRequest(this.completer, this.vendorId);

  final Completer completer;
  final int vendorId;
}

class DeleteVendorSuccess implements StopSaving, PersistData {
  DeleteVendorSuccess(this.vendor);

  final VendorEntity vendor;
}

class DeleteVendorFailure implements StopSaving {
  DeleteVendorFailure(this.vendor);

  final VendorEntity vendor;
}

class RestoreVendorRequest implements StartSaving {
  RestoreVendorRequest(this.completer, this.vendorId);

  final Completer completer;
  final int vendorId;
}

class RestoreVendorSuccess implements StopSaving, PersistData {
  RestoreVendorSuccess(this.vendor);

  final VendorEntity vendor;
}

class RestoreVendorFailure implements StopSaving {
  RestoreVendorFailure(this.vendor);

  final VendorEntity vendor;
}

class EditVendorContact implements PersistUI {
  EditVendorContact([this.contact]);

  final VendorContactEntity contact;
}

class AddVendorContact implements PersistUI {
  AddVendorContact([this.contact]);

  final VendorContactEntity contact;
}

class UpdateVendorContact implements PersistUI {
  UpdateVendorContact({this.index, this.contact});

  final int index;
  final VendorContactEntity contact;
}

class DeleteVendorContact implements PersistUI {
  DeleteVendorContact(this.index);

  final int index;
}

class FilterVendors {
  FilterVendors(this.filter);

  final String filter;
}

class SortVendors implements PersistUI {
  SortVendors(this.field);

  final String field;
}

class FilterVendorsByState implements PersistUI {
  FilterVendorsByState(this.state);

  final EntityState state;
}

class FilterVendorsByCustom1 implements PersistUI {
  FilterVendorsByCustom1(this.value);

  final String value;
}

class FilterVendorsByCustom2 implements PersistUI {
  FilterVendorsByCustom2(this.value);

  final String value;
}

class FilterVendorsByEntity implements PersistUI {
  FilterVendorsByEntity({this.entityId, this.entityType});

  final int entityId;
  final EntityType entityType;
}

void handleVendorAction(
    BuildContext context, VendorEntity vendor, EntityAction action) {
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final CompanyEntity company = state.selectedCompany;
  final localization = AppLocalization.of(context);

  switch (action) {
    case EntityAction.edit:
      store.dispatch(EditVendor(context: context, vendor: vendor));
      break;
    case EntityAction.newExpense:
      store.dispatch(EditExpense(
          expense: ExpenseEntity(company: company, vendor: vendor),
          context: context));
      break;
    case EntityAction.restore:
      store.dispatch(RestoreVendorRequest(
          snackBarCompleter(context, localization.restoredVendor), vendor.id));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveVendorRequest(
          snackBarCompleter(context, localization.archivedVendor), vendor.id));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteVendorRequest(
          snackBarCompleter(context, localization.deletedVendor), vendor.id));
      break;
  }
}
