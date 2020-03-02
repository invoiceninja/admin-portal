import 'dart:async';
import 'package:invoiceninja_flutter/data/models/credit_model.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_list.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';

class CreditListBuilder extends StatelessWidget {
  const CreditListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreditListVM>(
      converter: CreditListVM.fromStore,
      builder: (context, viewModel) {
        return CreditList(
          viewModel: viewModel,
        );
      },
    );
  }
}

class CreditListVM {
  CreditListVM({
    @required this.userCompany,
    @required this.creditList,
    @required this.creditMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onCreditTap,
    @required this.listState,
    @required this.onRefreshed,
    @required this.onEntityAction,
    @required this.tableColumns,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
  });

  static CreditListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadCredits(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return CreditListVM(
      userCompany: state.userCompany,
      listState: state.creditListState,
      creditList: memoizedFilteredCreditList(
          state.creditState.map, state.creditState.list, state.creditListState),
      creditMap: state.creditState.map,
      isLoading: state.isLoading,
      isLoaded: state.creditState.isLoaded,
      filter: state.creditUIState.listUIState.filter,
      onClearEntityFilterPressed: () => store.dispatch(FilterCreditsByEntity()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.creditListState.filterEntityId,
          entityType: state.creditListState.filterEntityType),
      onCreditTap: (context, credit) {
        if (store.state.creditListState.isInMultiselect()) {
          handleCreditAction(context, [credit], EntityAction.toggleMultiselect);
        } else {
          viewEntity(context: context, entity: credit);
        }
      },
      onEntityAction: (BuildContext context, List<BaseEntity> credits,
              EntityAction action) =>
          handleCreditAction(context, credits, action),
      onRefreshed: (context) => _handleRefresh(context),
    );
  }

  final UserCompanyEntity userCompany;
  final List<String> creditList;
  final BuiltMap<String, InvoiceEntity> creditMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, InvoiceEntity) onCreditTap;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
  final List<String> tableColumns;
}
