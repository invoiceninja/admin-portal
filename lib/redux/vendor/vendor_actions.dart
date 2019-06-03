import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewVendorList implements PersistUI {
  ViewVendorList(this.context);

  final BuildContext context;
}

class ViewVendor implements PersistUI {
  ViewVendor({this.vendorId, this.context});

  final int vendorId;
  final BuildContext context;
}

class EditVendor implements PersistUI {
  EditVendor(
      {this.vendor, this.context, this.completer, this.trackRoute = true});

  final VendorEntity vendor;
  final BuildContext context;
  final Completer completer;
  final bool trackRoute;
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
