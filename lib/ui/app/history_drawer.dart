import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
          children: state.uiState.historyList.map((history) {
            final entity = state.getEntityMap(history.entityType)[history.id];
            return ListTile(
              leading: Icon(getEntityIcon(history.entityType)),
              title: Text(entity.listDisplayName),
            );
          }).toList(),
        ),
      ),
    );
  }
}
