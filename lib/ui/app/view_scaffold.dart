import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'buttons/edit_icon_button.dart';
import 'entities/entity_state_title.dart';

class ViewScaffold extends StatelessWidget {
  const ViewScaffold({
    @required this.body,
    @required this.entity,
    this.secondaryWidget,
    this.title,
    this.floatingActionButton,
    this.appBarBottom,
    this.isSettings = false,
    this.onBackPressed,
  });

  final bool isSettings;
  final BaseEntity entity;
  final Widget secondaryWidget;
  final String title;
  final Widget body;
  final Function onBackPressed;
  final Widget floatingActionButton;
  final Widget appBarBottom;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: !isMobile(context) && isSettings
              ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => onBackPressed != null
                      ? onBackPressed()
                      : store.dispatch(
                          UpdateCurrentRoute(state.uiState.previousRoute)),
                )
              : isMobile(context)
                  ? null
                  : Icon(getEntityIcon(entity.entityType)),
          automaticallyImplyLeading: isMobile(context) && !isSettings,
          title: EntityStateTitle(
            entity: entity,
            title: title,
          ),
          bottom: appBarBottom,
          actions: entity.isNew
              ? []
              : [
                  if (secondaryWidget != null) secondaryWidget,
                  userCompany.canEditEntity(entity)
                      ? EditIconButton(
                          isVisible: !(entity.isDeleted ?? false),
                          onPressed: () =>
                              editEntity(context: context, entity: entity),
                        )
                      : Container(),
                  ActionMenuButton(
                    isSaving: state.isSaving,
                    entity: entity,
                    onSelected: (context, action) =>
                        handleEntityAction(context, entity, action),
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
