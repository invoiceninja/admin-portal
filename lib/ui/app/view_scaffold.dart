import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'buttons/edit_icon_button.dart';

class ViewScaffold extends StatelessWidget {
  const ViewScaffold({
    @required this.body,
    @required this.entity,
    this.title,
    this.floatingActionButton,
    this.appBarBottom,
    this.isFilter = false,
    this.onBackPressed,
  });

  final bool isFilter;
  final BaseEntity entity;
  final String title;
  final Widget body;
  final Function onBackPressed;
  final Widget floatingActionButton;
  final Widget appBarBottom;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final isSettings = entity.entityType.isSetting;

    String title = (entity.listDisplayName ?? '').isEmpty
        ? localization.pending
        : entity.listDisplayName;

    if (!(isFilter ?? false)) {
      title = localization.lookup('${entity.entityType}') + '  ›  ' + title;
    }

    Widget leading;
    if (!isMobile(context)) {
      if ((isFilter ?? false) &&
          entity.entityType == state.uiState.filterEntityType) {
        leading = IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (state.prefState.alwaysShowFilterSidebar) {
              store.dispatch(FilterByEntity(
                entityType: state.uiState.filterEntityType,
                entityId: state.uiState.filterEntityId,
              ));
            } else {
              store.dispatch(UserPreferencesChanged(showFilterSidebar: false));
            }
          },
        );
      } else if (isSettings) {
        leading = IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => onBackPressed != null
              ? onBackPressed()
              : store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute)),
        );
      }
    }

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(
          centerTitle: false,
          leading: leading,
          automaticallyImplyLeading: isMobile(context) || isSettings,
          title: EntityStateTitle(
            entity: entity,
          ),
          bottom: appBarBottom,
          actions: entity.isNew
              ? []
              : [
                  userCompany.canEditEntity(entity)
                      ? Builder(builder: (context) {
                          return EditIconButton(
                            isVisible: entity.isEditable,
                            onPressed: () =>
                                editEntity(context: context, entity: entity),
                          );
                        })
                      : Container(),
                  ViewActionMenuButton(
                    isSaving: state.isSaving,
                    entity: entity,
                    onSelected: (context, action) => handleEntityAction(
                        context, entity, action,
                        autoPop: true),
                    entityActions: entity.getActions(
                      userCompany: userCompany,
                      client: entity is BelongsToClient
                          ? state.clientState
                              .map[(entity as BelongsToClient).clientId]
                          : null,
                    ),
                  ),
                ],
        ),
        body: body,
      ),
    );
  }
}
