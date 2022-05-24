// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:overflow_view/overflow_view.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/account_management_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
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
        !state.isSaving &&
        (entity?.isEditable ?? true);
    bool isCancelEnabled = false;
    String upgradeMessage = state.userCompany.isOwner
        ? (state.account.trialStarted.isEmpty
            ? localization.startFreeTrialMessage
            : localization.upgradeToPaidPlan)
        : localization.ownerUpgradeToPaidPlan;
    if (state.account.isTrial) {
      final trialStarted = convertSqlDateToDateTime(state.account.trialStarted);
      final trialEnds = trialStarted.add(Duration(days: 14));
      final countDays = trialEnds.difference(DateTime.now()).inDays;

      if (countDays <= 1) {
        upgradeMessage = localization.freeTrialEndsToday;
      } else {
        upgradeMessage = localization.freeTrialEndsInDays
            .replaceFirst(':count', countDays.toString());
      }
    }

    if (!state.isProPlan || state.account.isTrial) {
      if (kAdvancedSettings.contains(state.uiState.baseSubRoute)) {
        showUpgradeBanner = true;
        if (!state.isProPlan && !state.account.isTrial && isEnabled) {
          isCancelEnabled = true;
          isEnabled = false;
        }
      } else if (state.uiState.currentRoute == AccountManagementScreen.route) {
        showUpgradeBanner = true;
      }
    } else if (kSettingsCompanyGatewaysEdit
        .contains(state.uiState.baseSubRoute)) {
      isCancelEnabled = true;
    }

    final entityActions = <EntityAction>[
      if (isDesktop(context)) EntityAction.back,
      EntityAction.save,
      ...(actions ?? []),
    ];

    final textStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        .copyWith(color: state.headerTextColor);

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: FocusTraversalGroup(
        child: Scaffold(
          body: state.companies.isEmpty
              ? LoadingIndicator()
              : showUpgradeBanner
                  ? Column(
                      children: [
                        InkWell(
                          child: IconMessage(
                            upgradeMessage,
                            color: Colors.orange,
                          ),
                          onTap: state.userCompany.isOwner && !isApple()
                              ? () async {
                                  launch(state.userCompany.ninjaPortalUrl);
                                }
                              : null,
                        ),
                        Expanded(child: body),
                      ],
                    )
                  : body,
          drawer: isDesktop(context) ? MenuDrawerBuilder() : null,
          appBar: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: isMobile(context),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title),
                if (isDesktop(context) && entity != null && entity.isOld) ...[
                  SizedBox(width: 16),
                  EntityStatusChip(
                      entity: state.getEntity(entity.entityType, entity.id)),
                ],
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: OverflowView.flexible(
                        spacing: 8,
                        children:
                            entityActions.where((action) => action != null).map(
                          (action) {
                            return OutlinedButton(
                              /*
                              child: IconText(
                                icon: getEntityActionIcon(action),
                                text: localization.lookup('$action'),
                                style: textStyle,
                              ),
                              */
                              child: Text(action == EntityAction.save &&
                                      saveLabel != null
                                  ? saveLabel
                                  : localization.lookup('$action')),
                              onPressed: () {
                                if (action == EntityAction.back) {
                                  if (onCancelPressed != null) {
                                    onCancelPressed(context);
                                  } else {
                                    store.dispatch(ResetSettings());
                                  }
                                } else if (action == EntityAction.save) {
                                  // Clear focus now to prevent un-focus after save from
                                  // marking the form as changed and to hide the keyboard
                                  FocusScope.of(context).unfocus(
                                      disposition: UnfocusDisposition
                                          .previouslyFocusedChild);

                                  onSavePressed(context);
                                } else {
                                  handleEntitiesActions([entity], action);
                                }
                              },
                            );
                          },
                        ).toList(),
                        builder: (context, remaining) {
                          return PopupMenuButton<EntityAction>(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  Text(
                                    localization.more,
                                    style: textStyle,
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_drop_down,
                                      color: state.headerTextColor),
                                ],
                              ),
                            ),
                            onSelected: (EntityAction action) {
                              handleEntitiesActions([entity], action);
                            },
                            itemBuilder: (BuildContext context) {
                              return entityActions
                                  .toList()
                                  .sublist(entityActions.length - remaining - 1)
                                  .where((action) => action != null)
                                  .map((action) {
                                return PopupMenuItem<EntityAction>(
                                  value: action,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(getEntityActionIcon(action),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      SizedBox(width: 16.0),
                                      Text(AppLocalization.of(context)
                                              .lookup(action.toString()) ??
                                          ''),
                                    ],
                                  ),
                                );
                              }).toList();
                            },
                          );
                        }),
                  ),
                )
              ],
            ),
            bottom: isFullscreen && isDesktop(context) ? null : appBarBottom,
          ),
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: floatingActionButton,
        ),
      ),
    );
  }
}
