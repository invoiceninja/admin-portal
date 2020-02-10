import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:redux/redux.dart';

import 'reports_screen.dart';

class ReportsScreenBuilder extends StatelessWidget {
  const ReportsScreenBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ReportsScreenVM>(
      converter: ReportsScreenVM.fromStore,
      builder: (context, vm) {
        return ReportsScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class ReportsScreenVM {
  ReportsScreenVM({@required this.state});

  final AppState state;
  static ReportsScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return ReportsScreenVM(
      state: state,
    );
  }
}
