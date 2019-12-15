import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'buttons/edit_icon_button.dart';
import 'entities/entity_state_title.dart';

class ViewScaffold extends StatelessWidget {
  const ViewScaffold({
    @required this.body,
    @required this.entity,
    this.title,
    this.floatingActionButton,
    this.appBarBottom,
    this.isSettings = false,
  });

  final bool isSettings;
  final BaseEntity entity;
  final String title;
  final Widget body;
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
                  onPressed: () => store.dispatch(
                      UpdateCurrentRoute(state.uiState.previousRoute)),
                )
              : null,
          automaticallyImplyLeading: isMobile(context) && !isSettings,
          title: EntityStateTitle(
            entity: entity,
            title: title,
          ),
          bottom: appBarBottom,
          actions: entity.isNew
              ? []
              : [
                  userCompany.canEditEntity(entity)
                      ? EditIconButton(
                          isVisible: !entity.isDeleted,
                          onPressed: () =>
                              editEntity(context: context, entity: entity),
                        )
                      : Container(),
                  ActionMenuButton(
                    isSaving: state.isSaving,
                    entity: entity,
                    onSelected: (context, action) =>
                        handleEntityAction(context, entity, action),
                    entityActions: entity.getActions(userCompany: userCompany),
                  )
                ],
        ),
        body: body,
      ),
    );
  }
}
