import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
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
    for (var history in state.uiState.historyList) {
      if (widgets.length > 50) {
        break;
      }

      final entity = state.getEntityMap(history.entityType)[history.id];

      if (entity == null) {
        continue;
      }

      widgets.add(ListTile(
        key: ValueKey('__${history.id}_${history.entityType}__'),
        leading: Icon(getEntityIcon(history.entityType)),
        title: Text(entity.listDisplayName),
        subtitle: Text(localization.lookup('${history.entityType}')),
        // TODO this needs to be localized
        trailing: Text(timeago.format(history.dateTime, locale: 'en_short')),
        onTap: () => viewEntityById(
            context: context,
            entityId: history.id,
            entityType: history.entityType),
        onLongPress: () => editEntityById(
            context: context,
            entityId: history.id,
            entityType: history.entityType),
      ));
    }

    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(localization.history),
          actions: <Widget>[
            if (state.uiState.isHistoryFloated)
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
          ],
        ),
        body: ListView(
          children: widgets,
        ),
      ),
    );
  }
}
