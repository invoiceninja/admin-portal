import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/blank_screen.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';
import 'buttons/edit_icon_button.dart';

class ViewScaffold extends StatelessWidget {
  const ViewScaffold({
    @required this.body,
    @required this.entity,
    this.floatingActionButton,
    this.appBarBottom,
    this.isFilter = false,
    this.onBackPressed,
    this.showClearSelection = false,
  });

  final bool isFilter;
  final BaseEntity entity;
  final Widget body;
  final Function onBackPressed;
  final Widget floatingActionButton;
  final Widget appBarBottom;
  final bool showClearSelection;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final isSettings = entity.entityType.isSetting;

    String title;
    if (entity.isNew) {
      title = '';
    } else {
      title = (entity.listDisplayName ?? '').isEmpty
          ? localization.pending
          : entity.listDisplayName;
      if (!(isFilter ?? false)) {
        title = EntityPresenter().initialize(entity, context).title;
      }
    }

    Widget leading;
    if (isDesktop(context)) {
      if ((isFilter ?? false) &&
          entity.entityType == state.uiState.filterEntityType) {
        leading = IconButton(
          tooltip: localization.hideSidebar,
          icon: Icon(Icons.clear),
          onPressed: () {
            store.dispatch(UpdateUserPreferences(showFilterSidebar: false));
          },
        );
      } else if (state.uiState.previewStack.isNotEmpty) {
        leading = IconButton(
            tooltip: localization.back,
            icon: Icon(Icons.arrow_back),
            onPressed: () => store.dispatch(PopPreviewStack()));
      } else if (showClearSelection) {
        leading = IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            viewEntityById(
              appContext: context.getAppContext(),
              entityType: entity.entityType,
              entityId: '',
              showError: false,
            );
          },
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
          automaticallyImplyLeading: isMobile(context),
          title: Text(title),
          bottom: appBarBottom,
          actions: entity.isNew
              ? []
              : [
                  if (isSettings && isDesktop(context))
                    TextButton(
                        onPressed: () {
                          onBackPressed != null
                              ? onBackPressed()
                              : store.dispatch(UpdateCurrentRoute(
                                  state.uiState.previousRoute));
                        },
                        child: Text(
                          localization.back,
                          style: TextStyle(color: state.headerTextColor),
                        )),
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
                    isSaving: state.isSaving && !isFilter,
                    entity: entity,
                    onSelected: (context, action) => handleEntityAction(
                        context.getAppContext(), entity, action,
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
        body: entity.isNew ? BlankScreen(localization.noRecordSelected) : body,
      ),
    );
  }
}
