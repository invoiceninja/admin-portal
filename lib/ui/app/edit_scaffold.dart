import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class EditScaffold extends StatelessWidget {
  const EditScaffold({
    Key key,
    @required this.title,
    @required this.onSavePressed,
    @required this.body,
    this.entity,
    this.onCancelPressed,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.appBarBottom,
    this.saveLabel,
    this.isFullscreen = false,
    this.isAdvancedSettings = false,
    this.onActionPressed,
    this.actions,
  }) : super(key: key);

  final BaseEntity entity;
  final String title;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final Function(BuildContext, EntityAction) onActionPressed;
  final List<EntityAction> actions;
  final Widget appBarBottom;
  final Widget floatingActionButton;
  final Widget body;
  final Widget bottomNavigationBar;
  final String saveLabel;
  final bool isFullscreen;
  final bool isAdvancedSettings;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context);

    bool showUpgradeBanner = false;
    bool isEnabled = (isMobile(context) ||
            !state.uiState.isInSettings ||
            state.uiState.isEditing ||
            state.settingsUIState.isChanged) &&
        (!state.isLoading && !state.isSaving);
    bool isCancelEnabled = false;

    if (isAdvancedSettings && !state.isProPlan) {
      showUpgradeBanner = true;
      if (isEnabled) {
        isCancelEnabled = true;
        isEnabled = false;
      }
    }

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: showUpgradeBanner
            ? Column(
                children: [
                  IconMessage(localization.upgradeToPaidPlan,
                      color: Colors.orange),
                  Expanded(child: body),
                ],
              )
            : body,
        drawer: isDesktop(context) ? MenuDrawerBuilder() : null,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: isMobile(context),
          title: Text(title),
          actions: <Widget>[
            SaveCancelButtons(
              isEnabled: isEnabled && onSavePressed != null,
              isHeader: true,
              isCancelEnabled: isCancelEnabled,
              saveLabel: saveLabel,
              isSaving: state.isSaving,
              onSavePressed: (context) {
                // Clear focus now to prevent un-focus after save from
                // marking the form as changed and to hide the keyboard
                FocusScope.of(context).unfocus(
                    disposition: UnfocusDisposition.previouslyFocusedChild);

                onSavePressed(context);
              },
              onCancelPressed: isMobile(context)
                  ? null
                  : (context) {
                      if (onCancelPressed != null) {
                        onCancelPressed(context);
                      } else {
                        store.dispatch(ResetSettings());
                      }
                    },
            ),
            if (isDesktop(context) && actions != null && !state.isSaving)
              PopupMenuButton<EntityAction>(
                icon: Icon(
                  Icons.more_vert,
                  //size: iconSize,
                  //color: color,
                ),
                itemBuilder: (BuildContext context) => actions
                    .map((action) => PopupMenuItem<EntityAction>(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                getEntityActionIcon(action),
                                color: Theme.of(context).accentColor,
                              ),
                              SizedBox(width: 16.0),
                              Text(AppLocalization.of(context)
                                  .lookup(action.toString())),
                            ],
                          ),
                          value: action,
                        ))
                    .toList(),
                onSelected: (action) => onActionPressed(context, action),
                enabled: isEnabled,
              )
          ],
          bottom: appBarBottom,
        ),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
