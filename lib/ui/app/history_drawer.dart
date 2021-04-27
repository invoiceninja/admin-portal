import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/live_text.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';

class HistoryDrawer extends StatelessWidget {
  const HistoryDrawer({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final AppDrawerVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    final widgets = <Widget>[];
    for (var history in state.historyList) {
      widgets.add(HistoryListTile(
        history: history,
      ));
    }

    return SizedBox(
      width: kDrawerWidth,
      child: Drawer(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Text(localization.history),
            actions: <Widget>[
              if (state.prefState.isHistoryFloated)
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              else
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    store.dispatch(
                        UpdateUserPreferences(sidebar: AppSidebar.history));
                  },
                )
            ],
          ),
          body: ColoredBox(
            color: Theme.of(context).cardColor,
            child: ScrollableListView(
              children: widgets,
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryListTile extends StatefulWidget {
  const HistoryListTile({@required this.history});

  final HistoryRecord history;

  @override
  _HistoryListTileState createState() => _HistoryListTileState();
}

class _HistoryListTileState extends State<HistoryListTile> {
  //bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    final history = widget.history;

    Widget title;
    Widget subtitle;
    String clientId;
    BaseEntity entity;

    if ([
      EntityType.dashboard,
      EntityType.reports,
      EntityType.settings,
    ].contains(history.entityType)) {
      title = Text(localization.lookup(history.entityType.toString()));
      if (history.entityType == EntityType.reports) {
        subtitle =
            Text(localization.lookup(state.uiState.reportsUIState.report));
      } else if (history.entityType == EntityType.settings) {
        subtitle =
            Text(localization.lookup(history.id ?? kSettingsCompanyDetails));
      }
    } else {
      entity = state.getEntityMap(history.entityType)[history.id] as BaseEntity;

      if (entity == null || !entity.isActive) {
        return SizedBox();
      }

      if (entity is BelongsToClient) {
        clientId = (entity as BelongsToClient).clientId;
      }

      title = Text(entity.listDisplayName.isEmpty
          ? formatNumber(entity.listDisplayAmount, context,
              formatNumberType: entity.listDisplayAmountType,
              clientId: clientId)
          : entity.listDisplayName);

      subtitle = Text(localization.lookup('${history.entityType}'));
    }

    return Container(
      //onEnter: (event) => setState(() => _isHovered = true),
      //onExit: (event) => setState(() => _isHovered = false),
      child: ListTile(
        key: ValueKey('__${history.id}_${history.entityType}__'),
        leading: Icon(getEntityIcon(history.entityType)),
        title: title,
        subtitle: subtitle,
        // TODO this needs to be localized
        trailing: LiveText(
          () => timeago.format(history.dateTime, locale: 'en_short'),
          duration: Duration(minutes: 1),
        ),
        /*
        trailing: _isHovered
            ? ActionMenuButton(
                entityActions: entity.getActions(
                    userCompany: state.userCompany, includeEdit: true),
                isSaving: false,
                entity: entity,
                onSelected: (context, action) {
                  print('selected $action');
                  switch (history.entityType) {
                    case EntityType.client:
                      handleClientAction(context, [entity], action);
                      break;
                    case EntityType.product:
                      handleProductAction(context, [entity], action);
                      break;
                    case EntityType.invoice:
                      handleInvoiceAction(context, [entity], action);
                      break;
                    case EntityType.payment:
                      handlePaymentAction(context, [entity], action);
                      break;
                    case EntityType.task:
                      handleTaskAction(context, [entity], action);
                      break;
                    case EntityType.expense:
                      handleExpenseAction(context, [entity], action);
                      break;
                    case EntityType.project:
                      handleProjectAction(context, [entity], action);
                      break;
                  }
                },
              )
            : LiveText(
                () => timeago.format(history.dateTime, locale: 'en_short'),
                duration: Duration(minutes: 1),
              ),

         */
        onTap: () {
          if (state.prefState.isHistoryFloated) {
            Navigator.pop(context);
          }
          switch (history.entityType) {
            case EntityType.dashboard:
              store.dispatch(ViewDashboard());
              break;
            case EntityType.reports:
              store.dispatch(ViewReports());
              break;
            case EntityType.settings:
              store.dispatch(ViewSettings(
                section: history.id,
                company: state.company,
              ));
              break;
            default:
              viewEntityById(
                appContext: context.getAppContext(),
                entityId: history.id,
                entityType: history.entityType,
              );
          }
        },
        onLongPress: entity == null
            ? null
            : () {
                showEntityActionsDialog(
                  context: context,
                  entities: [entity],
                  completer: state.prefState.isHistoryFloated
                      ? (Completer<Null>()
                        ..future.then((value) {
                          Navigator.pop(context);
                        }))
                      : null,
                );
              },
      ),
    );
  }
}
