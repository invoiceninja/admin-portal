import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
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

    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.history),
        ),
      ),
    );
  }
}
