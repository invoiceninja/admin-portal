// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewVendorList implements PersistUI {
  ViewVendorList({
    this.force = false,
    this.page = 0,
  });

  final bool force;
  final int? page;
}

class ViewVendor implements PersistUI, PersistPrefs {
  ViewVendor({
    required this.vendorId,
    this.force = false,
  });

  final String? vendorId;
  final bool force;
}

class EditVendor implements PersistUI, PersistPrefs {
  EditVendor(
      {required this.vendor,
      this.contact,
      this.completer,
      this.cancelCompleter,
      this.force = false});

  final VendorEntity vendor;
  final VendorContactEntity? contact;
  final Completer? completer;
  final Completer? cancelCompleter;
  final bool force;
}

class UpdateVendor implements PersistUI {
  UpdateVendor(this.vendor);

  final VendorEntity vendor;
}

class LoadVendor {
  LoadVendor({this.completer, this.vendorId});

  final Completer? completer;
  final String? vendorId;
}

class LoadVendorActivity {
  LoadVendorActivity({this.completer, this.vendorId});

  final Completer? completer;
  final String? vendorId;
}

class LoadVendors {
  LoadVendors({this.completer, this.page = 1});

  final Completer? completer;
  final int page;
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

class LoadVendorsSuccess implements StopLoading {
  LoadVendorsSuccess(this.vendors);

  final BuiltList<VendorEntity> vendors;

  @override
  String toString() {
    return 'LoadVendorsSuccess{vendors: $vendors}';
  }
}

class SaveVendorRequest implements StartSaving {
  SaveVendorRequest({this.completer, this.vendor});

  final Completer? completer;
  final VendorEntity? vendor;
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

  final List<VendorEntity?> vendors;
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

  final List<VendorEntity?> vendors;
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

  final List<VendorEntity?> vendors;
}

class EditVendorContact implements PersistUI {
  EditVendorContact([this.contact]);

  final VendorContactEntity? contact;
}

class AddVendorContact implements PersistUI {
  AddVendorContact([this.contact]);

  final VendorContactEntity? contact;
}

class UpdateVendorContact implements PersistUI {
  UpdateVendorContact({
    required this.index,
    required this.contact,
  });

  final int index;
  final VendorContactEntity contact;
}

class DeleteVendorContact implements PersistUI {
  DeleteVendorContact(this.index);

  final int index;
}

class FilterVendors implements PersistUI {
  FilterVendors(this.filter);

  final String? filter;
}

class SortVendors implements PersistUI, PersistPrefs {
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

void handleVendorAction(
    BuildContext? context, List<BaseEntity> vendors, EntityAction? action) {
  if (vendors.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final vendor = vendors.first as VendorEntity;
  final vendorIds = vendors.map((vendor) => vendor.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: vendor);
      break;
    case EntityAction.vendorPortal:
      final contact = vendor.contacts.firstWhere((contact) {
        return contact.link.isNotEmpty;
      }, orElse: null);
      launchUrl(Uri.parse(contact.silentLink));
      break;
    case EntityAction.newPurchaseOrder:
      createEntity(
        entity: InvoiceEntity(
          state: state,
          vendor: vendor,
          entityType: EntityType.purchaseOrder,
        ),
      );
      break;
    case EntityAction.newExpense:
      createEntity(
        entity: ExpenseEntity(state: state, vendor: vendor),
      );
      break;
    case EntityAction.newRecurringExpense:
      createEntity(
        entity: ExpenseEntity(
            state: state,
            vendor: vendor,
            entityType: EntityType.recurringExpense),
      );
      break;
    case EntityAction.restore:
      final message = vendorIds.length > 1
          ? localization!.restoredVendors
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', vendorIds.length.toString())
          : localization!.restoredVendor;
      store.dispatch(
          RestoreVendorRequest(snackBarCompleter<Null>(message), vendorIds));
      break;
    case EntityAction.archive:
      final message = vendorIds.length > 1
          ? localization!.archivedVendors
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', vendorIds.length.toString())
          : localization!.archivedVendor;
      store.dispatch(
          ArchiveVendorRequest(snackBarCompleter<Null>(message), vendorIds));
      break;
    case EntityAction.delete:
      final message = vendorIds.length > 1
          ? localization!.deletedVendors
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', vendorIds.length.toString())
          : localization!.deletedVendor;
      store.dispatch(
          DeleteVendorRequest(snackBarCompleter<Null>(message), vendorIds));
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
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [vendor],
      );
      break;
    case EntityAction.documents:
      final documentIds = <String>[];
      for (var vendor in vendors) {
        for (var document in (vendor as VendorEntity).documents) {
          documentIds.add(document.id);
        }
      }
      if (documentIds.isEmpty) {
        showMessageDialog(message: localization!.noDocumentsToDownload);
      } else {
        store.dispatch(
          DownloadDocumentsRequest(
            documentIds: documentIds,
            completer: snackBarCompleter<Null>(
              localization!.exportedData,
            ),
          ),
        );
      }
      break;
    default:
      print('## ERROR: unhandled action $action in vendor_actions');
      break;
  }
}

class StartVendorMultiselect {}

class AddToVendorMultiselect {
  AddToVendorMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromVendorMultiselect {
  RemoveFromVendorMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearVendorMultiselect {}

class SaveVendorDocumentRequest implements StartSaving {
  SaveVendorDocumentRequest({
    required this.isPrivate,
    required this.completer,
    required this.multipartFiles,
    required this.vendor,
  });

  final bool isPrivate;
  final Completer completer;
  final List<MultipartFile> multipartFiles;
  final VendorEntity vendor;
}

class SaveVendorDocumentSuccess implements StopSaving, PersistData, PersistUI {
  SaveVendorDocumentSuccess(this.document);

  final DocumentEntity document;
}

class SaveVendorDocumentFailure implements StopSaving {
  SaveVendorDocumentFailure(this.error);

  final Object error;
}

class UpdateVendorTab implements PersistUI {
  UpdateVendorTab({this.tabIndex});

  final int? tabIndex;
}
