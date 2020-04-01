import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/live_text.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

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
                FlatButton(
                  child: Text(
                    localization.close,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    store.dispatch(
                        UserSettingsChanged(sidebar: AppSidebar.history));
                  },
                )
            ],
          ),
          body: ListView(
            children: widgets,
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
        var section = state.uiState.settingsUIState.section;
        section = section.replaceAll('_edit', '').replaceAll('_view', '');
        subtitle = Text(localization.lookup(section));
      }
    } else {
      entity = state.getEntityMap(history.entityType)[history.id] as BaseEntity;

      if (entity == null) {
        return SizedBox();
      }

      switch (history.entityType) {
        case EntityType.invoice:
          clientId = (entity as InvoiceEntity).clientId;
          break;
        case EntityType.payment:
          clientId = (entity as PaymentEntity).clientId;
          break;
        case EntityType.task:
          clientId = (entity as TaskEntity).clientId;
          break;
        case EntityType.expense:
          clientId = (entity as ExpenseEntity).clientId;
          break;
        case EntityType.project:
          clientId = (entity as ProjectEntity).clientId;
          break;
      }

      title = Text(entity.listDisplayName.isEmpty
          ? formatNumber(entity.listDisplayAmount, context,
              formatNumberType: entity.listDisplayAmountType)
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
              store.dispatch(ViewDashboard(navigator: Navigator.of(context)));
              break;
            case EntityType.reports:
              store.dispatch(ViewReports(navigator: Navigator.of(context)));
              break;
            case EntityType.settings:
              store.dispatch(ViewSettings(navigator: Navigator.of(context)));
              break;
            default:
              viewEntityById(
                  context: context,
                  entityId: history.id,
                  entityType: history.entityType);
          }
        },
        onLongPress: entity == null
            ? null
            : () {
                showEntityActionsDialog(
                  context: context,
                  entities: [entity],
                  client: state.clientState.map[clientId],
                  completer: state.prefState.isHistoryFloated
                      ? (Completer<Null>()
                        ..future.then((value) => Navigator.pop(context)))
                      : null,
                );
              },
      ),
    );
  }
}
