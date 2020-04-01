import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ViewVendorList extends AbstractNavigatorAction implements PersistUI {
  ViewVendorList({@required NavigatorState navigator, this.force = false})
      : super(navigator: navigator);

  final bool force;
}

class ViewVendor extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  ViewVendor({
    @required this.vendorId,
    @required NavigatorState navigator,
    this.force = false,
  }) : super(navigator: navigator);

  final String vendorId;
  final bool force;
}

class EditVendor extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  EditVendor(
      {@required this.vendor,
      @required NavigatorState navigator,
      this.contact,
      this.completer,
      this.cancelCompleter,
      this.force = false})
      : super(navigator: navigator);

  final VendorEntity vendor;
  final VendorContactEntity contact;
  final Completer completer;
  final Completer cancelCompleter;
  final bool force;
}

class UpdateVendor implements PersistUI {
  UpdateVendor(this.vendor);

  final VendorEntity vendor;
}

class LoadVendor {
  LoadVendor({this.completer, this.vendorId});

  final Completer completer;
  final String vendorId;
}

class LoadVendorActivity {
  LoadVendorActivity({this.completer, this.vendorId});

  final Completer completer;
  final String vendorId;
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
  ArchiveVendorRequest(this.completer, this.vendorIds);

  final Completer completer;
  final List<String> vendorIds;
}

class ArchiveVendorSuccess implements StopSaving, PersistData {
  ArchiveVendorSuccess(this.vendors);

  final List<VendorEntity> vendors;
}

class ArchiveVendorFailure implements StopSaving {
  ArchiveVendorFailure(this.vendors);

  final List<VendorEntity> vendors;
}

class DeleteVendorRequest implements StartSaving {
  DeleteVendorRequest(this.completer, this.vendorIds);

  final Completer completer;
  final List<String> vendorIds;
}

class DeleteVendorSuccess implements StopSaving, PersistData {
  DeleteVendorSuccess(this.vendors);

  final List<VendorEntity> vendors;
}

class DeleteVendorFailure implements StopSaving {
  DeleteVendorFailure(this.vendors);

  final List<VendorEntity> vendors;
}

class RestoreVendorRequest implements StartSaving {
  RestoreVendorRequest(this.completer, this.vendorIds);

  final Completer completer;
  final List<String> vendorIds;
}

class RestoreVendorSuccess implements StopSaving, PersistData {
  RestoreVendorSuccess(this.vendors);

  final List<VendorEntity> vendors;
}

class RestoreVendorFailure implements StopSaving {
  RestoreVendorFailure(this.vendors);

  final List<VendorEntity> vendors;
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

class FilterVendors implements PersistUI {
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

class FilterVendorsByCustom3 implements PersistUI {
  FilterVendorsByCustom3(this.value);

  final String value;
}

class FilterVendorsByCustom4 implements PersistUI {
  FilterVendorsByCustom4(this.value);

  final String value;
}

class FilterVendorsByEntity implements PersistUI {
  FilterVendorsByEntity({this.entityId, this.entityType});

  final String entityId;
  final EntityType entityType;
}

void handleVendorAction(
    BuildContext context, List<BaseEntity> vendors, EntityAction action) {
  assert(
      [
            EntityAction.restore,
            EntityAction.archive,
            EntityAction.delete,
            EntityAction.toggleMultiselect
          ].contains(action) ||
          vendors.length == 1,
      'Cannot perform this action on more than one vendor');

  if (vendors.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final vendor = vendors.first as VendorEntity;
  final vendorIds = vendors.map((vendor) => vendor.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: vendor);
      break;
    case EntityAction.newExpense:
      if (isNotMobile(context)) {
        filterEntitiesByType(
            context: context,
            entityType: EntityType.expense,
            filterEntity: vendor);
      }
      createEntity(
          context: context,
          entity: ExpenseEntity(state: state, vendor: vendor));
      break;
    case EntityAction.restore:
      store.dispatch(RestoreVendorRequest(
          snackBarCompleter<Null>(context, localization.restoredVendor),
          vendorIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveVendorRequest(
          snackBarCompleter<Null>(context, localization.archivedVendor),
          vendorIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteVendorRequest(
          snackBarCompleter<Null>(context, localization.deletedVendor),
          vendorIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.vendorListState.isInMultiselect()) {
        store.dispatch(StartVendorMultiselect());
      }

      if (vendors.isEmpty) {
        break;
      }

      for (final vendor in vendors) {
        if (!store.state.vendorListState.isSelected(vendor.id)) {
          store.dispatch(AddToVendorMultiselect(entity: vendor));
        } else {
          store.dispatch(RemoveFromVendorMultiselect(entity: vendor));
        }
      }
      break;
  }
}

class StartVendorMultiselect {}

class AddToVendorMultiselect {
  AddToVendorMultiselect({@required this.entity});

  final BaseEntity entity;
}

class RemoveFromVendorMultiselect {
  RemoveFromVendorMultiselect({@required this.entity});

  final BaseEntity entity;
}

class ClearVendorMultiselect {}
