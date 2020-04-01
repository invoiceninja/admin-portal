import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewDesignList extends AbstractNavigatorAction implements PersistUI {
  ViewDesignList({
    @required NavigatorState navigator,
    this.force = false,
  }) : super(navigator: navigator);

  final bool force;
}

class ViewDesign extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  ViewDesign({
    @required NavigatorState navigator,
    @required this.designId,
    this.force = false,
  }) : super(navigator: navigator);

  final String designId;
  final bool force;
}

class EditDesign extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  EditDesign(
      {@required this.design,
      @required NavigatorState navigator,
      this.completer,
      this.cancelCompleter,
      this.force = false})
      : super(navigator: navigator);

  final DesignEntity design;
  final Completer completer;
  final Completer cancelCompleter;
  final bool force;
}

class UpdateDesign implements PersistUI {
  UpdateDesign(this.design);

  final DesignEntity design;
}

class LoadDesign {
  LoadDesign({this.completer, this.designId});

  final Completer completer;
  final String designId;
}

class LoadDesignActivity {
  LoadDesignActivity({this.completer, this.designId});

  final Completer completer;
  final String designId;
}

class LoadDesigns {
  LoadDesigns({this.completer, this.force = false});

  final Completer completer;
  final bool force;
}

class LoadDesignRequest implements StartLoading {}

class LoadDesignFailure implements StopLoading {
  LoadDesignFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadDesignFailure{error: $error}';
  }
}

class LoadDesignSuccess implements StopLoading, PersistData {
  LoadDesignSuccess(this.design);

  final DesignEntity design;

  @override
  String toString() {
    return 'LoadDesignSuccess{design: $design}';
  }
}

class LoadDesignsRequest implements StartLoading {}

class LoadDesignsFailure implements StopLoading {
  LoadDesignsFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadDesignsFailure{error: $error}';
  }
}

class LoadDesignsSuccess implements StopLoading, PersistData {
  LoadDesignsSuccess(this.designs);

  final BuiltList<DesignEntity> designs;

  @override
  String toString() {
    return 'LoadDesignsSuccess{designs: $designs}';
  }
}

class SaveDesignRequest implements StartSaving {
  SaveDesignRequest({this.completer, this.design});

  final Completer completer;
  final DesignEntity design;
}

class SaveDesignSuccess implements StopSaving, PersistData, PersistUI {
  SaveDesignSuccess(this.design);

  final DesignEntity design;
}

class AddDesignSuccess implements StopSaving, PersistData, PersistUI {
  AddDesignSuccess(this.design);

  final DesignEntity design;
}

class SaveDesignFailure implements StopSaving {
  SaveDesignFailure(this.error);

  final Object error;
}

class ArchiveDesignsRequest implements StartSaving {
  ArchiveDesignsRequest(this.completer, this.designIds);

  final Completer completer;
  final List<String> designIds;
}

class ArchiveDesignsSuccess implements StopSaving, PersistData {
  ArchiveDesignsSuccess(this.designs);

  final List<DesignEntity> designs;
}

class ArchiveDesignsFailure implements StopSaving {
  ArchiveDesignsFailure(this.designs);

  final List<DesignEntity> designs;
}

class DeleteDesignsRequest implements StartSaving {
  DeleteDesignsRequest(this.completer, this.designIds);

  final Completer completer;
  final List<String> designIds;
}

class DeleteDesignsSuccess implements StopSaving, PersistData {
  DeleteDesignsSuccess(this.designs);

  final List<DesignEntity> designs;
}

class DeleteDesignsFailure implements StopSaving {
  DeleteDesignsFailure(this.designs);

  final List<DesignEntity> designs;
}

class RestoreDesignsRequest implements StartSaving {
  RestoreDesignsRequest(this.completer, this.designIds);

  final Completer completer;
  final List<String> designIds;
}

class RestoreDesignsSuccess implements StopSaving, PersistData {
  RestoreDesignsSuccess(this.designs);

  final List<DesignEntity> designs;
}

class RestoreDesignsFailure implements StopSaving {
  RestoreDesignsFailure(this.designs);

  final List<DesignEntity> designs;
}

class FilterDesigns implements PersistUI {
  FilterDesigns(this.filter);

  final String filter;
}

class SortDesigns implements PersistUI {
  SortDesigns(this.field);

  final String field;
}

class FilterDesignsByState implements PersistUI {
  FilterDesignsByState(this.state);

  final EntityState state;
}

class FilterDesignsByCustom1 implements PersistUI {
  FilterDesignsByCustom1(this.value);

  final String value;
}

class FilterDesignsByCustom2 implements PersistUI {
  FilterDesignsByCustom2(this.value);

  final String value;
}

class FilterDesignsByCustom3 implements PersistUI {
  FilterDesignsByCustom3(this.value);

  final String value;
}

class FilterDesignsByCustom4 implements PersistUI {
  FilterDesignsByCustom4(this.value);

  final String value;
}

class FilterDesignsByEntity implements PersistUI {
  FilterDesignsByEntity({this.entityId, this.entityType});

  final String entityId;
  final EntityType entityType;
}

void handleDesignAction(
    BuildContext context, List<BaseEntity> designs, EntityAction action) {
  if (designs.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  final localization = AppLocalization.of(context);
  final design = designs.first as DesignEntity;
  final designIds = designs.map((design) => design.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: design);
      break;
    case EntityAction.clone:
      createEntity(context: context, entity: design.clone);
      break;
    case EntityAction.restore:
      store.dispatch(RestoreDesignsRequest(
          snackBarCompleter<Null>(context, localization.restoredDesign),
          designIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveDesignsRequest(
          snackBarCompleter<Null>(context, localization.archivedDesign),
          designIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteDesignsRequest(
          snackBarCompleter<Null>(context, localization.deletedDesign),
          designIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.designListState.isInMultiselect()) {
        store.dispatch(StartDesignMultiselect());
      }

      if (designs.isEmpty) {
        break;
      }

      for (final design in designs) {
        if (!store.state.designListState.isSelected(design.id)) {
          store.dispatch(AddToDesignMultiselect(entity: design));
        } else {
          store.dispatch(RemoveFromDesignMultiselect(entity: design));
        }
      }
      break;
  }
}

class StartDesignMultiselect {
  StartDesignMultiselect();
}

class AddToDesignMultiselect {
  AddToDesignMultiselect({@required this.entity});

  final BaseEntity entity;
}

class RemoveFromDesignMultiselect {
  RemoveFromDesignMultiselect({@required this.entity});

  final BaseEntity entity;
}

class ClearDesignMultiselect {
  ClearDesignMultiselect();
}
