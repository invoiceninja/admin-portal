import 'dart:async';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_screen.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/data/models/credit_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/credit/view/credit_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CreditViewScreen extends StatelessWidget {
  const CreditViewScreen({Key key}) : super(key: key);
  static const String route = '/credit/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreditViewVM>(
      converter: (Store<AppState> store) {
        return CreditViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return CreditView(
          viewModel: vm,
        );
      },
    );
  }
}

class CreditViewVM {
  CreditViewVM({
    @required this.state,
    @required this.credit,
    @required this.company,
    @required this.onEntityAction,
    @required this.onRefreshed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory CreditViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final credit = state.creditState.map[state.creditUIState.selectedId] ??
        InvoiceEntity(id: state.creditUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadCredit(completer: completer, creditId: credit.id));
      return completer.future;
    }

    return CreditViewVM(
      state: state,
      company: state.selectedCompany,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: credit.isNew,
      credit: credit,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleCreditAction(context, credit, action),
    );
  }

  final AppState state;
  final InvoiceEntity credit;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
